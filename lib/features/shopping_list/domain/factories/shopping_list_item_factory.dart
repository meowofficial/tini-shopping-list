import 'package:injectable/injectable.dart';

import '../../../../core/common/uuid/uuid_generator.dart';
import '../entities/new_shopping_list_draft_item.dart';
import '../entities/shopping_list_item.dart';

abstract interface class ShoppingListItemFactory {
  ShoppingListItem createFromDraft({
    required NewShoppingListDraftItem newShoppingListDraftItem,
  });
}

@LazySingleton(as: ShoppingListItemFactory)
class ShoppingListItemFactoryImpl implements ShoppingListItemFactory {
  const ShoppingListItemFactoryImpl({
    required UuidGenerator uuidGenerator,
  }) : _uuidGenerator = uuidGenerator;
  final UuidGenerator _uuidGenerator;

  @override
  ShoppingListItem createFromDraft({
    required NewShoppingListDraftItem newShoppingListDraftItem,
  }) {
    final shoppingListItemId = _uuidGenerator.generateUuid();

    return ShoppingListItem(
      id: shoppingListItemId,
      title: newShoppingListDraftItem.title.trim(),
      checked: false,
    );
  }
}
