import 'package:injectable/injectable.dart';

import '../../../features/shopping_list/application/flow_states/shopping_list_item_addition_flow_state.dart';
import '../../../features/shopping_list/application/flow_states/shopping_list_item_editing_flow_state.dart';
import '../../../features/shopping_list/application/flow_states/shopping_list_overview_flow_state.dart';
import '../../../features/shopping_list/application/stores/shopping_list_flow_store.dart';
import '../flow_states/app_initialization_flow_state.dart';
import '../stores/app_initialization_flow_store.dart';

abstract interface class InitializeStores {
  void call();
}

@LazySingleton(as: InitializeStores)
class InitializeStoresImpl implements InitializeStores {
  const InitializeStoresImpl({
    required AppInitializationFlowStore appInitializationFlowStore,
    required ShoppingListFlowStore shoppingListFlowStore,
  }) : _appInitializationFlowStore = appInitializationFlowStore,
       _shoppingListFlowStore = shoppingListFlowStore;

  final AppInitializationFlowStore _appInitializationFlowStore;
  final ShoppingListFlowStore _shoppingListFlowStore;

  @override
  void call() {
    const shoppingListOverviewFlowState = InitialShoppingListOverviewFlowState();
    const shoppingListItemAdditionFlowState = IdleShoppingListItemAdditionFlowState();
    const shoppingListItemEditingFlowState = IdleShoppingListItemEditingFlowState();

    _shoppingListFlowStore.initialize(
      shoppingListOverviewFlowState: shoppingListOverviewFlowState,
      shoppingListItemAdditionFlowState: shoppingListItemAdditionFlowState,
      shoppingListItemEditingFlowState: shoppingListItemEditingFlowState,
    );

    const appInitializationFlowState = InitialAppInitializationFlowState();

    _appInitializationFlowStore.initialize(
      appInitializationFlowState: appInitializationFlowState,
    );
  }
}
