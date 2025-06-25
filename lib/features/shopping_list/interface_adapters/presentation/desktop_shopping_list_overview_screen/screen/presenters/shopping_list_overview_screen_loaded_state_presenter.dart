import 'dart:async';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import '../../../../../../../core/application/use_cases/read_ui_locale.dart';
import '../../../../../../../core/application/use_cases/watch_ui_locale.dart';
import '../../../../../../../core/domain/common/ui_locale.dart';
import '../../../../../../../core/interface_adapters/presentation/base_view_streamable_presenter.dart';
import '../../../../../application/refs/flow_state_refs/shopping_list_overview_flow_state_ref.dart';
import '../../../../../application/use_cases/read_shopping_list_overview_flow_state.dart';
import '../../../../../application/use_cases/start_shopping_list_item_addition.dart';
import '../../../../../application/use_cases/watch_shopping_list_overview_flow_state.dart';
import '../../shopping_list_item/interfaces/shopping_list_item_presenter.dart';
import '../../shopping_list_item/interfaces/shopping_list_item_presenter_factory.dart';
import '../interfaces/shopping_list_overview_screen_state_presenters.dart';
import '../l10n/shopping_list_overview_screen_loaded_state_view_translation.dart';
import '../views/shopping_list_overview_screen_views.dart';

class ShoppingListOverviewScreenLoadedStatePresenterImpl
    extends BaseViewStreamablePresenter<ShoppingListOverviewScreenLoadedStateView>
    implements ShoppingListOverviewScreenLoadedStatePresenter {
  ShoppingListOverviewScreenLoadedStatePresenterImpl({
    required ShoppingListOverviewScreenLoadedStateViewTranslation translation,
    required ShoppingListItemPresenterFactory shoppingListItemPresenterFactory,
    required ReadShoppingListOverviewFlowState readShoppingListOverviewFlowState,
    required ReadUiLocale readUiLocale,
    required StartShoppingListItemAddition startShoppingListItemAddition,
    required WatchShoppingListOverviewFlowState watchShoppingListOverviewFlowState,
    required WatchUiLocale watchUiLocale,
  }) : _translation = translation,
       _shoppingListItemPresenterFactory = shoppingListItemPresenterFactory,
       _readShoppingListOverviewFlowState = readShoppingListOverviewFlowState,
       _readUiLocale = readUiLocale,
       _startShoppingListItemAddition = startShoppingListItemAddition,
       _watchShoppingListOverviewFlowState = watchShoppingListOverviewFlowState,
       _watchUiLocale = watchUiLocale {
    _shoppingListItemPresenterStreamController =
        StreamController<IList<ShoppingListItemPresenter>>.broadcast();

    final uiLocale = _readUiLocale();

    _translation.setUiLocale(uiLocale);

    final shoppingListOverviewFlowState =
        _readShoppingListOverviewFlowState() as LoadedShoppingListOverviewFlowStateRef;

    _shoppingListItemPresenters = shoppingListOverviewFlowState.shoppingListItemRefs
        .map<ShoppingListItemPresenter>((shoppingListItemRef) {
          return _shoppingListItemPresenterFactory.create(
            shoppingListItemRef: shoppingListItemRef,
          );
        })
        .toIList();

    _shoppingListOverviewFlowStateStreamSubscription = _watchShoppingListOverviewFlowState().listen(
      _onShoppingListOverviewFlowStateChanged,
    );

    _uiLocaleStreamSubscription = _watchUiLocale().listen(_onUiLocaleChanged);

    final view = ShoppingListOverviewScreenLoadedStateView(
      title: _translation.title,
    );

    initializeView(view);
  }

  final ShoppingListOverviewScreenLoadedStateViewTranslation _translation;
  final ShoppingListItemPresenterFactory _shoppingListItemPresenterFactory;

  final ReadShoppingListOverviewFlowState _readShoppingListOverviewFlowState;
  final ReadUiLocale _readUiLocale;
  final StartShoppingListItemAddition _startShoppingListItemAddition;
  final WatchShoppingListOverviewFlowState _watchShoppingListOverviewFlowState;
  final WatchUiLocale _watchUiLocale;

  late IList<ShoppingListItemPresenter> _shoppingListItemPresenters;

  late final StreamController<IList<ShoppingListItemPresenter>>
  _shoppingListItemPresenterStreamController;

  late final StreamSubscription<ShoppingListOverviewFlowStateRef>
  _shoppingListOverviewFlowStateStreamSubscription;

  late final StreamSubscription<UiLocale> _uiLocaleStreamSubscription;

  @override
  IList<ShoppingListItemPresenter> get shoppingListItemPresenters => _shoppingListItemPresenters;

  @override
  Stream<IList<ShoppingListItemPresenter>> get shoppingListItemPresenterStream =>
      _shoppingListItemPresenterStreamController.stream;

  void _onShoppingListOverviewFlowStateChanged(
    ShoppingListOverviewFlowStateRef shoppingListOverviewFlowStateRef,
  ) {
    if (shoppingListOverviewFlowStateRef is! LoadedShoppingListOverviewFlowStateRef) {
      return;
    }

    final shoppingListItemRefs = shoppingListOverviewFlowStateRef.shoppingListItemRefs;

    final existingPresenterMap = Map.fromEntries(
      _shoppingListItemPresenters.map((it) {
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

    _shoppingListItemPresenters = updatedPresenters.lock;
    _shoppingListItemPresenterStreamController.add(_shoppingListItemPresenters);
  }

  void _onUiLocaleChanged(UiLocale uiLocale) {
    _translation.setUiLocale(uiLocale);

    final updatedView = view.copyWith(
      title: () => _translation.title,
    );

    emit(updatedView);
  }

  @override
  void onShoppingListItemAdditionButtonPressed() {
    _startShoppingListItemAddition();
  }

  @override
  void dispose() {
    for (final presenter in _shoppingListItemPresenters) {
      presenter.dispose();
    }

    _shoppingListOverviewFlowStateStreamSubscription.cancel();
    _uiLocaleStreamSubscription.cancel();

    _shoppingListItemPresenterStreamController.close();

    super.dispose();
  }
}
