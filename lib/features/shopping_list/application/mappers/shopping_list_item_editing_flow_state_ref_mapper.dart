import 'package:injectable/injectable.dart';

import '../flow_states/shopping_list_item_editing_flow_state.dart';
import '../refs/entity_refs/existing_shopping_list_draft_item_ref.dart';
import '../refs/flow_state_refs/shopping_list_item_editing_flow_state_ref.dart';

abstract interface class ShoppingListItemEditingFlowStateRefMapper {
  ShoppingListItemEditingFlowStateRef call(ShoppingListItemEditingFlowState flowState);
}

@LazySingleton(as: ShoppingListItemEditingFlowStateRefMapper)
class ShoppingListItemEditingFlowStateRefMapperImpl
    implements ShoppingListItemEditingFlowStateRefMapper {
  const ShoppingListItemEditingFlowStateRefMapperImpl();

  @override
  ShoppingListItemEditingFlowStateRef call(ShoppingListItemEditingFlowState flowState) {
    switch (flowState) {
      case IdleShoppingListItemEditingFlowState():
        return const IdleShoppingListItemEditingFlowStateRef();

      case OngoingShoppingListItemEditingFlowState():
        final existingShoppingListDraftItemRef = ExistingShoppingListDraftItemRefImpl(
          entity: flowState.existingShoppingListDraftItem,
        );

        return OngoingShoppingListItemEditingFlowStateRef(
          existingShoppingListDraftItemRef: existingShoppingListDraftItemRef,
        );
    }
  }
}
