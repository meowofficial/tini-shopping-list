import 'dart:async';

import '../../../../../../../core/common/stream/with_previous_stream.dart';
import '../../../../../../../core/common/typedefs/value_with_previous.dart';
import '../../../../../../../core/interface_adapters/presentation/base_update_streamable_presenter.dart';
import '../../../../../application/refs/flow_state_refs/shopping_list_overview_flow_state_ref.dart';
import '../../../../../application/use_cases/load_shopping_list_items.dart';
import '../../../../../application/use_cases/read_shopping_list_overview_flow_state.dart';
import '../../../../../application/use_cases/watch_shopping_list_overview_flow_state.dart';
import '../interfaces/shopping_list_overview_screen_presenter.dart';
import '../interfaces/shopping_list_overview_screen_state_presenter_factory.dart';
import '../interfaces/shopping_list_overview_screen_state_presenters.dart';

class ShoppingListOverviewScreenPresenterImpl extends BaseUpdateStreamablePresenter
    implements ShoppingListOverviewScreenPresenter {
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
    final shoppingListOverviewFlowStateRef = _readShoppingListOverviewFlowState();

    _currentStatePresenter = _shoppingListOverviewScreenStatePresenterFactory.create(
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

  late ShoppingListOverviewScreenStatePresenter _currentStatePresenter;

  late final StreamSubscription<ValueWithPrevious<ShoppingListOverviewFlowStateRef>>
  _shoppingListOverviewFlowStateStreamSubscription;

  @override
  ShoppingListOverviewScreenStatePresenter get currentStatePresenter => _currentStatePresenter;

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

    _currentStatePresenter.dispose();

    _currentStatePresenter = _shoppingListOverviewScreenStatePresenterFactory.create(
      shoppingListOverviewFlowStateRef: currentShoppingListOverviewFlowStateRef,
    );

    emitUpdate();
  }

  @override
  void dispose() {
    _shoppingListOverviewFlowStateStreamSubscription.cancel();
    super.dispose();
  }
}
