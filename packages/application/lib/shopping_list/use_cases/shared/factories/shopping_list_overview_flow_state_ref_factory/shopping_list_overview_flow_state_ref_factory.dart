import '../../../../flow_states/shopping_list_overview_flow_state.dart';
import '../../refs/shopping_list_overview_flow_state_ref.dart';

abstract interface class ShoppingListOverviewFlowStateRefFactory {
  ShoppingListOverviewFlowStateRef call(ShoppingListOverviewFlowState flowState);
}
