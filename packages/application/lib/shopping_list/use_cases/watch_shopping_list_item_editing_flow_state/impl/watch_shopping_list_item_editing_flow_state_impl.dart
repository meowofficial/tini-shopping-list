import 'package:injectable/injectable.dart';

import '../../../stores/shopping_list_flow_store/shopping_list_flow_store.dart';
import '../../../use_cases/shared/refs/shopping_list_item_editing_flow_state_ref.dart';
import '../../shared/factories/shopping_list_item_editing_flow_state_ref_factory/shopping_list_item_editing_flow_state_ref_factory.dart';
import '../watch_shopping_list_item_editing_flow_state.dart';

@LazySingleton(as: WatchShoppingListItemEditingFlowState)
class WatchShoppingListItemEditingFlowStateImpl implements WatchShoppingListItemEditingFlowState {
  const WatchShoppingListItemEditingFlowStateImpl({
    required ShoppingListFlowStore shoppingListFlowStore,
    required ShoppingListItemEditingFlowStateRefFactory shoppingListItemEditingFlowStateRefFactory,
  }) : _shoppingListFlowStore = shoppingListFlowStore,
       _shoppingListItemEditingFlowStateRefFactory = shoppingListItemEditingFlowStateRefFactory;

  final ShoppingListFlowStore _shoppingListFlowStore;
  final ShoppingListItemEditingFlowStateRefFactory _shoppingListItemEditingFlowStateRefFactory;

  @override
  Stream<ShoppingListItemEditingFlowStateRef> call({
    bool sync = false,
  }) {
    final shoppingListFlowStoreStateStream = sync
        ? _shoppingListFlowStore.syncStateStream
        : _shoppingListFlowStore.stateStream;

    return shoppingListFlowStoreStateStream.map((state) {
      return _shoppingListItemEditingFlowStateRefFactory(state.shoppingListItemEditingFlowState);
    }).distinct();
  }
}
