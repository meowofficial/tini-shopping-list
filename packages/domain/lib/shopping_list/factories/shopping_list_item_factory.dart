import '../entities/new_shopping_list_draft_item.dart';
import '../entities/shopping_list_item.dart';

abstract interface class ShoppingListItemFactory {
  ShoppingListItem createFromDraft({
    required NewShoppingListDraftItem newShoppingListDraftItem,
  });
}
