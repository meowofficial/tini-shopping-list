import 'package:injectable/injectable.dart';

import '../mappers/shopping_list_overview_flow_state_ref_mapper.dart';
import '../refs/flow_state_refs/shopping_list_overview_flow_state_ref.dart';
import '../stores/shopping_list_flow_store.dart';

abstract interface class WatchShoppingListOverviewFlowState {
  Stream<ShoppingListOverviewFlowStateRef> call();
}

@LazySingleton(as: WatchShoppingListOverviewFlowState)
class WatchShoppingListOverviewFlowStateImpl implements WatchShoppingListOverviewFlowState {
  const WatchShoppingListOverviewFlowStateImpl({
    required ShoppingListFlowStore shoppingListFlowStore,
    required ShoppingListOverviewFlowStateRefMapper shoppingListOverviewFlowStateRefMapper,
  }) : _shoppingListFlowStore = shoppingListFlowStore,
       _shoppingListOverviewFlowStateRefMapper = shoppingListOverviewFlowStateRefMapper;

  final ShoppingListFlowStore _shoppingListFlowStore;
  final ShoppingListOverviewFlowStateRefMapper _shoppingListOverviewFlowStateRefMapper;

  @override
  Stream<ShoppingListOverviewFlowStateRef> call() {
    return _shoppingListFlowStore.stateStream.map((state) {
      return _shoppingListOverviewFlowStateRefMapper(state.shoppingListOverviewFlowState);
    }).distinct();
  }
}
