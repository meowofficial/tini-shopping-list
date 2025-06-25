import '../../../../../application/refs/entity_refs/shopping_list_item_ref.dart';
import 'shopping_list_item_presenter.dart';

abstract interface class ShoppingListItemPresenterFactory {
  ShoppingListItemPresenter create({
    required ShoppingListItemRef shoppingListItemRef,
  });
}
