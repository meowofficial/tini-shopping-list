import 'package:flutter/material.dart';

import '../../../../../../injection_container.dart';
import 'phone_home_overview_tab_router_delegate.dart';

class PhoneHomeOverviewTabRouter extends StatefulWidget {
  const PhoneHomeOverviewTabRouter({
    super.key,
  });

  @override
  State<PhoneHomeOverviewTabRouter> createState() => _PhoneHomeOverviewTabRouterState();
}

class _PhoneHomeOverviewTabRouterState extends State<PhoneHomeOverviewTabRouter> {
  late final PhoneHomeOverviewTabRouterDelegate _routerDelegate;

  @override
  void initState() {
    super.initState();

    _routerDelegate = PhoneHomeOverviewTabRouterDelegate(
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
