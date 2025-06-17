import '../../../../../core/interface_adapters/presentation/navigation/mobile/mobile_home_tab.dart';
import '../../../../../core/interface_adapters/presentation/navigation/mobile/mobile_navigator.dart';
import '../../../../../features/shopping_list/application/refs/flow_state_refs/shopping_list_item_addition_flow_state_ref.dart';
import '../../../../../features/shopping_list/application/use_cases/cancel_shopping_list_item_addition.dart';
import '../../../../../features/shopping_list/application/use_cases/read_shopping_list_item_addition_flow_state.dart';
import '../../../../../features/shopping_list/application/use_cases/start_shopping_list_item_addition.dart';

sealed class MobileNavigatorObserver {
  void handleStateChange({
    required MobileNavigatorState currentState,
    required MobileNavigatorState previousState,
  });
}

class ShoppingListItemAdditionCancellationNavigatorObserver implements MobileNavigatorObserver {
  const ShoppingListItemAdditionCancellationNavigatorObserver({
    required ReadShoppingListItemAdditionFlowState readShoppingListItemAdditionFlowState,
    required CancelShoppingListItemAddition cancelShoppingListItemAddition,
  }) : _readShoppingListItemAdditionFlowState = readShoppingListItemAdditionFlowState,
       _cancelShoppingListItemAddition = cancelShoppingListItemAddition;

  final ReadShoppingListItemAdditionFlowState _readShoppingListItemAdditionFlowState;
  final CancelShoppingListItemAddition _cancelShoppingListItemAddition;

  @override
  void handleStateChange({
    required MobileNavigatorState currentState,
    required MobileNavigatorState previousState,
  }) {
    final shoppingListItemAdditionFlowStateRef = _readShoppingListItemAdditionFlowState();

    if (shoppingListItemAdditionFlowStateRef is! OngoingShoppingListItemAdditionFlowStateRef) {
      return;
    }

    final currentActiveHomeTab = currentState.homeNavigationState?.activeTab;
    final previousActiveHomeTab = previousState.homeNavigationState?.activeTab;

    if (currentActiveHomeTab == MobileHomeTab.addition ||
        previousActiveHomeTab != MobileHomeTab.addition) {
      return;
    }

    _cancelShoppingListItemAddition();
  }
}

class ShoppingListItemAdditionStartNavigatorObserver implements MobileNavigatorObserver {
  const ShoppingListItemAdditionStartNavigatorObserver({
    required ReadShoppingListItemAdditionFlowState readShoppingListItemAdditionFlowState,
    required StartShoppingListItemAddition startShoppingListItemAddition,
  }) : _readShoppingListItemAdditionFlowState = readShoppingListItemAdditionFlowState,
       _startShoppingListItemAddition = startShoppingListItemAddition;

  final ReadShoppingListItemAdditionFlowState _readShoppingListItemAdditionFlowState;
  final StartShoppingListItemAddition _startShoppingListItemAddition;

  @override
  void handleStateChange({
    required MobileNavigatorState currentState,
    required MobileNavigatorState previousState,
  }) {
    final shoppingListItemAdditionFlowStateRef = _readShoppingListItemAdditionFlowState();

    if (shoppingListItemAdditionFlowStateRef is! IdleShoppingListItemAdditionFlowStateRef) {
      return;
    }

    final currentActiveHomeTab = currentState.homeNavigationState?.activeTab;
    final previousActiveHomeTab = previousState.homeNavigationState?.activeTab;

    if (currentActiveHomeTab != MobileHomeTab.addition ||
        previousActiveHomeTab == MobileHomeTab.addition) {
      return;
    }

    _startShoppingListItemAddition();
  }
}
