import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_list/home_screen/frameworks/presentation/home_screen.dart';

void main() {
  runApp(const AppWidget());
}

class AppWidget extends StatelessWidget {
  const AppWidget({
    super.key,
  });

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
                brightness: brightness,
                textSelectionTheme: TextSelectionThemeData(
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
                data: CupertinoThemeData(
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
      home: HomeScreen(),
    );
  }
}
