import 'package:application/shopping_list/use_cases/shared/refs/shopping_list_item_ref/shopping_list_item_ref.dart';

import '../../presenters/shopping_list_item_presenter/shopping_list_item_presenter.dart';

abstract interface class ShoppingListItemPresenterFactory {
  ShoppingListItemPresenter create({
    required ShoppingListItemRef shoppingListItemRef,
  });
}
