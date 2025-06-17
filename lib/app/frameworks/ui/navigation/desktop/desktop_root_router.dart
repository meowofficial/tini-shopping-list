import 'package:flutter/widgets.dart';

import '../../../../../core/interface_adapters/presentation/navigation/desktop/desktop_navigator.dart';
import '../../../../../injection_container.dart';
import '../../../../interface_adapters/presentation/navigation/desktop/desktop_navigator_presenter.dart';
import '../../../../interface_adapters/presentation/navigation/shared/uri_config_holder.dart';
import '../../../../interface_adapters/presentation/navigation/shared/uri_config_parser_locator.dart';
import '../shared/route_information_parser.dart';
import 'desktop_router_delegate.dart';

class DesktopRootRouter extends StatefulWidget {
  const DesktopRootRouter({
    super.key,
  });

  @override
  State<DesktopRootRouter> createState() => _DesktopRootRouterState();
}

class _DesktopRootRouterState extends State<DesktopRootRouter> {
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

    // todo
    final uriConfig = di<UriConfigHolder>().lastKnownUriConfig;

    final initialRouteInformation = uriConfig == null
        ? RouteInformation(
            uri: Uri.parse(WidgetsBinding.instance.platformDispatcher.defaultRouteName),
          )
        : _routeInformationParser.restoreRouteInformation(uriConfig)!;

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
