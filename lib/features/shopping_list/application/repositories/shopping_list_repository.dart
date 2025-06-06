import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import '../../domain/entities/shopping_list_item.dart';

abstract interface class ShoppingListRepository {
  Future<IList<ShoppingListItem>> getShoppingListItems();
}