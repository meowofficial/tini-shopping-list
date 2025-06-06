import 'package:injectable/injectable.dart';

import 'errors.dart';

abstract interface class ShoppingListItemTitleValidator {
  ShoppingListItemTitleValidationError? validate({
    required String title,
  });
}

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
