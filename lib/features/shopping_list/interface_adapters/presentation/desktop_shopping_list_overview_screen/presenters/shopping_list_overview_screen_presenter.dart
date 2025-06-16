import 'dart:async';

import '../../../../../../core/common/stream/with_previous_stream.dart';
import '../../../../../../core/common/typedefs/value_with_previous.dart';
import '../../../../application/refs/flow_state_refs/shopping_list_overview_flow_state_ref.dart';
import '../../../../application/use_cases/load_shopping_list_items.dart';
import '../../../../application/use_cases/read_shopping_list_overview_flow_state.dart';
import '../../../../application/use_cases/watch_shopping_list_overview_flow_state.dart';
import '../interfaces/shopping_list_overview_screen_presenter.dart';
import '../interfaces/shopping_list_overview_screen_state_presenter_factory.dart';
import '../interfaces/shopping_list_overview_screen_state_presenters.dart';

class ShoppingListOverviewScreenPresenterImpl implements ShoppingListOverviewScreenPresenter {
  ShoppingListOverviewScreenPresenterImpl({
    required ShoppingListOverviewScreenStatePresenterFactory
    shoppingListOverviewScreenStatePresenterFactory,
    required LoadShoppingListItems loadShoppingListItems,
    required ReadShoppingListOverviewFlowState readShoppingListOverviewFlowState,
    required WatchShoppingListOverviewFlowState watchShoppingListOverviewFlowState,
  }) : _shoppingListOverviewScreenStatePresenterFactory =
           shoppingListOverviewScreenStatePresenterFactory,
       _loadShoppingListItems = loadShoppingListItems,
       _readShoppingListOverviewFlowState = readShoppingListOverviewFlowState,
       _watchShoppingListOverviewFlowState = watchShoppingListOverviewFlowState {
    _updateStreamController = StreamController<void>.broadcast();

    final shoppingListOverviewFlowStateRef = _readShoppingListOverviewFlowState();

    _currentViewPresenter = _shoppingListOverviewScreenStatePresenterFactory.create(
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

  final ShoppingListOverviewScreenStatePresenterFactory
  _shoppingListOverviewScreenStatePresenterFactory;

  final LoadShoppingListItems _loadShoppingListItems;
  final ReadShoppingListOverviewFlowState _readShoppingListOverviewFlowState;
  final WatchShoppingListOverviewFlowState _watchShoppingListOverviewFlowState;

  late ShoppingListOverviewScreenStatePresenter _currentViewPresenter;

  late final StreamController<void> _updateStreamController;
  late final StreamSubscription<ValueWithPrevious<ShoppingListOverviewFlowStateRef>>
  _shoppingListOverviewFlowStateStreamSubscription;

  @override
  ShoppingListOverviewScreenStatePresenter get currentViewPresenter => _currentViewPresenter;

  @override
  Stream<void> get updateStream => _updateStreamController.stream;

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

    _currentViewPresenter = _shoppingListOverviewScreenStatePresenterFactory.create(
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
