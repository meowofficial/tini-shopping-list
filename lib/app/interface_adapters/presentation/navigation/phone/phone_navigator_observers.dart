import '../../../../../core/interface_adapters/presentation/navigation/phone/phone_home_tab.dart';
import '../../../../../core/interface_adapters/presentation/navigation/phone/phone_navigator.dart';
import '../../../../../features/shopping_list/application/refs/flow_state_refs/shopping_list_item_addition_flow_state_ref.dart';
import '../../../../../features/shopping_list/application/use_cases/read_shopping_list_item_addition_flow_state.dart';
import '../../../../../features/shopping_list/application/use_cases/start_shopping_list_item_addition.dart';
import '../../../../../features/shopping_list/application/use_cases/stop_shopping_list_item_addition.dart';

sealed class PhoneNavigatorObserver {
  void handleStateChange({
    required PhoneNavigatorState currentState,
    required PhoneNavigatorState previousState,
  });
}

class ShoppingListItemAdditionCancellationNavigatorObserver implements PhoneNavigatorObserver {
  const ShoppingListItemAdditionCancellationNavigatorObserver({
    required ReadShoppingListItemAdditionFlowState readShoppingListItemAdditionFlowState,
    required StopShoppingListItemAddition stopShoppingListItemAddition,
  }) : _readShoppingListItemAdditionFlowState = readShoppingListItemAdditionFlowState,
       _stopShoppingListItemAddition = stopShoppingListItemAddition;

  final ReadShoppingListItemAdditionFlowState _readShoppingListItemAdditionFlowState;
  final StopShoppingListItemAddition _stopShoppingListItemAddition;

  @override
  void handleStateChange({
    required PhoneNavigatorState currentState,
    required PhoneNavigatorState previousState,
  }) {
    final shoppingListItemAdditionFlowStateRef = _readShoppingListItemAdditionFlowState();

    if (shoppingListItemAdditionFlowStateRef is! OngoingShoppingListItemAdditionFlowStateRef) {
      return;
    }

    final currentActiveHomeTab = currentState.homeNavigationState?.activeTab;
    final previousActiveHomeTab = previousState.homeNavigationState?.activeTab;

    if (currentActiveHomeTab == PhoneHomeTab.addition ||
        previousActiveHomeTab != PhoneHomeTab.addition) {
      return;
    }

    _stopShoppingListItemAddition();
  }
}

class ShoppingListItemAdditionStartNavigatorObserver implements PhoneNavigatorObserver {
  const ShoppingListItemAdditionStartNavigatorObserver({
    required ReadShoppingListItemAdditionFlowState readShoppingListItemAdditionFlowState,
    required StartShoppingListItemAddition startShoppingListItemAddition,
  }) : _readShoppingListItemAdditionFlowState = readShoppingListItemAdditionFlowState,
       _startShoppingListItemAddition = startShoppingListItemAddition;

  final ReadShoppingListItemAdditionFlowState _readShoppingListItemAdditionFlowState;
  final StartShoppingListItemAddition _startShoppingListItemAddition;

  @override
  void handleStateChange({
    required PhoneNavigatorState currentState,
    required PhoneNavigatorState previousState,
  }) {
    final shoppingListItemAdditionFlowStateRef = _readShoppingListItemAdditionFlowState();

    if (shoppingListItemAdditionFlowStateRef is! IdleShoppingListItemAdditionFlowStateRef) {
      return;
    }

    final currentActiveHomeTab = currentState.homeNavigationState?.activeTab;
    final previousActiveHomeTab = previousState.homeNavigationState?.activeTab;

    if (currentActiveHomeTab != PhoneHomeTab.addition ||
        previousActiveHomeTab == PhoneHomeTab.addition) {
      return;
    }

    _startShoppingListItemAddition();
  }
}
