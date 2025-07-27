import 'package:equatable/equatable.dart';

import 'existing_shopping_list_draft_item_ref/existing_shopping_list_draft_item_ref.dart';

sealed class ShoppingListItemEditingFlowStateRef {}

class IdleShoppingListItemEditingFlowStateRef extends Equatable
    implements ShoppingListItemEditingFlowStateRef {
  const IdleShoppingListItemEditingFlowStateRef();

  @override
  List<Object?> get props => [];
}

class OngoingShoppingListItemEditingFlowStateRef extends Equatable
    implements ShoppingListItemEditingFlowStateRef {
  const OngoingShoppingListItemEditingFlowStateRef({
    required this.existingShoppingListDraftItemRef,
  });

  final ExistingShoppingListDraftItemRef existingShoppingListDraftItemRef;

  @override
  List<Object?> get props {
    return [
      existingShoppingListDraftItemRef,
    ];
  }
}
