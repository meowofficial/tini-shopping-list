import 'package:flutter/cupertino.dart';

import '../theme/app_styles.dart';
import '../theme/core_theme.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    required this.child,
    this.navigationBarLeading,
    this.navigationBarTrailing,
    this.navigationBarMiddle,
    super.key,
  });

  final Widget? navigationBarLeading;
  final Widget? navigationBarTrailing;
  final Widget? navigationBarMiddle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final brightness = CoreTheme.brightnessOf(context);

    final backgroundColor = switch (brightness) {
      Brightness.dark => AppStyles.black,
      Brightness.light => AppStyles.lightGrey1,
    };

    final navigationBarColor = switch (brightness) {
      Brightness.dark => AppStyles.darkGrey4,
      Brightness.light => AppStyles.white,
    };

    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroundColor,
      navigationBar: CupertinoNavigationBar(
        transitionBetweenRoutes: false,
        backgroundColor: navigationBarColor,
        automaticallyImplyLeading: false,
        automaticallyImplyMiddle: false,
        automaticBackgroundVisibility: false,
        padding: EdgeInsetsDirectional.zero,
        leading: navigationBarLeading,
        trailing: navigationBarTrailing,
        middle: navigationBarMiddle,
      ),
      child: SizedBox.expand(
        child: child,
      ),
    );
  }
}
