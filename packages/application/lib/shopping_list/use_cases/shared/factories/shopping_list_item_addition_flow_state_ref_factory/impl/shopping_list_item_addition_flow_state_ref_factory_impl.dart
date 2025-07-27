import 'package:injectable/injectable.dart';

import '../../../../../flow_states/shopping_list_item_addition_flow_state.dart';
import '../../../refs/shopping_list_item_addition_flow_state_ref.dart';
import '../../new_shopping_list_draft_item_ref_factory/new_shopping_list_draft_item_ref_factory.dart';
import '../shopping_list_item_addition_flow_state_ref_factory.dart';

@LazySingleton(as: ShoppingListItemAdditionFlowStateRefFactory)
class ShoppingListItemAdditionFlowStateRefFactoryImpl
    implements ShoppingListItemAdditionFlowStateRefFactory {
  const ShoppingListItemAdditionFlowStateRefFactoryImpl({
    required NewShoppingListDraftItemRefFactory newShoppingListDraftItemRefFactory,
  }) : _newShoppingListDraftItemRefFactory = newShoppingListDraftItemRefFactory;

  final NewShoppingListDraftItemRefFactory _newShoppingListDraftItemRefFactory;

  @override
  ShoppingListItemAdditionFlowStateRef call(ShoppingListItemAdditionFlowState flowState) {
    switch (flowState) {
      case IdleShoppingListItemAdditionFlowState():
        return const IdleShoppingListItemAdditionFlowStateRef();

      case OngoingShoppingListItemAdditionFlowState():
        final newShoppingListDraftItemRef = _newShoppingListDraftItemRefFactory.createRef(
          newShoppingListDraftItem: flowState.newShoppingListDraftItem,
        );

        return OngoingShoppingListItemAdditionFlowStateRef(
          newShoppingListDraftItemRef: newShoppingListDraftItemRef,
        );

      case SuspendedShoppingListItemAdditionFlowState():
        final newShoppingListDraftItemRef = _newShoppingListDraftItemRefFactory.createRef(
          newShoppingListDraftItem: flowState.newShoppingListDraftItem,
        );

        return SuspendedShoppingListItemAdditionFlowStateRef(
          newShoppingListDraftItemRef: newShoppingListDraftItemRef,
        );
    }
  }
}
