import 'package:common/uuid_generator.dart';
import 'package:injectable/injectable.dart';

import '../../entities/new_shopping_list_draft_item.dart';
import '../../entities/shopping_list_item.dart';
import '../shopping_list_item_factory.dart';

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
