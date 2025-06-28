import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'app/frameworks/ui/navigation/desktop/desktop_root_router_delegate.dart';
import 'app/frameworks/ui/navigation/phone/root/phone_root_router_delegate.dart';
import 'app/frameworks/ui/navigation/shared/route_information_parser.dart';
import 'app/interface_adapters/presentation/app/app_presenter.dart';
import 'app/interface_adapters/presentation/navigation/desktop/orchestrator/desktop_navigator_presenter.dart';
import 'app/interface_adapters/presentation/navigation/desktop/routers/interfaces/desktop_root_router_presenter.dart';
import 'app/interface_adapters/presentation/navigation/desktop/routers/presenters/desktop_root_router_presenter.dart';
import 'app/interface_adapters/presentation/navigation/phone/orchestrator/phone_navigation_orchestrator.dart';
import 'app/interface_adapters/presentation/navigation/phone/routers/interfaces/phone_root_router_presenter.dart';
import 'app/interface_adapters/presentation/navigation/phone/routers/presenters/phone_root_router_presenter.dart';
import 'app/interface_adapters/presentation/navigation/shared/uri_config_holder.dart';
import 'app/interface_adapters/presentation/navigation/shared/uri_configs.dart';
import 'core/frameworks/ui/theme/app_styles.dart';
import 'core/frameworks/ui/theme/core_theme.dart';
import 'core/frameworks/ui/utils/responsive.dart';
import 'core/interface_adapters/presentation/navigation/desktop/desktop_navigator.dart';
import 'core/interface_adapters/presentation/navigation/phone/phone_navigator.dart';
import 'injection_container.dart';

void main() {
  usePathUrlStrategy();
  configureDependencies();

  runApp(
    const ResponsiveProvider(
      child: AppWidget(),
    ),
  );
}

class AppWidget extends StatefulWidget {
  const AppWidget({
    super.key,
  });

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  AppRouterConfig? _routerConfig;

  AppRouterConfig _createAppRouterConfig({
    required ScreenLayout screenLayout,
  }) {
    final routeInformationParser = AppRouteInformationParser(
      uriConfigParserLocator: di(),
    );

    final RouteInformation initialRouteInformation;

    final lastKnownUriConfig = di<UriConfigHolder>().lastKnownUriConfig;

    if (lastKnownUriConfig == null) {
      initialRouteInformation = RouteInformation(
        uri: Uri.parse(WidgetsBinding.instance.platformDispatcher.defaultRouteName),
      );
    } else {
      initialRouteInformation = routeInformationParser.restoreRouteInformation(lastKnownUriConfig);
    }

    final routeInformationProvider = PlatformRouteInformationProvider(
      initialRouteInformation: initialRouteInformation,
    );

    final backButtonDispatcher = RootBackButtonDispatcher();

    switch (screenLayout) {
      case ScreenLayout.phone:
        final presenter = PhoneRootRouterPresenterImpl(
          navigator: di(),
          navigationOrchestrator: di(),
        );

        final routerDelegate = PhoneRootRouterDelegate(
          presenter: presenter,
        );

        return PhoneRouterConfig(
          presenter: presenter,
          routerDelegate: routerDelegate,
          routeInformationParser: routeInformationParser,
          routeInformationProvider: routeInformationProvider,
          backButtonDispatcher: backButtonDispatcher,
        );

      case ScreenLayout.desktop:
        final presenter = DesktopRootRouterPresenterImpl(
          navigator: di(),
          navigationOrchestrator: di(),
        );

        final routerDelegate = DesktopRootRouterDelegate(
          presenter: presenter,
        );

        return DesktopRouterConfig(
          presenter: presenter,
          routerDelegate: routerDelegate,
          routeInformationParser: routeInformationParser,
          routeInformationProvider: routeInformationProvider,
          backButtonDispatcher: backButtonDispatcher,
        );
    }
  }

