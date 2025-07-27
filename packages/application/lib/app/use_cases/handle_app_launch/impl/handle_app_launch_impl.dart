import 'package:domain/core/value_objects/ui_locale.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/stores/ui_locale_store/ui_locale_store.dart';
import '../../../../shopping_list/flow_states/shopping_list_item_addition_flow_state.dart';
import '../../../../shopping_list/flow_states/shopping_list_item_editing_flow_state.dart';
import '../../../../shopping_list/flow_states/shopping_list_overview_flow_state.dart';
import '../../../../shopping_list/stores/shopping_list_flow_store/shopping_list_flow_store.dart';
import '../../../flow_states/app_initialization_flow_state.dart';
import '../../../stores/app_initialization_flow_store/app_initialization_flow_store.dart';
import '../handle_app_launch.dart';

@LazySingleton(as: HandleAppLaunch)
class HandleAppLaunchImpl implements HandleAppLaunch {
  const HandleAppLaunchImpl({
    required AppInitializationFlowStore appInitializationFlowStore,
    required UiLocaleStore uiLocaleStore,
    required ShoppingListFlowStore shoppingListFlowStore,
  }) : _appInitializationFlowStore = appInitializationFlowStore,
       _uiLocaleStore = uiLocaleStore,
       _shoppingListFlowStore = shoppingListFlowStore;

  final AppInitializationFlowStore _appInitializationFlowStore;
  final UiLocaleStore _uiLocaleStore;
  final ShoppingListFlowStore _shoppingListFlowStore;

  @override
  void call() {
    _uiLocaleStore.initialize(
      uiLocale: UiLocale.ru,
    );

    const shoppingListOverviewFlowState = InitialShoppingListOverviewFlowState();
    const shoppingListItemAdditionFlowState = IdleShoppingListItemAdditionFlowState();
    const shoppingListItemEditingFlowState = IdleShoppingListItemEditingFlowState();

    _shoppingListFlowStore.initialize(
      shoppingListOverviewFlowState: shoppingListOverviewFlowState,
      shoppingListItemAdditionFlowState: shoppingListItemAdditionFlowState,
      shoppingListItemEditingFlowState: shoppingListItemEditingFlowState,
    );

    const updatedAppInitializationFlowState = LoadedAppInitializationFlowState();

    _appInitializationFlowStore.updateWith(
      appInitializationFlowState: () => updatedAppInitializationFlowState,
    );
  }
}
