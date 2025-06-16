import 'dart:async';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import '../../../../../../core/interface_adapters/presentation/base_view_presenter.dart';
import '../../../../application/refs/flow_state_refs/shopping_list_overview_flow_state_ref.dart';
import '../../../../application/use_cases/read_shopping_list_overview_flow_state.dart';
import '../../../../application/use_cases/start_shopping_list_item_addition.dart';
import '../../../../application/use_cases/toggle_shopping_list_item_check.dart';
import '../../../../application/use_cases/watch_shopping_list_overview_flow_state.dart';
import '../interfaces/shopping_list_item_presenter.dart';
import '../interfaces/shopping_list_overview_screen_state_presenters.dart';
import '../views/shopping_list_overview_screen_views.dart';
import 'shopping_list_item_presenter.dart';

class ShoppingListOverviewScreenLoadedStatePresenterImpl
    extends BaseViewPresenter<ShoppingListOverviewScreenLoadedView>
    implements ShoppingListOverviewScreenLoadedStatePresenter {
  ShoppingListOverviewScreenLoadedStatePresenterImpl({
    required ReadShoppingListOverviewFlowState readShoppingListOverviewFlowState,
    required StartShoppingListItemAddition startShoppingListItemAddition,
    required ToggleShoppingListItemCheck toggleShoppingListItemCheck,
    required WatchShoppingListOverviewFlowState watchShoppingListOverviewFlowState,
  }) : _readShoppingListOverviewFlowState = readShoppingListOverviewFlowState,
       _startShoppingListItemAddition = startShoppingListItemAddition,
       _toggleShoppingListItemCheck = toggleShoppingListItemCheck,
       _watchShoppingListOverviewFlowState = watchShoppingListOverviewFlowState {
    _shoppingListItemViewPresenterStreamController =
        StreamController<IList<ShoppingListItemPresenter>>.broadcast();

    final shoppingListOverviewFlowState =
        _readShoppingListOverviewFlowState() as LoadedShoppingListOverviewFlowStateRef;

    _shoppingListItemViewPresenters = shoppingListOverviewFlowState.shoppingListItemRefs
        .map<ShoppingListItemPresenter>((shoppingListItemRef) {
          return ShoppingListItemPresenterImpl(
            shoppingListItemRef: shoppingListItemRef,
            toggleShoppingListItemCheck: _toggleShoppingListItemCheck,
          );
        })
        .toIList();

    _shoppingListOverviewFlowStateStreamSubscription = _watchShoppingListOverviewFlowState().listen(
      _onShoppingListOverviewFlowStateChanged,
    );

    const view = ShoppingListOverviewScreenLoadedView();

    initializeView(view);
  }

  final ReadShoppingListOverviewFlowState _readShoppingListOverviewFlowState;
  final StartShoppingListItemAddition _startShoppingListItemAddition;
  final ToggleShoppingListItemCheck _toggleShoppingListItemCheck;
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
        final presenter = ShoppingListItemPresenterImpl(
          shoppingListItemRef: shoppingListItemRef,
          toggleShoppingListItemCheck: _toggleShoppingListItemCheck,
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
  void onShoppingListItemAdditionButtonPressed() {
    _startShoppingListItemAddition();
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
