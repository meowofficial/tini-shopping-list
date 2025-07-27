import 'package:application/shopping_list/use_cases/shared/refs/shopping_list_item_addition_flow_state_ref.dart';
import 'package:common/extensions/iterable_extenstion.dart';
import 'package:common/uuid_generator.dart';

import '../../../../../core/navigation/desktop/desktop_app_routes.dart';
import '../../../../../core/navigation/desktop/desktop_route_transition.dart';
import '../../../../../core/navigation/desktop/navigator/desktop_navigator.dart';

sealed class ShoppingListItemAdditionFlowNavigatorDelegate {
  void handleStateChange({
    required ShoppingListItemAdditionFlowStateRef currentStateRef,
    required ShoppingListItemAdditionFlowStateRef previousStateRef,
  });
}

class ShoppingListItemAdditionScreenOpeningNavigatorDelegate
    implements ShoppingListItemAdditionFlowNavigatorDelegate {
  const ShoppingListItemAdditionScreenOpeningNavigatorDelegate({
    required UuidGenerator uuidGenerator,
    required DesktopNavigator navigator,
  }) : _uuidGenerator = uuidGenerator,
       _navigator = navigator;

  final UuidGenerator _uuidGenerator;
  final DesktopNavigator _navigator;

  @override
  void handleStateChange({
    required ShoppingListItemAdditionFlowStateRef currentStateRef,
    required ShoppingListItemAdditionFlowStateRef previousStateRef,
  }) {
    switch (currentStateRef) {
      case IdleShoppingListItemAdditionFlowStateRef():
      case SuspendedShoppingListItemAdditionFlowStateRef():
        return;

      case OngoingShoppingListItemAdditionFlowStateRef():
        switch (previousStateRef) {
          case IdleShoppingListItemAdditionFlowStateRef():
          case SuspendedShoppingListItemAdditionFlowStateRef():
            break;

          case OngoingShoppingListItemAdditionFlowStateRef():
            return;
        }
    }

    final shoppingListItemAdditionRouteExists = _navigator.state.routes
        .where((it) {
          switch (_navigator.state.routeToTransition[it]) {
            case null:
            case DesktopAdditionRouteTransition():
              return true;

            case DesktopRemovalRouteTransition():
              return false;
          }
        })
        .any((it) => it is DesktopShoppingListItemAdditionRoute);

    if (shoppingListItemAdditionRouteExists) {
      return;
    }

    final route = DesktopShoppingListItemAdditionRoute(
      id: _uuidGenerator.generateUuid(),
    );

    final updatedRoutes = _navigator.state.routes.add(route);

    const transition = DesktopAdditionRouteTransition(
      displayTransition: false,
    );

    final updatedRouteToTransition = _navigator.state.routeToTransition.add(route, transition);

    _navigator.updateWith(
      routes: () => updatedRoutes,
      routeToTransition: () => updatedRouteToTransition,
    );
  }
}

class ShoppingListItemAdditionScreenClosingNavigatorDelegate
    implements ShoppingListItemAdditionFlowNavigatorDelegate {
  const ShoppingListItemAdditionScreenClosingNavigatorDelegate({
    required DesktopNavigator navigator,
  }) : _navigator = navigator;

  final DesktopNavigator _navigator;

  @override
  void handleStateChange({
    required ShoppingListItemAdditionFlowStateRef currentStateRef,
    required ShoppingListItemAdditionFlowStateRef previousStateRef,
  }) {
    if (currentStateRef is! IdleShoppingListItemAdditionFlowStateRef ||
        previousStateRef is! OngoingShoppingListItemAdditionFlowStateRef) {
      return;
    }

    final route = _navigator.state.routes
        .where((it) {
          switch (_navigator.state.routeToTransition[it]) {
            case null:
            case DesktopAdditionRouteTransition():
              return true;

            case DesktopRemovalRouteTransition():
              return false;
          }
        })
        .firstWhereOrNull(
          (it) => it is DesktopShoppingListItemAdditionRoute,
        );

    if (route == null) {
      return;
    }

    const transition = DesktopRemovalRouteTransition(
      displayTransition: false,
    );

    final updatedRouteToTransition = _navigator.state.routeToTransition.add(route, transition);

    _navigator.updateWith(
      routeToTransition: () => updatedRouteToTransition,
    );
  }
}
