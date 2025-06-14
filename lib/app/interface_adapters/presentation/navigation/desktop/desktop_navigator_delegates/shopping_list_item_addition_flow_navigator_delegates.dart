import '../../../../../../core/common/extensions/iterable_extenstion.dart';
import '../../../../../../core/common/uuid/uuid_generator.dart';
import '../../../../../../core/interface_adapters/presentation/navigation/desktop/desktop_route_transition.dart';
import '../../../../../../features/shopping_list/application/refs/flow_state_refs/shopping_list_item_addition_flow_state_ref.dart';
import '../desktop_app_routes.dart';
import '../desktop_navigator.dart';

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
    if (currentStateRef is! OngoingShoppingListItemAdditionFlowStateRef ||
        previousStateRef is! IdleShoppingListItemAdditionFlowStateRef) {
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

    final route = _navigator.state.routes.firstWhereOrNull(
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
