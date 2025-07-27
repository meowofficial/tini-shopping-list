import '../../use_cases/shared/refs/shopping_list_overview_flow_state_ref.dart';

abstract interface class WatchShoppingListOverviewFlowState {
  Stream<ShoppingListOverviewFlowStateRef> call({
    bool sync = false,
  });
}
