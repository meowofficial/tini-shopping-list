import 'package:flutter/cupertino.dart';
import 'package:interface_adapters/presentation/core/navigation/shared/app_routes.dart';

class AppNavigatorPage<T> extends CupertinoPage<T> {
  AppNavigatorPage({
    required super.child,
    required this.route,
    super.maintainState,
    super.fullscreenDialog,
    super.name,
    super.arguments,
  }) : super(key: ValueKey(route.id));

  final AppRoute route;
}
