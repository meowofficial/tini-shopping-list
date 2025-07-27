import 'package:domain/shopping_list/validation/shopping_list_item_title_validator/shopping_list_item_title_validation_error.dart';
import 'package:injectable/injectable.dart';

import '../../../output_dtos/shopping_list_item_title_validation_error_output_dto.dart';
import '../shopping_list_item_title_validation_error_output_dto_factory.dart';

@LazySingleton(as: ShoppingListItemTitleValidationErrorOutputDtoFactory)
class ShoppingListItemTitleValidationErrorOutputDtoFactoryImpl
    implements ShoppingListItemTitleValidationErrorOutputDtoFactory {
  const ShoppingListItemTitleValidationErrorOutputDtoFactoryImpl();

  @override
  ShoppingListItemTitleValidationErrorOutputDto createDto({
    required ShoppingListItemTitleValidationError shoppingListItemTitleValidationError,
  }) {
    switch (shoppingListItemTitleValidationError) {
      case EmptyShoppingListItemTitleValidationError():
        return const EmptyShoppingListItemTitleValidationErrorOutputDto();
    }
  }

  @override
  ShoppingListItemTitleValidationErrorOutputDto? createNullableDto({
    required ShoppingListItemTitleValidationError? shoppingListItemTitleValidationError,
  }) {
    if (shoppingListItemTitleValidationError == null) {
      return null;
    }

    return createDto(
      shoppingListItemTitleValidationError: shoppingListItemTitleValidationError,
    );
  }
}
