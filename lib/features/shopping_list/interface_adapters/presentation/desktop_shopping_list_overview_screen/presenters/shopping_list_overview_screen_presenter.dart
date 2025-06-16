import 'dart:async';

import '../../../../../../core/common/stream/with_previous_stream.dart';
import '../../../../../../core/common/typedefs/value_with_previous.dart';
import '../../../../application/refs/flow_state_refs/shopping_list_overview_flow_state_ref.dart';
import '../../../../application/use_cases/load_shopping_list_items.dart';
import '../../../../application/use_cases/read_shopping_list_overview_flow_state.dart';
import '../../../../application/use_cases/start_shopping_list_item_addition.dart';
import '../../../../application/use_cases/toggle_shopping_list_item_check.dart';
import '../../../../application/use_cases/watch_shopping_list_overview_flow_state.dart';
import '../interfaces/shopping_list_overview_screen_presenter.dart';
import '../interfaces/shopping_list_overview_screen_state_presenters.dart';
import 'shopping_list_overview_screen_loaded_state_presenter.dart';
import 'shopping_list_overview_screen_loading_state_presenter.dart';

class ShoppingListOverviewScreenPresenterImpl implements ShoppingListOverviewScreenPresenter {
  ShoppingListOverviewScreenPresenterImpl({
    required LoadShoppingListItems loadShoppingListItems,
    required ReadShoppingListOverviewFlowState readShoppingListOverviewFlowState,
    required StartShoppingListItemAddition startShoppingListItemAddition,
    required ToggleShoppingListItemCheck toggleShoppingListItemCheck,
    required WatchShoppingListOverviewFlowState watchShoppingListOverviewFlowState,
  }) : _loadShoppingListItems = loadShoppingListItems,
       _readShoppingListOverviewFlowState = readShoppingListOverviewFlowState,
       _startShoppingListItemAddition = startShoppingListItemAddition,
       _toggleShoppingListItemCheck = toggleShoppingListItemCheck,
       _watchShoppingListOverviewFlowState = watchShoppingListOverviewFlowState {
    _updateStreamController = StreamController<void>.broadcast();

    final shoppingListOverviewFlowStateRef = _readShoppingListOverviewFlowState();

    _currentViewPresenter = _createCurrentViewPresenter(
      shoppingListOverviewFlowStateRef: shoppingListOverviewFlowStateRef,
    );

    if (shoppingListOverviewFlowStateRef is InitialShoppingListOverviewFlowStateRef) {
      _loadShoppingListItems();
    }

    _shoppingListOverviewFlowStateStreamSubscription = _watchShoppingListOverviewFlowState()
        .withPreviousSeeded(shoppingListOverviewFlowStateRef)
        .listen(
          _onShoppingListOverviewFlowStateChanged,
        );
  }

  final LoadShoppingListItems _loadShoppingListItems;
  final ReadShoppingListOverviewFlowState _readShoppingListOverviewFlowState;
  final StartShoppingListItemAddition _startShoppingListItemAddition;
  final ToggleShoppingListItemCheck _toggleShoppingListItemCheck;
  final WatchShoppingListOverviewFlowState _watchShoppingListOverviewFlowState;

  late ShoppingListOverviewScreenStatePresenter _currentViewPresenter;

  late final StreamController<void> _updateStreamController;
  late final StreamSubscription<ValueWithPrevious<ShoppingListOverviewFlowStateRef>>
  _shoppingListOverviewFlowStateStreamSubscription;

  @override
  ShoppingListOverviewScreenStatePresenter get currentViewPresenter => _currentViewPresenter;

  @override
  Stream<void> get updateStream => _updateStreamController.stream;

  ShoppingListOverviewScreenStatePresenter _createCurrentViewPresenter({
    required ShoppingListOverviewFlowStateRef shoppingListOverviewFlowStateRef,
  }) {
    switch (shoppingListOverviewFlowStateRef) {
      case InitialShoppingListOverviewFlowStateRef():
      case LoadingShoppingListOverviewFlowStateRef():
        return ShoppingListOverviewScreenLoadingStatePresenterImpl();

      case LoadedShoppingListOverviewFlowStateRef():
        return ShoppingListOverviewScreenLoadedStatePresenterImpl(
          readShoppingListOverviewFlowState: _readShoppingListOverviewFlowState,
          watchShoppingListOverviewFlowState: _watchShoppingListOverviewFlowState,
          startShoppingListItemAddition: _startShoppingListItemAddition,
          toggleShoppingListItemCheck: _toggleShoppingListItemCheck,
        );
    }
  }

  void _onShoppingListOverviewFlowStateChanged(
    ValueWithPrevious<ShoppingListOverviewFlowStateRef> valueWithPrevious,
  ) {
    final (
      currentShoppingListOverviewFlowStateRef,
      previousShoppingListOverviewFlowStateRef,
    ) = valueWithPrevious;

    if (currentShoppingListOverviewFlowStateRef.runtimeType ==
        previousShoppingListOverviewFlowStateRef.runtimeType) {
      return;
    }

    _currentViewPresenter.dispose();

    _currentViewPresenter = _createCurrentViewPresenter(
      shoppingListOverviewFlowStateRef: currentShoppingListOverviewFlowStateRef,
    );

    _updateStreamController.add(null);
  }

  @override
  void dispose() {
    _shoppingListOverviewFlowStateStreamSubscription.cancel();
    _updateStreamController.close();
  }
}
