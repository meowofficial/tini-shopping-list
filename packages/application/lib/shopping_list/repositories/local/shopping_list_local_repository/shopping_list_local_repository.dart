import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import 'dtos/shopping_list_item_local_dto.dart';

abstract interface class ShoppingListLocalRepository {
  Future<IList<ShoppingListItemLocalDto>> getShoppingListItemDtos();
}
