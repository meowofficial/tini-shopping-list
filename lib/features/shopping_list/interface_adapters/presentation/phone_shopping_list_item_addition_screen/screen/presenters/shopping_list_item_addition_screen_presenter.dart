import 'dart:async';

import '../../../../../../../core/common/stream/with_previous_stream.dart';
import '../../../../../../../core/common/typedefs/value_with_previous.dart';
import '../../../../../../../core/interface_adapters/presentation/base_update_streamable_presenter.dart';
import '../../../../../application/refs/flow_state_refs/shopping_list_item_addition_flow_state_ref.dart';
import '../../../../../application/use_cases/read_shopping_list_item_addition_flow_state.dart';
import '../../../../../application/use_cases/watch_shopping_list_item_addition_flow_state.dart';
import '../interfaces/shopping_list_item_addition_screen_presenter.dart';
import '../interfaces/shopping_list_item_addition_screen_state_presenter_factory.dart';
import '../interfaces/shopping_list_item_addition_screen_state_presenters.dart';

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
