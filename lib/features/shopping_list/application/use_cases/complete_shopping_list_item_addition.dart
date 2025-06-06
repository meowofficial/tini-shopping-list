import 'package:injectable/injectable.dart';

import '../../../../core/common/errors/unexpected_state_error.dart';
import '../../domain/factories/shopping_list_item_factory.dart';
import '../flow_states/shopping_list_item_addition_flow_state.dart';
import '../flow_states/shopping_list_overview_flow_state.dart';
import '../stores/shopping_list_flow_store.dart';

abstract interface class CompleteShoppingListItemAddition {
  void call();
}

@LazySingleton(as: CompleteShoppingListItemAddition)
class CompleteShoppingListItemAdditionImpl implements CompleteShoppingListItemAddition {
  const CompleteShoppingListItemAdditionImpl({
    required ShoppingListItemFactory shoppingListItemFactory,
    required ShoppingListFlowStore shoppingListFlowStore,
  }) : _shoppingListItemFactory = shoppingListItemFactory,
       _shoppingListFlowStore = shoppingListFlowStore;

  final ShoppingListItemFactory _shoppingListItemFactory;
  final ShoppingListFlowStore _shoppingListFlowStore;

  @override
  void call() {
    final shoppingListItemAdditionFlowState =
        _shoppingListFlowStore.state.shoppingListItemAdditionFlowState;

    if (shoppingListItemAdditionFlowState is! OngoingShoppingListItemAdditionFlowState) {
      throwStateError();
    }

    final newShoppingListDraftItem = shoppingListItemAdditionFlowState.newShoppingListDraftItem;

    final shoppingListOverviewFlowState =
        _shoppingListFlowStore.state.shoppingListOverviewFlowState;

    if (shoppingListOverviewFlowState is! LoadedShoppingListOverviewFlowState) {
      throwStateError();
    }

    final shoppingListItems = shoppingListOverviewFlowState.shoppingListItems;

    if (newShoppingListDraftItem.titleValidationError != null) {
      throwStateError();
    }

    final shoppingListItem = _shoppingListItemFactory.createFromDraft(
      newShoppingListDraftItem: newShoppingListDraftItem,
    );

    final updatedShoppingListItems = shoppingListItems.add(shoppingListItem);

    final updatedShoppingListOverviewFlowState = LoadedShoppingListOverviewFlowState(
      shoppingListItems: updatedShoppingListItems,
    );

    newShoppingListDraftItem.dispose();

    const updatedShoppingListItemAdditionFlowState = IdleShoppingListItemAdditionFlowState();

    _shoppingListFlowStore.updateWith(
      shoppingListOverviewFlowState: () => updatedShoppingListOverviewFlowState,
      shoppingListItemAdditionFlowState: () => updatedShoppingListItemAdditionFlowState,
    );
  }
}
