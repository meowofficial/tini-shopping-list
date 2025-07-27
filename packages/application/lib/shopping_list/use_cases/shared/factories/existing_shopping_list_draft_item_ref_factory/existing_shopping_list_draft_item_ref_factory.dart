import 'package:domain/shopping_list/entities/existing_shopping_list_draft_item.dart';

import '../../refs/existing_shopping_list_draft_item_ref/existing_shopping_list_draft_item_ref.dart';

abstract interface class ExistingShoppingListDraftItemRefFactory {
  ExistingShoppingListDraftItemRef createRef({
    required ExistingShoppingListDraftItem existingShoppingListDraftItem,
  });
}
