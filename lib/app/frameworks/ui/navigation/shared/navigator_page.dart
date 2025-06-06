import 'package:flutter/cupertino.dart';

import '../../../../../core/interface_adapters/presentation/navigation/shared/app_route.dart';

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
