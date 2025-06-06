import 'package:injectable/injectable.dart';

import '../../../../core/common/errors/unexpected_state_error.dart';
import '../flow_states/shopping_list_overview_flow_state.dart';
import '../stores/shopping_list_flow_store.dart';

abstract interface class ToggleShoppingListItemCheck {
  void call({
    required String shoppingListItemId,
  });
}

@LazySingleton(as: ToggleShoppingListItemCheck)
class ToggleShoppingListItemCheckImpl implements ToggleShoppingListItemCheck {
  const ToggleShoppingListItemCheckImpl({
    required ShoppingListFlowStore shoppingListFlowStore,
  }) : _shoppingListFlowStore = shoppingListFlowStore;

  final ShoppingListFlowStore _shoppingListFlowStore;

  @override
  void call({
    required String shoppingListItemId,
  }) {
    final shoppingListOverviewFlowState =
        _shoppingListFlowStore.state.shoppingListOverviewFlowState;

    if (shoppingListOverviewFlowState is! LoadedShoppingListOverviewFlowState) {
      throwStateError();
    }

    final shoppingListItems = shoppingListOverviewFlowState.shoppingListItems;

    final shoppingListItem = shoppingListItems.firstWhere((it) {
      return it.id == shoppingListItemId;
    });

    shoppingListItem.toggleCheck();
  }
}
