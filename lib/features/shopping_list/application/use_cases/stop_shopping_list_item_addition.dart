import 'package:injectable/injectable.dart';

import '../../../../core/common/errors/unexpected_state_error.dart';
import '../flow_states/shopping_list_item_addition_flow_state.dart';
import '../stores/shopping_list_flow_store.dart';

abstract interface class StopShoppingListItemAddition {
  void call();
}

@LazySingleton(as: StopShoppingListItemAddition)
class StopShoppingListItemAdditionImpl implements StopShoppingListItemAddition {
  const StopShoppingListItemAdditionImpl({
    required ShoppingListFlowStore shoppingListFlowStore,
  }) : _shoppingListFlowStore = shoppingListFlowStore;

  final ShoppingListFlowStore _shoppingListFlowStore;

  @override
  void call() {
    final shoppingListItemAdditionFlowState =
        _shoppingListFlowStore.state.shoppingListItemAdditionFlowState;

    if (shoppingListItemAdditionFlowState is! OngoingShoppingListItemAdditionFlowState) {
      throwStateError();
    }

    final newShoppingListDraftItem = shoppingListItemAdditionFlowState.newShoppingListDraftItem;

    newShoppingListDraftItem.dispose();

    const updatedShoppingListItemAdditionFlowState = IdleShoppingListItemAdditionFlowState();

    _shoppingListFlowStore.updateWith(
      shoppingListItemAdditionFlowState: () => updatedShoppingListItemAdditionFlowState,
    );
  }
}
