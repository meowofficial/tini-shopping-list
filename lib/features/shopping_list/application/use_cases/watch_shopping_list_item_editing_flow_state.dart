import 'package:injectable/injectable.dart';

import '../mappers/shopping_list_item_editing_flow_state_ref_mapper.dart';
import '../refs/flow_state_refs/shopping_list_item_editing_flow_state_ref.dart';
import '../stores/shopping_list_flow_store.dart';

abstract interface class WatchShoppingListItemEditingFlowState {
  Stream<ShoppingListItemEditingFlowStateRef> call();
}

@LazySingleton(as: WatchShoppingListItemEditingFlowState)
class WatchShoppingListItemEditingFlowStateImpl implements WatchShoppingListItemEditingFlowState {
  const WatchShoppingListItemEditingFlowStateImpl({
    required ShoppingListFlowStore shoppingListFlowStore,
    required ShoppingListItemEditingFlowStateRefMapper shoppingListItemEditingFlowStateRefMapper,
  }) : _shoppingListFlowStore = shoppingListFlowStore,
       _shoppingListItemEditingFlowStateRefMapper = shoppingListItemEditingFlowStateRefMapper;

  final ShoppingListFlowStore _shoppingListFlowStore;
  final ShoppingListItemEditingFlowStateRefMapper _shoppingListItemEditingFlowStateRefMapper;

  @override
  Stream<ShoppingListItemEditingFlowStateRef> call() {
    return _shoppingListFlowStore.stateStream.map((state) {
      return _shoppingListItemEditingFlowStateRefMapper(state.shoppingListItemEditingFlowState);
    }).distinct();
  }
}
