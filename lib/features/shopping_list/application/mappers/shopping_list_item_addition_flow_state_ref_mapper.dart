import 'package:injectable/injectable.dart';

import '../flow_states/shopping_list_item_addition_flow_state.dart';
import '../refs/entity_refs/new_shopping_list_draft_item_ref.dart';
import '../refs/flow_state_refs/shopping_list_item_addition_flow_state_ref.dart';

abstract interface class ShoppingListItemAdditionFlowStateRefMapper {
  ShoppingListItemAdditionFlowStateRef call(ShoppingListItemAdditionFlowState flowState);
}

@LazySingleton(as: ShoppingListItemAdditionFlowStateRefMapper)
class ShoppingListItemAdditionFlowStateRefMapperImpl
    implements ShoppingListItemAdditionFlowStateRefMapper {
  const ShoppingListItemAdditionFlowStateRefMapperImpl();

  @override
  ShoppingListItemAdditionFlowStateRef call(ShoppingListItemAdditionFlowState flowState) {
    switch (flowState) {
      case IdleShoppingListItemAdditionFlowState():
        return const IdleShoppingListItemAdditionFlowStateRef();

      case OngoingShoppingListItemAdditionFlowState():
        final newShoppingListDraftItemRef = NewShoppingListDraftItemRefImpl(
          entity: flowState.newShoppingListDraftItem,
        );

        return OngoingShoppingListItemAdditionFlowStateRef(
          newShoppingListDraftItemRef: newShoppingListDraftItemRef,
        );

      case SuspendedShoppingListItemAdditionFlowState():
        final newShoppingListDraftItemRef = NewShoppingListDraftItemRefImpl(
          entity: flowState.newShoppingListDraftItem,
        );

        return SuspendedShoppingListItemAdditionFlowStateRef(
          newShoppingListDraftItemRef: newShoppingListDraftItemRef,
        );
    }
  }
}
