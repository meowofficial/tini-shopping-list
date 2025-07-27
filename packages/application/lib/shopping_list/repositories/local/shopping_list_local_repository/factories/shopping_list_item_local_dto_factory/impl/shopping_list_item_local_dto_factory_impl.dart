import 'package:domain/shopping_list/entities/shopping_list_item.dart';
import 'package:injectable/injectable.dart';

import '../../../dtos/shopping_list_item_local_dto.dart';
import '../../shopping_list_item_local_dto_factory/shopping_list_item_local_dto_factory.dart';

@LazySingleton(as: ShoppingListItemLocalDtoFactory)
class ShoppingListItemLocalDtoFactoryImpl implements ShoppingListItemLocalDtoFactory {
  const ShoppingListItemLocalDtoFactoryImpl();

  @override
  ShoppingListItemLocalDto createDto({
    required ShoppingListItem shoppingListItem,
  }) {
    return ShoppingListItemLocalDto(
      id: shoppingListItem.id,
      title: shoppingListItem.title,
      checked: shoppingListItem.checked,
    );
  }

  @override
  ShoppingListItem createEntity({
    required ShoppingListItemLocalDto shoppingListItemDto,
  }) {
    return ShoppingListItem(
      id: shoppingListItemDto.id,
      title: shoppingListItemDto.title,
      checked: shoppingListItemDto.checked,
    );
  }
}
