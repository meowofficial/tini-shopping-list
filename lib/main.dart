import 'package:flutter/cupertino.dart' hide RootWidget;
import 'package:flutter/material.dart' hide RootWidget;
import 'package:flutter_web_plugins/url_strategy.dart';

import 'app/interface_adapters/presentation/app/desktop_app_presenter.dart';
import 'injection_container.dart';
import 'root_routers.dart';

void main() {
  usePathUrlStrategy();
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
  @override
  void initState() {
    super.initState();

    AppPresenterImpl(
      initializeStores: di(),
      handleAppLaunch: di(),
      readAppInitializationFlowState: di(),
    ).initialize();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
                fontFamily: 'Inter',
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
      home: const RootRouter(),
    );
  }
}
