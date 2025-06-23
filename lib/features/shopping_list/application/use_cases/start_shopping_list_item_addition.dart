import 'package:injectable/injectable.dart';

import '../../../../core/common/errors/unexpected_state_error.dart';
import '../../domain/entities/new_shopping_list_draft_item.dart';
import '../../domain/validation/shopping_list_item/validator.dart';
import '../flow_states/shopping_list_item_addition_flow_state.dart';
import '../stores/shopping_list_flow_store.dart';

abstract interface class StartShoppingListItemAddition {
  void call();
}

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
