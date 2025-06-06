import 'package:injectable/injectable.dart';

import '../../../../core/common/errors/unexpected_state_error.dart';
import '../../domain/entities/existing_shopping_list_draft_item.dart';
import '../../domain/validation/shopping_list_item/validator.dart';
import '../flow_states/shopping_list_item_editing_flow_state.dart';
import '../flow_states/shopping_list_overview_flow_state.dart';
import '../stores/shopping_list_flow_store.dart';

abstract interface class StartShoppingListItemEditing {
  void call({
    required String shoppingListItemId,
  });
}

@LazySingleton(as: StartShoppingListItemEditing)
class StartShoppingListItemEditingImpl implements StartShoppingListItemEditing {
  const StartShoppingListItemEditingImpl({
    required ShoppingListItemTitleValidator shoppingListItemTitleValidator,
    required ShoppingListFlowStore shoppingListFlowStore,
  }) : _shoppingListItemTitleValidator = shoppingListItemTitleValidator,
       _shoppingListFlowStore = shoppingListFlowStore;

  final ShoppingListItemTitleValidator _shoppingListItemTitleValidator;
  final ShoppingListFlowStore _shoppingListFlowStore;

  @override
  void call({
    required String shoppingListItemId,
  }) {
    if (_shoppingListFlowStore.state.shoppingListItemEditingFlowState
        is! IdleShoppingListItemEditingFlowState) {
      throwStateError();
    }

    final shoppingListOverviewFlowState =
        _shoppingListFlowStore.state.shoppingListOverviewFlowState;

    if (shoppingListOverviewFlowState is! LoadedShoppingListOverviewFlowState) {
      throwStateError();
    }

    final shoppingListItems = shoppingListOverviewFlowState.shoppingListItems;

    final shoppingListItem = shoppingListItems.firstWhere((it) => it.id == shoppingListItemId);

    final titleValidationError = _shoppingListItemTitleValidator.validate(
      title: shoppingListItem.title,
    );

    final existingShoppingListDraftItem = ExistingShoppingListDraftItem(
      id: shoppingListItem.id,
      title: shoppingListItem.title,
      titleValidationError: titleValidationError,
    );

    final updatedShoppingListItemEditingFlowState = OngoingShoppingListItemEditingFlowState(
      existingShoppingListDraftItem: existingShoppingListDraftItem,
    );

    _shoppingListFlowStore.updateWith(
      shoppingListItemEditingFlowState: () => updatedShoppingListItemEditingFlowState,
    );
  }
}
