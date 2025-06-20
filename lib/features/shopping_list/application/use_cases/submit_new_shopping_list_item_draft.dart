import 'package:injectable/injectable.dart';

import '../../../../core/common/errors/unexpected_state_error.dart';
import '../../domain/factories/shopping_list_item_factory.dart';
import '../../domain/validation/shopping_list_item/validator.dart';
import '../flow_states/shopping_list_item_addition_flow_state.dart';
import '../flow_states/shopping_list_overview_flow_state.dart';
import '../stores/shopping_list_flow_store.dart';

abstract interface class SubmitNewShoppingListItemDraft {
  void call();
}

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
