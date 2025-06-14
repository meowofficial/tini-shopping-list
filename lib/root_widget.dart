import 'package:flutter/material.dart';

import 'app/frameworks/ui/navigation/desktop/desktop_router_delegate.dart';
import 'app/frameworks/ui/navigation/shared/route_information_parser.dart';
import 'app/interface_adapters/presentation/navigation/desktop/desktop_navigator.dart';
import 'app/interface_adapters/presentation/navigation/desktop/desktop_navigator_presenter.dart';
import 'app/interface_adapters/presentation/navigation/shared/uri_config_parser_locator.dart';
import 'injection_container.dart';

class RootWidget extends StatelessWidget {
  const RootWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    if (width < 600) {
      return Container(
        color: Colors.red,
      );
    }

    if (width < 1000) {
      return Container(
        color: Colors.green,
      );
    }

    return const DesktopRootWidget();
  }
}

class DesktopRootWidget extends StatefulWidget {
  const DesktopRootWidget({
    super.key,
  });

  @override
  State<DesktopRootWidget> createState() => _DesktopRootWidgetState();
}

class _DesktopRootWidgetState extends State<DesktopRootWidget> {
  late final DesktopRouterDelegate _routerDelegate;
  late final RouteInformationProvider _routeInformationProvider;
  late final AppRouteInformationParser _routeInformationParser;
  late final BackButtonDispatcher _backButtonDispatcher;

  @override
  void initState() {
    super.initState();

    _routerDelegate = DesktopRouterDelegate(
      navigatorPresenter: di(),
    );

    _routeInformationParser = AppRouteInformationParser(
      uriConfigParserLocator: UriConfigParserLocator(),
    );

    final initialRouteInformation = RouteInformation(
      uri: Uri.parse(WidgetsBinding.instance.platformDispatcher.defaultRouteName),
    );

    _routeInformationProvider = PlatformRouteInformationProvider(
      initialRouteInformation: initialRouteInformation,
    );

    _backButtonDispatcher = RootBackButtonDispatcher();
  }

  @override
  void dispose() {
    di.resetLazySingleton<DesktopNavigator>();
    di.resetLazySingleton<DesktopNavigatorPresenter>();
    _routerDelegate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Router(
      routeInformationProvider: _routeInformationProvider,
      routeInformationParser: _routeInformationParser,
      routerDelegate: _routerDelegate,
      backButtonDispatcher: _backButtonDispatcher,
    );
  }
}
