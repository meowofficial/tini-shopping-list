import 'dart:async';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import '../../../../../../core/interface_adapters/presentation/base_view_streamable_presenter.dart';
import '../../../../application/refs/flow_state_refs/shopping_list_overview_flow_state_ref.dart';
import '../../../../application/use_cases/read_shopping_list_overview_flow_state.dart';
import '../../../../application/use_cases/watch_shopping_list_overview_flow_state.dart';
import '../interfaces/shopping_list_item_presenter.dart';
import '../interfaces/shopping_list_item_presenter_factory.dart';
import '../interfaces/shopping_list_overview_screen_state_presenters.dart';
import '../views/shopping_list_overview_screen_state_views.dart';

class ShoppingListOverviewScreenLoadedStatePresenterImpl
    extends BaseViewStreamablePresenter<ShoppingListOverviewScreenLoadedStateView>
    implements ShoppingListOverviewScreenLoadedStatePresenter {
  ShoppingListOverviewScreenLoadedStatePresenterImpl({
    required ShoppingListItemPresenterFactory shoppingListItemPresenterFactory,
    required ReadShoppingListOverviewFlowState readShoppingListOverviewFlowState,
    required WatchShoppingListOverviewFlowState watchShoppingListOverviewFlowState,
  }) : _shoppingListItemPresenterFactory = shoppingListItemPresenterFactory,
       _readShoppingListOverviewFlowState = readShoppingListOverviewFlowState,
       _watchShoppingListOverviewFlowState = watchShoppingListOverviewFlowState {
    _shoppingListItemViewPresenterStreamController =
        StreamController<IList<ShoppingListItemPresenter>>.broadcast();

    final shoppingListOverviewFlowState =
        _readShoppingListOverviewFlowState() as LoadedShoppingListOverviewFlowStateRef;

    _shoppingListItemViewPresenters = shoppingListOverviewFlowState.shoppingListItemRefs
        .map<ShoppingListItemPresenter>((shoppingListItemRef) {
          return _shoppingListItemPresenterFactory.create(
            shoppingListItemRef: shoppingListItemRef,
          );
        })
        .toIList();

    _shoppingListOverviewFlowStateStreamSubscription = _watchShoppingListOverviewFlowState().listen(
      _onShoppingListOverviewFlowStateChanged,
    );

    const view = ShoppingListOverviewScreenLoadedStateView();

    initializeView(view);
  }

  final ShoppingListItemPresenterFactory _shoppingListItemPresenterFactory;

  final ReadShoppingListOverviewFlowState _readShoppingListOverviewFlowState;
  final WatchShoppingListOverviewFlowState _watchShoppingListOverviewFlowState;

  late final StreamController<IList<ShoppingListItemPresenter>>
  _shoppingListItemViewPresenterStreamController;

  late final StreamSubscription<ShoppingListOverviewFlowStateRef>
  _shoppingListOverviewFlowStateStreamSubscription;
  late IList<ShoppingListItemPresenter> _shoppingListItemViewPresenters;

  @override
  IList<ShoppingListItemPresenter> get shoppingListItemViewPresenters =>
      _shoppingListItemViewPresenters;

  @override
  Stream<IList<ShoppingListItemPresenter>> get shoppingListItemViewPresenterStream =>
      _shoppingListItemViewPresenterStreamController.stream;

  void _onShoppingListOverviewFlowStateChanged(
    ShoppingListOverviewFlowStateRef shoppingListOverviewFlowStateRef,
  ) {
    if (shoppingListOverviewFlowStateRef is! LoadedShoppingListOverviewFlowStateRef) {
      return;
    }

    final shoppingListItemRefs = shoppingListOverviewFlowStateRef.shoppingListItemRefs;

    final existingPresenterMap = Map.fromEntries(
      _shoppingListItemViewPresenters.map((it) {
        return MapEntry(it.shoppingListItemId, it);
      }),
    );

    final updatedPresenters = <ShoppingListItemPresenter>[];

    for (final shoppingListItemRef in shoppingListItemRefs) {
      final shoppingListItemId = shoppingListItemRef.snapshot.id;

      final correspondingPresenter = existingPresenterMap.remove(shoppingListItemId);

      if (correspondingPresenter == null) {
        final presenter = _shoppingListItemPresenterFactory.create(
          shoppingListItemRef: shoppingListItemRef,
        );

        updatedPresenters.add(presenter);
      } else {
        updatedPresenters.add(correspondingPresenter);
      }
    }

    for (final presenter in existingPresenterMap.values) {
      presenter.dispose();
    }

    _shoppingListItemViewPresenters = updatedPresenters.lock;
    _shoppingListItemViewPresenterStreamController.add(_shoppingListItemViewPresenters);
  }

  @override
  void dispose() {
    for (final presenter in _shoppingListItemViewPresenters) {
      presenter.dispose();
    }

    _shoppingListOverviewFlowStateStreamSubscription.cancel();

    _shoppingListItemViewPresenterStreamController.close();

    super.dispose();
  }
}
