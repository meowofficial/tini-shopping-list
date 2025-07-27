import '../../use_cases/shared/refs/shopping_list_item_addition_flow_state_ref.dart';

abstract interface class WatchShoppingListItemAdditionFlowState {
  Stream<ShoppingListItemAdditionFlowStateRef> call({
    bool sync = false,
  });
}
