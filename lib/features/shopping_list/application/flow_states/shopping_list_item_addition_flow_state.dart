import 'package:equatable/equatable.dart';

import '../../domain/entities/new_shopping_list_draft_item.dart';

sealed class ShoppingListItemAdditionFlowState {}

class IdleShoppingListItemAdditionFlowState extends Equatable
    implements ShoppingListItemAdditionFlowState {
  const IdleShoppingListItemAdditionFlowState();

  @override
  List<Object?> get props => [];
}

class OngoingShoppingListItemAdditionFlowState extends Equatable
    implements ShoppingListItemAdditionFlowState {
  const OngoingShoppingListItemAdditionFlowState({
    required this.newShoppingListDraftItem,
  });

  final NewShoppingListDraftItem newShoppingListDraftItem;

  @override
  List<Object?> get props {
    return [
      newShoppingListDraftItem,
    ];
  }
}

class SuspendedShoppingListItemAdditionFlowState extends Equatable
    implements ShoppingListItemAdditionFlowState {
  const SuspendedShoppingListItemAdditionFlowState({
    required this.newShoppingListDraftItem,
  });

  final NewShoppingListDraftItem newShoppingListDraftItem;

  @override
  List<Object?> get props {
    return [
      newShoppingListDraftItem,
    ];
  }
}
