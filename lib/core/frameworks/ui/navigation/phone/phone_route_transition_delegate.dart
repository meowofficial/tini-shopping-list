import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../interface_adapters/presentation/navigation/phone/phone_route_transition.dart';
import '../../../../interface_adapters/presentation/navigation/shared/app_routes.dart';
import '../shared/navigator_page.dart';

class PhoneRouteTransitionDelegate extends TransitionDelegate<dynamic> {
  const PhoneRouteTransitionDelegate({
    required this.routes,
    required this.routeToTransition,
  });

  final IList<AppRoute> routes;
  final IMap<AppRoute, PhoneRouteTransition> routeToTransition;

  @override
  Iterable<RouteTransitionRecord> resolve({
    required List<RouteTransitionRecord> newPageRouteHistory,
    required Map<RouteTransitionRecord?, RouteTransitionRecord> locationToExitingPageRoute,
    required Map<RouteTransitionRecord?, List<RouteTransitionRecord>> pageRouteToPagelessRoutes,
  }) {
    final routeToExitingRouteTransitionRecord = <AppRoute, RouteTransitionRecord>{};

    for (final exitingRouteTransitionRecord in locationToExitingPageRoute.values) {
      final route = _parseRoute(exitingRouteTransitionRecord);
      routeToExitingRouteTransitionRecord[route] = exitingRouteTransitionRecord;
    }

    final routeToNewTransitionRecord = <AppRoute, RouteTransitionRecord>{};

    for (final newRouteTransitionRecord in newPageRouteHistory) {
      final route = _parseRoute(newRouteTransitionRecord);
      routeToNewTransitionRecord[route] = newRouteTransitionRecord;
    }

    final handledRouteTransitionRecords = <RouteTransitionRecord>[];

    for (final route in routes) {
      final routeTransition = routeToTransition[route];
      final isLast = routes.last == route;

      if (routeToNewTransitionRecord.containsKey(route)) {
        final routeTransitionRecord = routeToNewTransitionRecord[route]!;

        if (routeTransitionRecord.isWaitingForEnteringDecision) {
          final shouldBeMarkedForAdd =
              routeTransition is PhoneAdditionRouteTransition && !routeTransition.displayTransition;

          if (!locationToExitingPageRoute.containsKey(routeTransitionRecord) &&
              !shouldBeMarkedForAdd &&
              isLast) {
            routeTransitionRecord.markForPush();
          } else {
            routeTransitionRecord.markForAdd();
          }
        }

        handledRouteTransitionRecords.add(routeTransitionRecord);
      } else if (routeToExitingRouteTransitionRecord.containsKey(route)) {
        final exitingRouteTransitionRecord = routeToExitingRouteTransitionRecord[route]!;

        if (exitingRouteTransitionRecord.isWaitingForExitingDecision) {
          final hasPagelessRouteTransitionRecord = pageRouteToPagelessRoutes.containsKey(
            exitingRouteTransitionRecord,
          );

          final shouldBeMarkedForComplete =
              routeTransition is PhoneRemovalRouteTransition && !routeTransition.displayTransition;

          if (isLast && !hasPagelessRouteTransitionRecord && !shouldBeMarkedForComplete) {
            exitingRouteTransitionRecord.markForPop(
              exitingRouteTransitionRecord.route.currentResult,
            );
          } else {
            exitingRouteTransitionRecord.markForComplete(
              exitingRouteTransitionRecord.route.currentResult,
            );
          }

          if (hasPagelessRouteTransitionRecord) {
            final pagelessRouteTransitionRecords =
                pageRouteToPagelessRoutes[exitingRouteTransitionRecord]!;

            for (final pagelessRouteTransitionRecord in pagelessRouteTransitionRecords) {
              if (pagelessRouteTransitionRecord.isWaitingForExitingDecision) {
                if (isLast &&
                    pagelessRouteTransitionRecord == pagelessRouteTransitionRecords.last &&
                    !shouldBeMarkedForComplete) {
                  pagelessRouteTransitionRecord.markForPop(
                    pagelessRouteTransitionRecord.route.currentResult,
                  );
                } else {
                  pagelessRouteTransitionRecord.markForComplete(
                    pagelessRouteTransitionRecord.route.currentResult,
                  );
                }
              }
            }
          }
        }

        handledRouteTransitionRecords.add(exitingRouteTransitionRecord);
      }
    }

    final missedExitingRouteTransitionRecords = <RouteTransitionRecord>[];

    final handledRouteSet = routes.toSet();

    var exitingRouteTransitionRecord = locationToExitingPageRoute[null];

    while (exitingRouteTransitionRecord != null) {
      if (exitingRouteTransitionRecord.isWaitingForExitingDecision) {
        exitingRouteTransitionRecord.markForComplete(
          exitingRouteTransitionRecord.route.currentResult,
        );

        final pagelessRouteTransitionRecords =
            pageRouteToPagelessRoutes[exitingRouteTransitionRecord];

        if (pagelessRouteTransitionRecords != null) {
          for (final pagelessRouteTransitionRecord in pagelessRouteTransitionRecords) {
            if (pagelessRouteTransitionRecord.isWaitingForExitingDecision) {
              pagelessRouteTransitionRecord.markForComplete(
                pagelessRouteTransitionRecord.route.currentResult,
              );
            }
          }
        }
      }

      final route = _parseRoute(exitingRouteTransitionRecord);

      if (!handledRouteSet.contains(route)) {
        missedExitingRouteTransitionRecords.add(exitingRouteTransitionRecord);
      }

      exitingRouteTransitionRecord = locationToExitingPageRoute[exitingRouteTransitionRecord];
    }

    if (missedExitingRouteTransitionRecords.isNotEmpty) {
      final missedRoutes = missedExitingRouteTransitionRecords.map(_parseRoute);

      if (kDebugMode) {
        print('Navigator error! Missed exiting app routes: $missedRoutes');
      }
    }

    final result = [
      ...missedExitingRouteTransitionRecords,
      ...handledRouteTransitionRecords,
    ];

    return result;
  }

  AppRoute _parseRoute(RouteTransitionRecord routeTransitionRecord) {
    final page = routeTransitionRecord.route.settings as AppNavigatorPage;
    return page.route;
  }
}
