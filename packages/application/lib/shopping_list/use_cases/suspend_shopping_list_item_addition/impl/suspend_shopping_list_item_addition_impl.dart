import 'package:common/errors/unexpected_state_error.dart';
import 'package:injectable/injectable.dart';

import '../../../flow_states/shopping_list_item_addition_flow_state.dart';
import '../../../stores/shopping_list_flow_store/shopping_list_flow_store.dart';
import '../suspend_shopping_list_item_addition.dart';

@LazySingleton(as: SuspendShoppingListItemAddition)
class SuspendShoppingListItemAdditionImpl implements SuspendShoppingListItemAddition {
  const SuspendShoppingListItemAdditionImpl({
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

    final updatedShoppingListItemAdditionFlowState = SuspendedShoppingListItemAdditionFlowState(
      newShoppingListDraftItem: newShoppingListDraftItem,
    );

    _shoppingListFlowStore.updateWith(
      shoppingListItemAdditionFlowState: () => updatedShoppingListItemAdditionFlowState,
    );
  }
}
