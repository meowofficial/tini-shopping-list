import 'package:common/errors/unexpected_state_error.dart';
import 'package:domain/shopping_list/validation/shopping_list_item_title_validator/shopping_list_item_title_validator.dart';
import 'package:injectable/injectable.dart';

import '../../../flow_states/shopping_list_item_editing_flow_state.dart';
import '../../../stores/shopping_list_flow_store/shopping_list_flow_store.dart';
import '../update_existing_shopping_list_draft_item_title.dart';

@LazySingleton(as: UpdateExistingShoppingListDraftItemTitle)
class UpdateExistingShoppingListDraftItemTitleImpl
    implements UpdateExistingShoppingListDraftItemTitle {
  const UpdateExistingShoppingListDraftItemTitleImpl({
    required ShoppingListItemTitleValidator shoppingListItemTitleValidator,
    required ShoppingListFlowStore shoppingListFlowStore,
  }) : _shoppingListItemTitleValidator = shoppingListItemTitleValidator,
       _shoppingListFlowStore = shoppingListFlowStore;

  final ShoppingListItemTitleValidator _shoppingListItemTitleValidator;
  final ShoppingListFlowStore _shoppingListFlowStore;

  @override
  void call({
    required String updatedTitle,
  }) {
    final shoppingListItemEditingFlowState =
        _shoppingListFlowStore.state.shoppingListItemEditingFlowState;

    if (shoppingListItemEditingFlowState is! OngoingShoppingListItemEditingFlowState) {
      throwStateError();
    }

    final existingShoppingListDraftItem =
        shoppingListItemEditingFlowState.existingShoppingListDraftItem;

    final updatedTitleValidationError = _shoppingListItemTitleValidator.validate(
      title: updatedTitle,
    );

    existingShoppingListDraftItem.changeTitle(
      title: updatedTitle,
      titleValidationError: updatedTitleValidationError,
    );
  }
}
