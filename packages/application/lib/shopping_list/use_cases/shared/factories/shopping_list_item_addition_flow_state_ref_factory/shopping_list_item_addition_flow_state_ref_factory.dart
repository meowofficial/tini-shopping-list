import '../../../../flow_states/shopping_list_item_addition_flow_state.dart';
import '../../refs/shopping_list_item_addition_flow_state_ref.dart';

abstract interface class ShoppingListItemAdditionFlowStateRefFactory {
  ShoppingListItemAdditionFlowStateRef call(ShoppingListItemAdditionFlowState flowState);
}
