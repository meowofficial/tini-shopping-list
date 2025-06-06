import 'package:equatable/equatable.dart';

sealed class ShoppingListItemTitleValidationError {}

class EmptyShoppingListItemTitleValidationError extends Equatable
    implements ShoppingListItemTitleValidationError {
  const EmptyShoppingListItemTitleValidationError();

  @override
  List<Object?> get props => [];
}
