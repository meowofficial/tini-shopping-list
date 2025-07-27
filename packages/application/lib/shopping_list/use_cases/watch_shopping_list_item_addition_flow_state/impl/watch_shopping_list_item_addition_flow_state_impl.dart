import 'package:injectable/injectable.dart';

import '../../../stores/shopping_list_flow_store/shopping_list_flow_store.dart';
import '../../../use_cases/shared/refs/shopping_list_item_addition_flow_state_ref.dart';
import '../../shared/factories/shopping_list_item_addition_flow_state_ref_factory/shopping_list_item_addition_flow_state_ref_factory.dart';
import '../watch_shopping_list_item_addition_flow_state.dart';

@LazySingleton(as: WatchShoppingListItemAdditionFlowState)
class WatchShoppingListItemAdditionFlowStateImpl implements WatchShoppingListItemAdditionFlowState {
  const WatchShoppingListItemAdditionFlowStateImpl({
    required ShoppingListFlowStore shoppingListFlowStore,
    required ShoppingListItemAdditionFlowStateRefFactory
    shoppingListItemAdditionFlowStateRefFactory,
  }) : _shoppingListFlowStore = shoppingListFlowStore,
       _shoppingListItemAdditionFlowStateRefFactory = shoppingListItemAdditionFlowStateRefFactory;

  final ShoppingListFlowStore _shoppingListFlowStore;
  final ShoppingListItemAdditionFlowStateRefFactory _shoppingListItemAdditionFlowStateRefFactory;

  @override
  Stream<ShoppingListItemAdditionFlowStateRef> call({
    bool sync = false,
  }) {
    final shoppingListFlowStoreStateStream = sync
        ? _shoppingListFlowStore.syncStateStream
        : _shoppingListFlowStore.stateStream;

    return shoppingListFlowStoreStateStream.map((state) {
      return _shoppingListItemAdditionFlowStateRefFactory(state.shoppingListItemAdditionFlowState);
    }).distinct();
  }
}
