import 'package:flutter/material.dart';

import '../../../../../../injection_container.dart';
import '../../../../../interface_adapters/presentation/navigation/phone/routers/interfaces/phone_home_addition_tab_router_presenter.dart';
import '../../../../../interface_adapters/presentation/navigation/phone/routers/presenters/phone_home_addition_tab_router_presenter.dart';
import 'phone_home_addition_tab_router_delegate.dart';

class PhoneHomeAdditionTabRouter extends StatefulWidget {
  const PhoneHomeAdditionTabRouter({
    super.key,
  });

  @override
  State<PhoneHomeAdditionTabRouter> createState() => _PhoneHomeAdditionTabRouterState();
}

class _PhoneHomeAdditionTabRouterState extends State<PhoneHomeAdditionTabRouter> {
  late final PhoneHomeAdditionTabRouterPresenter _presenter;
  late final PhoneHomeAdditionTabRouterDelegate _routerDelegate;

  @override
  void initState() {
    super.initState();

    _presenter = PhoneHomeAdditionTabRouterPresenterImpl(
      navigator: di(),
      navigationOrchestrator: di(),
    );

    _routerDelegate = PhoneHomeAdditionTabRouterDelegate(
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
