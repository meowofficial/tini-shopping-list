import 'package:application/shopping_list/use_cases/shared/refs/shopping_list_item_addition_flow_state_ref.dart';

import '../../presenters/shopping_list_item_addition_screen_state_presenter/shopping_list_item_addition_screen_state_presenter.dart';

abstract interface class ShoppingListItemAdditionScreenStatePresenterFactory {
  ShoppingListItemAdditionScreenStatePresenter create({
    required ShoppingListItemAdditionFlowStateRef shoppingListItemAdditionFlowStateRef,
  });
}
