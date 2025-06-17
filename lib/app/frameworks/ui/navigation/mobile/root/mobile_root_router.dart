import 'package:flutter/widgets.dart';

import '../../../../../../core/interface_adapters/presentation/navigation/mobile/mobile_navigator.dart';
import '../../../../../../injection_container.dart';
import '../../../../../interface_adapters/presentation/navigation/mobile/mobile_navigator_presenter.dart';
import '../../../../../interface_adapters/presentation/navigation/shared/uri_config_holder.dart';
import '../../../../../interface_adapters/presentation/navigation/shared/uri_config_parser_locator.dart';
import '../../shared/route_information_parser.dart';
import 'mobile_root_router_delegate.dart';

class MobileRootRouter extends StatefulWidget {
  const MobileRootRouter({
    super.key,
  });

  @override
  State<MobileRootRouter> createState() => _MobileRootRouterState();
}

class _MobileRootRouterState extends State<MobileRootRouter> {
  late final MobileNavigatorPresenter _navigatorPresenter;
  late final MobileRootRouterDelegate _routerDelegate;
  late final RouteInformationProvider _routeInformationProvider;
  late final AppRouteInformationParser _routeInformationParser;
  late final BackButtonDispatcher _backButtonDispatcher;

  @override
  void initState() {
    super.initState();

    _navigatorPresenter = di();

    _routerDelegate = MobileRootRouterDelegate(
      navigatorPresenter: _navigatorPresenter,
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
    di.resetLazySingleton<MobileNavigator>();
    di.resetLazySingleton<MobileNavigatorPresenter>();
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
