import 'package:equatable/equatable.dart';

import '../entity_refs/new_shopping_list_draft_item_ref.dart';

sealed class ShoppingListItemAdditionFlowStateRef {}

class IdleShoppingListItemAdditionFlowStateRef extends Equatable
    implements ShoppingListItemAdditionFlowStateRef {
  const IdleShoppingListItemAdditionFlowStateRef();

  @override
  List<Object?> get props => [];
}

class OngoingShoppingListItemAdditionFlowStateRef extends Equatable
    implements ShoppingListItemAdditionFlowStateRef {
  const OngoingShoppingListItemAdditionFlowStateRef({
    required this.newShoppingListDraftItemRef,
  });

  final NewShoppingListDraftItemRef newShoppingListDraftItemRef;

  @override
  List<Object?> get props {
    return [
      newShoppingListDraftItemRef,
    ];
  }
}
