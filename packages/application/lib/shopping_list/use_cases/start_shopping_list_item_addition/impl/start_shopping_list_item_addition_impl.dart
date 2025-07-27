import 'package:common/errors/unexpected_state_error.dart';
import 'package:domain/shopping_list/entities/new_shopping_list_draft_item.dart';
import 'package:domain/shopping_list/validation/shopping_list_item_title_validator/shopping_list_item_title_validator.dart';
import 'package:injectable/injectable.dart';

import '../../../flow_states/shopping_list_item_addition_flow_state.dart';
import '../../../stores/shopping_list_flow_store/shopping_list_flow_store.dart';
import '../start_shopping_list_item_addition.dart';

@LazySingleton(as: StartShoppingListItemAddition)
class StartShoppingListItemAdditionImpl implements StartShoppingListItemAddition {
  const StartShoppingListItemAdditionImpl({
    required ShoppingListItemTitleValidator shoppingListItemTitleValidator,
    required ShoppingListFlowStore shoppingListFlowStore,
  }) : _shoppingListItemTitleValidator = shoppingListItemTitleValidator,
       _shoppingListFlowStore = shoppingListFlowStore;

  final ShoppingListItemTitleValidator _shoppingListItemTitleValidator;
  final ShoppingListFlowStore _shoppingListFlowStore;

  @override
  void call() {
    final shoppingListItemAdditionFlowState =
        _shoppingListFlowStore.state.shoppingListItemAdditionFlowState;

    final NewShoppingListDraftItem newShoppingListDraftItem;

    switch (shoppingListItemAdditionFlowState) {
      case IdleShoppingListItemAdditionFlowState():
        const title = '';

        final titleValidationError = _shoppingListItemTitleValidator.validate(
          title: title,
        );

        newShoppingListDraftItem = NewShoppingListDraftItem(
          title: title,
          titleValidationError: titleValidationError,
        );

      case OngoingShoppingListItemAdditionFlowState():
        throwStateError();

      case SuspendedShoppingListItemAdditionFlowState():
        newShoppingListDraftItem = shoppingListItemAdditionFlowState.newShoppingListDraftItem;
    }

    final updatedShoppingListItemAdditionFlowState = OngoingShoppingListItemAdditionFlowState(
      newShoppingListDraftItem: newShoppingListDraftItem,
    );

    _shoppingListFlowStore.updateWith(
      shoppingListItemAdditionFlowState: () => updatedShoppingListItemAdditionFlowState,
    );
  }
}
