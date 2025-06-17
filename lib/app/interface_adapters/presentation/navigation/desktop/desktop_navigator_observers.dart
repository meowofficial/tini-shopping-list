import '../../../../../core/common/extensions/iterable_extenstion.dart';
import '../../../../../core/interface_adapters/presentation/navigation/desktop/desktop_app_routes.dart';
import '../../../../../core/interface_adapters/presentation/navigation/desktop/desktop_navigator.dart';
import '../../../../../features/shopping_list/application/refs/flow_state_refs/shopping_list_item_addition_flow_state_ref.dart';
import '../../../../../features/shopping_list/application/use_cases/cancel_shopping_list_item_addition.dart';
import '../../../../../features/shopping_list/application/use_cases/read_shopping_list_item_addition_flow_state.dart';

sealed class DesktopNavigatorObserver {
  void handleStateChange({
    required DesktopNavigatorState currentState,
    required DesktopNavigatorState previousState,
  });
}

class ShoppingListItemAdditionCancellationNavigatorObserver implements DesktopNavigatorObserver {
  const ShoppingListItemAdditionCancellationNavigatorObserver({
    required ReadShoppingListItemAdditionFlowState readShoppingListItemAdditionFlowState,
    required CancelShoppingListItemAddition cancelShoppingListItemAddition,
  }) : _readShoppingListItemAdditionFlowState = readShoppingListItemAdditionFlowState,
       _cancelShoppingListItemAddition = cancelShoppingListItemAddition;

  final ReadShoppingListItemAdditionFlowState _readShoppingListItemAdditionFlowState;
  final CancelShoppingListItemAddition _cancelShoppingListItemAddition;

  @override
  void handleStateChange({
    required DesktopNavigatorState currentState,
    required DesktopNavigatorState previousState,
  }) {
    final shoppingListItemAdditionFlowStateRef = _readShoppingListItemAdditionFlowState();

    if (shoppingListItemAdditionFlowStateRef is! OngoingShoppingListItemAdditionFlowStateRef) {
      return;
    }

    final currentShoppingListItemAdditionRoute = currentState.routes.firstWhereOrNull(
      (it) => it is DesktopShoppingListItemAdditionRoute,
    );

    if (currentShoppingListItemAdditionRoute != null) {
      return;
    }

    final previousShoppingListItemAdditionRoute = previousState.routes.firstWhereOrNull(
      (it) => it is DesktopShoppingListItemAdditionRoute,
    );

    if (previousShoppingListItemAdditionRoute == null) {
      return;
    }

    _cancelShoppingListItemAddition();
  }
}
