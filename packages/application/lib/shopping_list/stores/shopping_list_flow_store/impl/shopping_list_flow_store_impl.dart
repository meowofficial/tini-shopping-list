import 'package:injectable/injectable.dart';

import '../../../../core/stores/base_store.dart';
import '../../../flow_states/shopping_list_item_addition_flow_state.dart';
import '../../../flow_states/shopping_list_item_editing_flow_state.dart';
import '../../../flow_states/shopping_list_overview_flow_state.dart';
import '../../shopping_list_flow_store/shopping_list_flow_store.dart';

@LazySingleton(as: ShoppingListFlowStore)
class ShoppingListFlowStoreImpl extends BaseStore<ShoppingListFlowStoreState>
    implements ShoppingListFlowStore {
  ShoppingListFlowStoreImpl();

  @override
  void initialize({
    required ShoppingListOverviewFlowState shoppingListOverviewFlowState,
    required ShoppingListItemAdditionFlowState shoppingListItemAdditionFlowState,
    required ShoppingListItemEditingFlowState shoppingListItemEditingFlowState,
  }) {
    final initialState = ShoppingListFlowStoreState(
      shoppingListOverviewFlowState: shoppingListOverviewFlowState,
      shoppingListItemAdditionFlowState: shoppingListItemAdditionFlowState,
      shoppingListItemEditingFlowState: shoppingListItemEditingFlowState,
    );

    initializeState(initialState);
  }

  @override
  void updateWith({
    ShoppingListOverviewFlowState Function()? shoppingListOverviewFlowState,
    ShoppingListItemAdditionFlowState Function()? shoppingListItemAdditionFlowState,
    ShoppingListItemEditingFlowState Function()? shoppingListItemEditingFlowState,
  }) {
    final updatedState = state.copyWith(
      shoppingListOverviewFlowState: shoppingListOverviewFlowState,
      shoppingListItemAdditionFlowState: shoppingListItemAdditionFlowState,
      shoppingListItemEditingFlowState: shoppingListItemEditingFlowState,
    );

    emit(updatedState);
  }
}
