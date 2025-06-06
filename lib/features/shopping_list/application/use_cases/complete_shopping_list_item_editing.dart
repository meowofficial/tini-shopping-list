import 'package:injectable/injectable.dart';

import '../../../../core/common/errors/unexpected_state_error.dart';
import '../flow_states/shopping_list_item_editing_flow_state.dart';
import '../flow_states/shopping_list_overview_flow_state.dart';
import '../stores/shopping_list_flow_store.dart';

abstract interface class CompleteShoppingListItemEditing {
  void call();
}

@LazySingleton(as: CompleteShoppingListItemEditing)
class CompleteShoppingListItemEditingImpl implements CompleteShoppingListItemEditing {
  const CompleteShoppingListItemEditingImpl({
    required ShoppingListFlowStore shoppingListFlowStore,
  }) : _shoppingListFlowStore = shoppingListFlowStore;
  final ShoppingListFlowStore _shoppingListFlowStore;

  @override
  void call() {
    final shoppingListItemEditingFlowState =
        _shoppingListFlowStore.state.shoppingListItemEditingFlowState;

    if (shoppingListItemEditingFlowState is! OngoingShoppingListItemEditingFlowState) {
      throwStateError();
    }

    final existingShoppingListDraftItem =
        shoppingListItemEditingFlowState.existingShoppingListDraftItem;

    if (existingShoppingListDraftItem.titleValidationError != null) {
      throwStateError();
    }

    final shoppingListOverviewFlowState =
        _shoppingListFlowStore.state.shoppingListOverviewFlowState;

    if (shoppingListOverviewFlowState is! LoadedShoppingListOverviewFlowState) {
      throwStateError();
    }

    final shoppingListItems = shoppingListOverviewFlowState.shoppingListItems;

    final shoppingListItem = shoppingListItems.firstWhere((it) {
      return it.id == existingShoppingListDraftItem.id;
    });

    shoppingListItem.updateFromDraft(
      existingShoppingListDraftItem: existingShoppingListDraftItem,
    );

    existingShoppingListDraftItem.dispose();

    const updatedShoppingListItemEditingFlowState = IdleShoppingListItemEditingFlowState();

    _shoppingListFlowStore.updateWith(
      shoppingListItemEditingFlowState: () => updatedShoppingListItemEditingFlowState,
    );
  }
}
