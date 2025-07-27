import 'package:domain/shopping_list/entities/shopping_list_item.dart';

import '../../dtos/shopping_list_item_local_dto.dart';

abstract interface class ShoppingListItemLocalDtoFactory {
  ShoppingListItemLocalDto createDto({
    required ShoppingListItem shoppingListItem,
  });

  ShoppingListItem createEntity({
    required ShoppingListItemLocalDto shoppingListItemDto,
  });
}
