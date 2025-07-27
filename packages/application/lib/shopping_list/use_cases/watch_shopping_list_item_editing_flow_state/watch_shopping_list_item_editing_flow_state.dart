import '../../use_cases/shared/refs/shopping_list_item_editing_flow_state_ref.dart';

abstract interface class WatchShoppingListItemEditingFlowState {
  Stream<ShoppingListItemEditingFlowStateRef> call({
    bool sync = false,
  });
}
