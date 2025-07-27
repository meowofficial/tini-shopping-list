import 'package:common/stream/with_previous_stream.dart';
import 'package:common/typedefs/value_with_previous.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';

import '../../../shared/app_routes.dart';
import '../../../shared/base_navigator.dart';
import '../../desktop_route_transition.dart';
import '../desktop_navigator.dart';

@LazySingleton(as: DesktopNavigator)
class DesktopNavigatorImpl extends BaseNavigator<DesktopNavigatorState>
    implements DesktopNavigator {
  DesktopNavigatorImpl();

  @override
  late Stream<ValueWithPrevious<DesktopNavigatorState>> stateStreamWithPrevious;

  @override
  void initialize({
    required IList<AppRoute> routes,
    required IMap<AppRoute, DesktopRouteTransition> routeToTransition,
  }) {
    final initialState = DesktopNavigatorState(
      routes: routes,
      routeToTransition: routeToTransition,
    );

    initializeState(initialState);

    stateStreamWithPrevious = stateStream.withPreviousSeeded(initialState);

    emit(initialState);
  }

  @override
  void updateWith({
    IList<AppRoute> Function()? routes,
    IMap<AppRoute, DesktopRouteTransition> Function()? routeToTransition,
  }) {
    final updatedState = state.copyWith(
      routes: routes,
      routeToTransition: routeToTransition,
    );

    emit(updatedState);
  }

  @override
  @disposeMethod
  void dispose() {
    super.dispose();
  }
}
