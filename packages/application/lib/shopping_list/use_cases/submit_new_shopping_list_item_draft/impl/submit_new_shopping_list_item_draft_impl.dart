import 'package:common/errors/unexpected_state_error.dart';
import 'package:domain/shopping_list/factories/shopping_list_item_factory.dart';
import 'package:domain/shopping_list/validation/shopping_list_item_title_validator/shopping_list_item_title_validator.dart';
import 'package:injectable/injectable.dart';

import '../../../flow_states/shopping_list_item_addition_flow_state.dart';
import '../../../flow_states/shopping_list_overview_flow_state.dart';
import '../../../stores/shopping_list_flow_store/shopping_list_flow_store.dart';
import '../submit_new_shopping_list_item_draft.dart';

@LazySingleton(as: SubmitNewShoppingListItemDraft)
class SubmitNewShoppingListItemDraftImpl implements SubmitNewShoppingListItemDraft {
  const SubmitNewShoppingListItemDraftImpl({
    required ShoppingListItemFactory shoppingListItemFactory,
    required ShoppingListFlowStore shoppingListFlowStore,
    required ShoppingListItemTitleValidator shoppingListItemTitleValidator,
  }) : _shoppingListItemFactory = shoppingListItemFactory,
       _shoppingListFlowStore = shoppingListFlowStore,
       _shoppingListItemTitleValidator = shoppingListItemTitleValidator;

  final ShoppingListItemFactory _shoppingListItemFactory;
  final ShoppingListFlowStore _shoppingListFlowStore;
  final ShoppingListItemTitleValidator _shoppingListItemTitleValidator;

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

    const updatedTitle = '';

    final updatedTitleValidationError = _shoppingListItemTitleValidator.validate(
      title: updatedTitle,
    );

    shoppingListItemAdditionFlowState.newShoppingListDraftItem.changeTitle(
      title: updatedTitle,
      titleValidationError: updatedTitleValidationError,
    );

    _shoppingListFlowStore.updateWith(
      shoppingListOverviewFlowState: () => updatedShoppingListOverviewFlowState,
    );
  }
}
