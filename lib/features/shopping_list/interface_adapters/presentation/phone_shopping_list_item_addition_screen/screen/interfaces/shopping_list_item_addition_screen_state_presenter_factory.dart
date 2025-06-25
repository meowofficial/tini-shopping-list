import '../../../../../application/refs/flow_state_refs/shopping_list_item_addition_flow_state_ref.dart';
import '../interfaces/shopping_list_item_addition_screen_state_presenters.dart';

abstract interface class ShoppingListItemAdditionScreenStatePresenterFactory {
  ShoppingListItemAdditionScreenStatePresenter create({
    required ShoppingListItemAdditionFlowStateRef shoppingListItemAdditionFlowStateRef,
  });
}
