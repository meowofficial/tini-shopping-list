import 'package:equatable/equatable.dart';

sealed class ShoppingListItemTitleValidationErrorOutputDto {}

class EmptyShoppingListItemTitleValidationErrorOutputDto extends Equatable
    implements ShoppingListItemTitleValidationErrorOutputDto {
  const EmptyShoppingListItemTitleValidationErrorOutputDto();

  @override
  List<Object?> get props => [];
}
