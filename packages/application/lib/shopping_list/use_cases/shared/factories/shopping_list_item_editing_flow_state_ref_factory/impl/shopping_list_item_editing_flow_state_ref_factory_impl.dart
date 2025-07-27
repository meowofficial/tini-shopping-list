import 'package:injectable/injectable.dart';

import '../../../../../flow_states/shopping_list_item_editing_flow_state.dart';
import '../../../refs/shopping_list_item_editing_flow_state_ref.dart';
import '../../existing_shopping_list_draft_item_ref_factory/existing_shopping_list_draft_item_ref_factory.dart';
import '../shopping_list_item_editing_flow_state_ref_factory.dart';

@LazySingleton(as: ShoppingListItemEditingFlowStateRefFactory)
class ShoppingListItemEditingFlowStateRefFactoryImpl
    implements ShoppingListItemEditingFlowStateRefFactory {
  const ShoppingListItemEditingFlowStateRefFactoryImpl({
    required ExistingShoppingListDraftItemRefFactory existingShoppingListDraftItemRefFactory,
  }) : _existingShoppingListDraftItemRefFactory = existingShoppingListDraftItemRefFactory;

  final ExistingShoppingListDraftItemRefFactory _existingShoppingListDraftItemRefFactory;

  @override
  ShoppingListItemEditingFlowStateRef call(ShoppingListItemEditingFlowState flowState) {
    switch (flowState) {
      case IdleShoppingListItemEditingFlowState():
        return const IdleShoppingListItemEditingFlowStateRef();

      case OngoingShoppingListItemEditingFlowState():
        final existingShoppingListDraftItemRef = _existingShoppingListDraftItemRefFactory.createRef(
          existingShoppingListDraftItem: flowState.existingShoppingListDraftItem,
        );

        return OngoingShoppingListItemEditingFlowStateRef(
          existingShoppingListDraftItemRef: existingShoppingListDraftItemRef,
        );
    }
  }
}
