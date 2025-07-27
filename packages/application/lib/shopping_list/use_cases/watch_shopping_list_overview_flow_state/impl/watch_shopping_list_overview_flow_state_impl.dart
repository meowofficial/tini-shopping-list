import 'package:injectable/injectable.dart';

import '../../../stores/shopping_list_flow_store/shopping_list_flow_store.dart';
import '../../../use_cases/shared/refs/shopping_list_overview_flow_state_ref.dart';
import '../../shared/factories/shopping_list_overview_flow_state_ref_factory/shopping_list_overview_flow_state_ref_factory.dart';
import '../watch_shopping_list_overview_flow_state.dart';

@LazySingleton(as: WatchShoppingListOverviewFlowState)
class WatchShoppingListOverviewFlowStateImpl implements WatchShoppingListOverviewFlowState {
  const WatchShoppingListOverviewFlowStateImpl({
    required ShoppingListFlowStore shoppingListFlowStore,
    required ShoppingListOverviewFlowStateRefFactory shoppingListOverviewFlowStateRefFactory,
  }) : _shoppingListFlowStore = shoppingListFlowStore,
       _shoppingListOverviewFlowStateRefFactory = shoppingListOverviewFlowStateRefFactory;

  final ShoppingListFlowStore _shoppingListFlowStore;
  final ShoppingListOverviewFlowStateRefFactory _shoppingListOverviewFlowStateRefFactory;

  @override
  Stream<ShoppingListOverviewFlowStateRef> call({
    bool sync = false,
  }) {
    final shoppingListFlowStoreStateStream = sync
        ? _shoppingListFlowStore.syncStateStream
        : _shoppingListFlowStore.stateStream;

    return shoppingListFlowStoreStateStream.map((state) {
      return _shoppingListOverviewFlowStateRefFactory(state.shoppingListOverviewFlowState);
    }).distinct();
  }
}
