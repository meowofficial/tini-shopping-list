import 'package:injectable/injectable.dart';

import '../mappers/shopping_list_item_addition_flow_state_ref_mapper.dart';
import '../refs/flow_state_refs/shopping_list_item_addition_flow_state_ref.dart';
import '../stores/shopping_list_flow_store.dart';

abstract interface class WatchShoppingListItemAdditionFlowState {
  Stream<ShoppingListItemAdditionFlowStateRef> call();
}

@LazySingleton(as: WatchShoppingListItemAdditionFlowState)
class WatchShoppingListItemAdditionFlowStateImpl implements WatchShoppingListItemAdditionFlowState {
  const WatchShoppingListItemAdditionFlowStateImpl({
    required ShoppingListFlowStore shoppingListFlowStore,
    required ShoppingListItemAdditionFlowStateRefMapper shoppingListItemAdditionFlowStateRefMapper,
  }) : _shoppingListFlowStore = shoppingListFlowStore,
       _shoppingListItemAdditionFlowStateRefMapper = shoppingListItemAdditionFlowStateRefMapper;

  final ShoppingListFlowStore _shoppingListFlowStore;
  final ShoppingListItemAdditionFlowStateRefMapper _shoppingListItemAdditionFlowStateRefMapper;

  @override
  Stream<ShoppingListItemAdditionFlowStateRef> call() {
    return _shoppingListFlowStore.stateStream.map((state) {
      return _shoppingListItemAdditionFlowStateRefMapper(state.shoppingListItemAdditionFlowState);
    }).distinct();
  }
}
