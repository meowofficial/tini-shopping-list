import 'package:flutter/material.dart';

import '../../core/theme/app_styles.dart';
import '../../core/theme/core_theme.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: switch (CoreTheme.brightnessOf(context)) {
        Brightness.dark => AppStyles.black,
        Brightness.light => AppStyles.white,
      },
    );
  }
}
