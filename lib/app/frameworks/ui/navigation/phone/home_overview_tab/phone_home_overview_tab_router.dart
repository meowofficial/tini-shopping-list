import 'package:flutter/material.dart';

import '../../../../../../injection_container.dart';
import '../../../../../interface_adapters/presentation/navigation/phone/routers/interfaces/phone_home_overview_tab_router_presenter.dart';
import '../../../../../interface_adapters/presentation/navigation/phone/routers/presenters/phone_home_overview_tab_router_presenter.dart';
import 'phone_home_overview_tab_router_delegate.dart';

class PhoneHomeOverviewTabRouter extends StatefulWidget {
  const PhoneHomeOverviewTabRouter({
    super.key,
  });

  @override
  State<PhoneHomeOverviewTabRouter> createState() => _PhoneHomeOverviewTabRouterState();
}

class _PhoneHomeOverviewTabRouterState extends State<PhoneHomeOverviewTabRouter> {
  late final PhoneHomeOverviewTabRouterPresenter _presenter;
  late final PhoneHomeOverviewTabRouterDelegate _routerDelegate;

  @override
  void initState() {
    super.initState();

    _presenter = PhoneHomeOverviewTabRouterPresenterImpl(
      navigator: di(),
      navigationOrchestrator: di(),
    );

    _routerDelegate = PhoneHomeOverviewTabRouterDelegate(
      presenter: _presenter,
    );
  }

  @override
  void dispose() {
    _routerDelegate.dispose();
    _presenter.dispose();
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
