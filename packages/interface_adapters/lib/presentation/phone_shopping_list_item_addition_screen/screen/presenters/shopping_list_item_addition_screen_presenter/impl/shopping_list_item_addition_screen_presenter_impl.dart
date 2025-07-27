import 'dart:async';

import 'package:application/shopping_list/use_cases/read_shopping_list_item_addition_flow_state/read_shopping_list_item_addition_flow_state.dart';
import 'package:application/shopping_list/use_cases/shared/refs/shopping_list_item_addition_flow_state_ref.dart';
import 'package:application/shopping_list/use_cases/watch_shopping_list_item_addition_flow_state/watch_shopping_list_item_addition_flow_state.dart';
import 'package:common/stream/with_previous_stream.dart';
import 'package:common/typedefs/value_with_previous.dart';

import '../../../../../core/base_update_streamable_presenter.dart';
import '../../../factories/shopping_list_item_addition_screen_state_presenter_factory/shopping_list_item_addition_screen_state_presenter_factory.dart';
import '../../shopping_list_item_addition_screen_state_presenter/shopping_list_item_addition_screen_state_presenter.dart';
import '../shopping_list_item_addition_screen_presenter.dart';

class ShoppingListItemAdditionScreenPresenterImpl extends BaseUpdateStreamablePresenter
    implements ShoppingListItemAdditionScreenPresenter {
  ShoppingListItemAdditionScreenPresenterImpl({
    required ShoppingListItemAdditionScreenStatePresenterFactory
    shoppingListItemAdditionScreenStatePresenterFactory,
    required ReadShoppingListItemAdditionFlowState readShoppingListItemAdditionFlowState,
    required WatchShoppingListItemAdditionFlowState watchShoppingListItemAdditionFlowState,
  }) : _shoppingListItemAdditionScreenStatePresenterFactory =
           shoppingListItemAdditionScreenStatePresenterFactory,
       _readShoppingListItemAdditionFlowState = readShoppingListItemAdditionFlowState,
       _watchShoppingListItemAdditionFlowState = watchShoppingListItemAdditionFlowState {
    final shoppingListItemAdditionFlowStateRef = _readShoppingListItemAdditionFlowState();

    _currentStatePresenter = _shoppingListItemAdditionScreenStatePresenterFactory.create(
      shoppingListItemAdditionFlowStateRef: shoppingListItemAdditionFlowStateRef,
    );

    _shoppingListItemAdditionFlowStateStreamSubscription = _watchShoppingListItemAdditionFlowState()
        .withPreviousSeeded(shoppingListItemAdditionFlowStateRef)
        .listen(
          _onShoppingListItemAdditionFlowStateChanged,
        );
  }

  final ShoppingListItemAdditionScreenStatePresenterFactory
  _shoppingListItemAdditionScreenStatePresenterFactory;

  final ReadShoppingListItemAdditionFlowState _readShoppingListItemAdditionFlowState;
  final WatchShoppingListItemAdditionFlowState _watchShoppingListItemAdditionFlowState;

  late ShoppingListItemAdditionScreenStatePresenter _currentStatePresenter;

  late final StreamSubscription<ValueWithPrevious<ShoppingListItemAdditionFlowStateRef>>
  _shoppingListItemAdditionFlowStateStreamSubscription;

  @override
  ShoppingListItemAdditionScreenStatePresenter get currentStatePresenter => _currentStatePresenter;

  void _onShoppingListItemAdditionFlowStateChanged(
    ValueWithPrevious<ShoppingListItemAdditionFlowStateRef> valueWithPrevious,
  ) {
    final (
      currentShoppingListItemAdditionFlowStateRef,
      previousShoppingListItemAdditionFlowStateRef,
    ) = valueWithPrevious;

    if (currentShoppingListItemAdditionFlowStateRef.runtimeType ==
        previousShoppingListItemAdditionFlowStateRef.runtimeType) {
      return;
    }

    _currentStatePresenter.dispose();

    _currentStatePresenter = _shoppingListItemAdditionScreenStatePresenterFactory.create(
      shoppingListItemAdditionFlowStateRef: currentShoppingListItemAdditionFlowStateRef,
    );

    emitUpdate();
  }

  @override
  void dispose() {
    _shoppingListItemAdditionFlowStateStreamSubscription.cancel();
    super.dispose();
  }
}
