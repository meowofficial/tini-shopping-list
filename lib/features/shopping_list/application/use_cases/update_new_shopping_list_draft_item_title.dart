import 'package:injectable/injectable.dart';

import '../../../../core/common/errors/unexpected_state_error.dart';
import '../../domain/validation/shopping_list_item/validator.dart';
import '../flow_states/shopping_list_item_addition_flow_state.dart';
import '../stores/shopping_list_flow_store.dart';

abstract interface class UpdateNewShoppingListDraftItemTitle {
  void call({
    required String updatedTitle,
  });
}

@LazySingleton(as: UpdateNewShoppingListDraftItemTitle)
class UpdateNewShoppingListDraftItemTitleImpl implements UpdateNewShoppingListDraftItemTitle {
  const UpdateNewShoppingListDraftItemTitleImpl({
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
    final shoppingListItemAdditionFlowState =
        _shoppingListFlowStore.state.shoppingListItemAdditionFlowState;

    if (shoppingListItemAdditionFlowState is! OngoingShoppingListItemAdditionFlowState) {
      throwStateError();
    }

    final newShoppingListDraftItem = shoppingListItemAdditionFlowState.newShoppingListDraftItem;

    final updatedTitleValidationError = _shoppingListItemTitleValidator.validate(
      title: updatedTitle,
    );

    newShoppingListDraftItem.changeTitle(
      title: updatedTitle,
      titleValidationError: updatedTitleValidationError,
    );
  }
}
