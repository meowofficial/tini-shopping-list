import 'package:common/errors/unexpected_state_error.dart';
import 'package:injectable/injectable.dart';

import '../../../flow_states/shopping_list_item_editing_flow_state.dart';
import '../../../stores/shopping_list_flow_store/shopping_list_flow_store.dart';
import '../cancel_shopping_list_item_editing.dart';

@LazySingleton(as: CancelShoppingListItemEditing)
class CancelShoppingListItemEditingImpl implements CancelShoppingListItemEditing {
  const CancelShoppingListItemEditingImpl({
    required ShoppingListFlowStore shoppingListFlowStore,
  }) : _shoppingListFlowStore = shoppingListFlowStore;

  final ShoppingListFlowStore _shoppingListFlowStore;

  @override
  void call() {
    final shoppingListItemEditingFlowState =
        _shoppingListFlowStore.state.shoppingListItemEditingFlowState;

    if (shoppingListItemEditingFlowState is! OngoingShoppingListItemEditingFlowState) {
      throwStateError();
    }

    final existingShoppingListDraftItem =
        shoppingListItemEditingFlowState.existingShoppingListDraftItem;

    existingShoppingListDraftItem.dispose();

    const updatedShoppingListItemEditingFlowState = IdleShoppingListItemEditingFlowState();

    _shoppingListFlowStore.updateWith(
      shoppingListItemEditingFlowState: () => updatedShoppingListItemEditingFlowState,
    );
  }
}
