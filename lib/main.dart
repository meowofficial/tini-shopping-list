import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app/frameworks/ui/navigation/desktop/desktop_router_delegate.dart';
import 'app/frameworks/ui/navigation/shared/route_information_parser.dart';
import 'app/interface_adapters/presentation/app/desktop_app_presenter.dart';
import 'app/interface_adapters/presentation/navigation/desktop/desktop_navigator_presenter.dart';
import 'app/interface_adapters/presentation/navigation/shared/uri_config_parser_locator.dart';
import 'injection_container.dart';

void main() {
  configureDependencies();
  runApp(const AppWidget());
}

class AppWidget extends StatefulWidget {
  const AppWidget({
    super.key,
  });

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  late final DesktopNavigatorPresenter _desktopNavigatorPresenter;
  late final DesktopRouterDelegate _routerDelegate;
  late final AppRouteInformationParser _routeInformationParser;
  late final BackButtonDispatcher _backButtonDispatcher;

  @override
  void initState() {
    super.initState();

    AppPresenterImpl(
      initializeStores: di(),
      handleAppLaunch: di(),
      readAppInitializationFlowState: di(),
    );

    _desktopNavigatorPresenter = DesktopNavigatorPresenterImpl(
      desktopNavigator: di(),
      desktopNavigatorUriConfigParserLocator: di(),
      readShoppingListItemAdditionFlowState: di(),
      startShoppingListItemAddition: di(),
      watchAppInitializationFlowState: di(),
      readAppInitializationFlowState: di(),
      uuidGenerator: di(),
    );

    _routerDelegate = DesktopRouterDelegate(
      navigatorPresenter: _desktopNavigatorPresenter,
    );

    _routeInformationParser = AppRouteInformationParser(
      uriConfigParserLocator: UriConfigParserLocator(),
    );

    _backButtonDispatcher = RootBackButtonDispatcher();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        const brightness = Brightness.light;

        const primaryColor = Colors.pink;
        const primaryContrastingColor = Colors.white;

        return MediaQuery.withNoTextScaling(
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (OverscrollIndicatorNotification overscroll) {
              overscroll.disallowIndicator();
              return false;
            },
            child: Theme(
              data: ThemeData(
                brightness: brightness,
                textSelectionTheme: const TextSelectionThemeData(
                  cursorColor: primaryColor,
                  selectionColor: primaryColor,
                  selectionHandleColor: primaryColor,
                ),
                primaryColor: primaryColor,
                pageTransitionsTheme: const PageTransitionsTheme(
                  builders: {
                    TargetPlatform.android: CupertinoPageTransitionsBuilder(),
                    TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
                  },
                ),
              ),
              child: CupertinoTheme(
                data: const CupertinoThemeData(
                  primaryColor: primaryColor,
                  primaryContrastingColor: primaryContrastingColor,
                  brightness: brightness,
                ),
                child: Material(
                  child: child!,
                ),
              ),
            ),
          ),
        );
      },
      routerDelegate: _routerDelegate,
      routeInformationParser: _routeInformationParser,
      backButtonDispatcher: _backButtonDispatcher,
    );
  }
}
