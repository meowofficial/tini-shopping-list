import 'package:flutter/material.dart';

import '../theme/app_styles.dart';
import '../theme/core_theme.dart';

class NavigationBarTitleWidget extends StatelessWidget {
  const NavigationBarTitleWidget({
    required this.title,
    required this.fontSize,
    super.key,
  });

  final String title;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppStyles.baseTextStyle.copyWith(
        fontVariations: const [
          FontVariation.weight(500),
        ],
        color: switch (CoreTheme.brightnessOf(context)) {
          Brightness.dark => AppStyles.white,
          Brightness.light => AppStyles.black,
        },
        fontSize: fontSize,
      ),
    );
  }
}
