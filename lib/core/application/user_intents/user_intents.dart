import 'package:equatable/equatable.dart';

sealed class UserIntent {}

class ShoppingListOverviewUserIntent extends Equatable implements UserIntent {
  const ShoppingListOverviewUserIntent();

  @override
  List<Object?> get props => [];
}

class ShoppingListItemAdditionUserIntent extends Equatable implements UserIntent {
  const ShoppingListItemAdditionUserIntent();

  @override
  List<Object?> get props => [];
}

class ShoppingListItemEditingUserIntent extends Equatable implements UserIntent {
  const ShoppingListItemEditingUserIntent({
    required this.shoppingListItemId,
  });

  final String shoppingListItemId;

  @override
  List<Object?> get props {
    return [
      shoppingListItemId,
    ];
  }
}
