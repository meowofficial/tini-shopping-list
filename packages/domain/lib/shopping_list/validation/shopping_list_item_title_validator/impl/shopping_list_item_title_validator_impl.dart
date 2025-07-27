import 'package:injectable/injectable.dart';

import '../shopping_list_item_title_validation_error.dart';
import '../shopping_list_item_title_validator.dart';

@LazySingleton(as: ShoppingListItemTitleValidator)
class ShoppingListItemTitleValidatorImpl implements ShoppingListItemTitleValidator {
  const ShoppingListItemTitleValidatorImpl();

  @override
  ShoppingListItemTitleValidationError? validate({
    required String title,
  }) {
    if (title.trim().isEmpty) {
      return const EmptyShoppingListItemTitleValidationError();
    }

    return null;
  }
}
