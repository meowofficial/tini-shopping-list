import 'package:flutter/material.dart';

import '../../../../../../injection_container.dart';
import 'mobile_home_overview_tab_router_delegate.dart';

class MobileHomeOverviewTabRouter extends StatefulWidget {
  const MobileHomeOverviewTabRouter({
    super.key,
  });

  @override
  State<MobileHomeOverviewTabRouter> createState() => _MobileHomeOverviewTabRouterState();
}

class _MobileHomeOverviewTabRouterState extends State<MobileHomeOverviewTabRouter> {
  late final MobileHomeOverviewTabRouterDelegate _routerDelegate;

  @override
  void initState() {
    super.initState();

    _routerDelegate = MobileHomeOverviewTabRouterDelegate(
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
