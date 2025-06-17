import 'package:flutter/material.dart';

import '../../../../../../injection_container.dart';
import 'mobile_home_addition_tab_router_delegate.dart';

class MobileHomeAdditionTabRouter extends StatefulWidget {
  const MobileHomeAdditionTabRouter({
    super.key,
  });

  @override
  State<MobileHomeAdditionTabRouter> createState() => _MobileHomeAdditionTabRouterState();
}

class _MobileHomeAdditionTabRouterState extends State<MobileHomeAdditionTabRouter> {
  late final MobileHomeAdditionTabRouterDelegate _routerDelegate;

  @override
  void initState() {
    super.initState();

    _routerDelegate = MobileHomeAdditionTabRouterDelegate(
      navigatorPresenter: di(),
    );
  }

  @override
  void dispose() {
    _routerDelegate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final rootBackButtonDispatcher = Router.of(context).backButtonDispatcher!;
    final backButtonDispatcher = rootBackButtonDispatcher.createChildBackButtonDispatcher();

    backButtonDispatcher.takePriority();

    return Router(
      routerDelegate: _routerDelegate,
      backButtonDispatcher: backButtonDispatcher,
    );
  }
}
