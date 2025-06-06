import 'package:equatable/equatable.dart';

import '../../domain/entities/existing_shopping_list_draft_item.dart';

sealed class ShoppingListItemEditingFlowState {}

class IdleShoppingListItemEditingFlowState extends Equatable
    implements ShoppingListItemEditingFlowState {
  const IdleShoppingListItemEditingFlowState();

  @override
  List<Object?> get props => [];
}

class OngoingShoppingListItemEditingFlowState extends Equatable
    implements ShoppingListItemEditingFlowState {
  const OngoingShoppingListItemEditingFlowState({
    required this.existingShoppingListDraftItem,
  });

  final ExistingShoppingListDraftItem existingShoppingListDraftItem;

  @override
  List<Object?> get props {
    return [
      existingShoppingListDraftItem,
    ];
  }
}
