import 'package:application/shopping_list/use_cases/read_shopping_list_item_addition_flow_state/read_shopping_list_item_addition_flow_state.dart';
import 'package:application/shopping_list/use_cases/shared/refs/shopping_list_item_addition_flow_state_ref.dart';
import 'package:application/shopping_list/use_cases/stop_shopping_list_item_addition/stop_shopping_list_item_addition.dart';
import 'package:common/extensions/iterable_extenstion.dart';

import '../../../../core/navigation/desktop/desktop_app_routes.dart';
import '../../../../core/navigation/desktop/navigator/desktop_navigator.dart';

sealed class DesktopNavigatorObserver {
  void handleStateChange({
    required DesktopNavigatorState currentState,
    required DesktopNavigatorState previousState,
  });
}

class ShoppingListItemAdditionStopNavigatorObserver implements DesktopNavigatorObserver {
  const ShoppingListItemAdditionStopNavigatorObserver({
    required ReadShoppingListItemAdditionFlowState readShoppingListItemAdditionFlowState,
    required StopShoppingListItemAddition stopShoppingListItemAddition,
  }) : _readShoppingListItemAdditionFlowState = readShoppingListItemAdditionFlowState,
       _stopShoppingListItemAddition = stopShoppingListItemAddition;

  final ReadShoppingListItemAdditionFlowState _readShoppingListItemAdditionFlowState;
  final StopShoppingListItemAddition _stopShoppingListItemAddition;

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

    _stopShoppingListItemAddition();
  }
}
