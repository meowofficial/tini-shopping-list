import 'package:domain/shopping_list/entities/new_shopping_list_draft_item.dart';

import '../../refs/new_shopping_list_draft_item_ref/new_shopping_list_draft_item_ref.dart';

abstract interface class NewShoppingListDraftItemRefFactory {
  NewShoppingListDraftItemRef createRef({
    required NewShoppingListDraftItem newShoppingListDraftItem,
  });
}
