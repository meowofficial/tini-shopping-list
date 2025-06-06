import 'package:injectable/injectable.dart';

import '../../../core/application/stores/user_intent_store.dart';
import '../../../core/application/user_intents/user_intents.dart';
import '../../../features/shopping_list/application/flow_states/shopping_list_item_addition_flow_state.dart';
import '../../../features/shopping_list/application/flow_states/shopping_list_item_editing_flow_state.dart';
import '../../../features/shopping_list/application/flow_states/shopping_list_overview_flow_state.dart';
import '../../../features/shopping_list/application/stores/shopping_list_flow_store.dart';

abstract interface class HandleAppLaunch {
  void call({
    required UserIntent initialUserIntent,
  });
}

@LazySingleton(as: HandleAppLaunch)
class HandleAppLaunchImpl implements HandleAppLaunch {
  const HandleAppLaunchImpl({
    required ShoppingListFlowStore shoppingListFlowStore,
    required UserIntentStore userIntentStore,
  }) : _shoppingListFlowStore = shoppingListFlowStore,
       _userIntentStore = userIntentStore;

  final ShoppingListFlowStore _shoppingListFlowStore;
  final UserIntentStore _userIntentStore;

  @override
  void call({
    required UserIntent initialUserIntent,
  }) {
    const shoppingListOverviewFlowState = InitialShoppingListOverviewFlowState();
    const shoppingListItemAdditionFlowState = IdleShoppingListItemAdditionFlowState();
    const shoppingListItemEditingFlowState = IdleShoppingListItemEditingFlowState();

    _shoppingListFlowStore.initialize(
      shoppingListOverviewFlowState: shoppingListOverviewFlowState,
      shoppingListItemAdditionFlowState: shoppingListItemAdditionFlowState,
      shoppingListItemEditingFlowState: shoppingListItemEditingFlowState,
    );

    _userIntentStore.initialize(
      activeUserIntent: initialUserIntent,
    );
  }
}
