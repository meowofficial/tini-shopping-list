import '../../../../flow_states/shopping_list_item_editing_flow_state.dart';
import '../../refs/shopping_list_item_editing_flow_state_ref.dart';

abstract interface class ShoppingListItemEditingFlowStateRefFactory {
  ShoppingListItemEditingFlowStateRef call(ShoppingListItemEditingFlowState flowState);
}
