import 'shopping_list_item_title_validation_error.dart';

abstract interface class ShoppingListItemTitleValidator {
  ShoppingListItemTitleValidationError? validate({
    required String title,
  });
}
