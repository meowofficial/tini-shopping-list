import 'package:domain/shopping_list/validation/shopping_list_item_title_validator/shopping_list_item_title_validation_error.dart';

import '../../output_dtos/shopping_list_item_title_validation_error_output_dto.dart';

abstract interface class ShoppingListItemTitleValidationErrorOutputDtoFactory {
  ShoppingListItemTitleValidationErrorOutputDto createDto({
    required ShoppingListItemTitleValidationError shoppingListItemTitleValidationError,
  });

  ShoppingListItemTitleValidationErrorOutputDto? createNullableDto({
    required ShoppingListItemTitleValidationError? shoppingListItemTitleValidationError,
  });
}
