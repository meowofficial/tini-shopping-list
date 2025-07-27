import 'package:injectable/injectable.dart';

import '../../../stores/shopping_list_flow_store/shopping_list_flow_store.dart';
import '../../../use_cases/shared/refs/shopping_list_overview_flow_state_ref.dart';
import '../../shared/factories/shopping_list_overview_flow_state_ref_factory/shopping_list_overview_flow_state_ref_factory.dart';
import '../read_shopping_list_overview_flow_state.dart';

@LazySingleton(as: ReadShoppingListOverviewFlowState)
class ReadShoppingListOverviewFlowStateImpl implements ReadShoppingListOverviewFlowState {
  const ReadShoppingListOverviewFlowStateImpl({
    required ShoppingListFlowStore shoppingListFlowStore,
    required ShoppingListOverviewFlowStateRefFactory shoppingListOverviewFlowStateRefFactory,
  }) : _shoppingListFlowStore = shoppingListFlowStore,
       _shoppingListOverviewFlowStateRefFactory = shoppingListOverviewFlowStateRefFactory;

  final ShoppingListFlowStore _shoppingListFlowStore;
  final ShoppingListOverviewFlowStateRefFactory _shoppingListOverviewFlowStateRefFactory;

  @override
  ShoppingListOverviewFlowStateRef call() {
    return _shoppingListOverviewFlowStateRefFactory(
      _shoppingListFlowStore.state.shoppingListOverviewFlowState,
    );
  }
}
