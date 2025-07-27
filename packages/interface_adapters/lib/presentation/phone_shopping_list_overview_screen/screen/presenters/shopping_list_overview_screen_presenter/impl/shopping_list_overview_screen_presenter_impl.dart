import 'dart:async';

import 'package:application/shopping_list/use_cases/load_shopping_list_items/load_shopping_list_items.dart';
import 'package:application/shopping_list/use_cases/read_shopping_list_overview_flow_state/read_shopping_list_overview_flow_state.dart';
import 'package:application/shopping_list/use_cases/shared/refs/shopping_list_overview_flow_state_ref.dart';
import 'package:application/shopping_list/use_cases/watch_shopping_list_overview_flow_state/watch_shopping_list_overview_flow_state.dart';
import 'package:common/stream/with_previous_stream.dart';
import 'package:common/typedefs/value_with_previous.dart';

import '../../../../../core/base_update_streamable_presenter.dart';
import '../../../factories/shopping_list_overview_screen_state_presenter_factory/shopping_list_overview_screen_state_presenter_factory.dart';
import '../../shopping_list_overview_screen_state_presenter/shopping_list_overview_screen_state_presenter.dart';
import '../shopping_list_overview_screen_presenter.dart';

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