  void _disposeAppRouterConfig(AppRouterConfig routerConfig) {
    switch (routerConfig) {
      case DesktopRouterConfig():
        di.resetLazySingleton<DesktopNavigator>();
        di.resetLazySingleton<DesktopNavigationOrchestrator>();
        routerConfig.presenter.dispose();
        routerConfig.routerDelegate.dispose();

      case PhoneRouterConfig():
        di.resetLazySingleton<PhoneNavigator>();
        di.resetLazySingleton<PhoneNavigationOrchestrator>();
        routerConfig.presenter.dispose();
        routerConfig.routerDelegate.dispose();
    }
  }

  @override
  void initState() {
    super.initState();

    final appPresenter = AppPresenterImpl(
      initializeStores: di(),
      handleAppLaunch: di(),
      readAppInitializationFlowState: di(),
    );

    appPresenter.initialize();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final screenLayout = Responsive.screenLayoutOf(context);

    if (screenLayout != _routerConfig?.screenLayout) {
      final previousAppRouterConfig = _routerConfig;

      _routerConfig = _createAppRouterConfig(
        screenLayout: screenLayout,
      );

      if (previousAppRouterConfig != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _disposeAppRouterConfig(previousAppRouterConfig);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        const brightness = Brightness.light;

        const primaryColor = AppStyles.pink;
        const primaryContrastingColor = AppStyles.white;

        return MediaQuery.withNoTextScaling(
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overscroll) {
              overscroll.disallowIndicator();
              return false;
            },
            child: Theme(
              data: ThemeData(
                fontFamily: AppStyles.fontFamily,
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
                    TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
                  },
                ),
              ),
              child: CupertinoTheme(
                data: const CupertinoThemeData(
                  primaryColor: primaryColor,
                  primaryContrastingColor: primaryContrastingColor,
                  brightness: brightness,
                ),
                child: CoreTheme(
                  primaryColor: primaryColor,
                  primaryContrastingColor: primaryContrastingColor,
                  brightness: brightness,
                  child: DefaultTextHeightBehavior(
                    textHeightBehavior: const TextHeightBehavior(
                      applyHeightToFirstAscent: false,
                      applyHeightToLastDescent: false,
                    ),
                    child: Material(
                      child: child!,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
      routerConfig: _routerConfig!,
    );
  }
}

class ResponsiveProvider extends StatelessWidget {
  const ResponsiveProvider({
    required this.child,
    super.key,
  });

  final Widget child;

  ResponsiveData _createResponsiveData({
    required Size screenSize,
  }) {
    final screenLayout = switch (screenSize.width) {
      < 600 => ScreenLayout.phone,
      _ => ScreenLayout.desktop,
    };

    return ResponsiveData(
      screenLayout: screenLayout,
      screenSize: screenSize,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);

    final responsiveData = _createResponsiveData(
      screenSize: screenSize,
    );

    return Responsive(
      data: responsiveData,
      child: child,
    );
  }
}

sealed class AppRouterConfig extends RouterConfig<UriConfig> {
  const AppRouterConfig({
    required super.routerDelegate,
    required super.routeInformationParser,
    required super.routeInformationProvider,
    required super.backButtonDispatcher,
  });

  ScreenLayout get screenLayout;
}

class DesktopRouterConfig extends AppRouterConfig {
  const DesktopRouterConfig({
    required this.presenter,
    required DesktopRootRouterDelegate routerDelegate,
    required super.routeInformationParser,
    required super.routeInformationProvider,
    required super.backButtonDispatcher,
  }) : super(
         routerDelegate: routerDelegate,
       );

  final DesktopRootRouterPresenter presenter;

  @override
  DesktopRootRouterDelegate get routerDelegate => super.routerDelegate as DesktopRootRouterDelegate;

  @override
  ScreenLayout get screenLayout => ScreenLayout.desktop;
}

class PhoneRouterConfig extends AppRouterConfig {
  const PhoneRouterConfig({
    required this.presenter,
    required PhoneRootRouterDelegate routerDelegate,
    required super.routeInformationParser,
    required super.routeInformationProvider,
    required super.backButtonDispatcher,
  }) : super(
         routerDelegate: routerDelegate,
       );

  final PhoneRootRouterPresenter presenter;

  @override
  PhoneRootRouterDelegate get routerDelegate => super.routerDelegate as PhoneRootRouterDelegate;

  @override
  ScreenLayout get screenLayout => ScreenLayout.phone;
}
