import 'package:injectable/injectable.dart';

import '../mappers/shopping_list_item_addition_flow_state_ref_mapper.dart';
import '../refs/flow_state_refs/shopping_list_item_addition_flow_state_ref.dart';
import '../stores/shopping_list_flow_store.dart';

abstract interface class ReadShoppingListItemAdditionFlowState {
  ShoppingListItemAdditionFlowStateRef call();
}

@LazySingleton(as: ReadShoppingListItemAdditionFlowState)
class ReadShoppingListItemAdditionFlowStateImpl implements ReadShoppingListItemAdditionFlowState {
  const ReadShoppingListItemAdditionFlowStateImpl({
    required ShoppingListFlowStore shoppingListFlowStore,
    required ShoppingListItemAdditionFlowStateRefMapper shoppingListItemAdditionFlowStateRefMapper,
  }) : _shoppingListFlowStore = shoppingListFlowStore,
       _shoppingListItemAdditionFlowStateRefMapper = shoppingListItemAdditionFlowStateRefMapper;

  final ShoppingListFlowStore _shoppingListFlowStore;
  final ShoppingListItemAdditionFlowStateRefMapper _shoppingListItemAdditionFlowStateRefMapper;

  @override
  ShoppingListItemAdditionFlowStateRef call() {
    return _shoppingListItemAdditionFlowStateRefMapper(
      _shoppingListFlowStore.state.shoppingListItemAdditionFlowState,
    );
  }
}
