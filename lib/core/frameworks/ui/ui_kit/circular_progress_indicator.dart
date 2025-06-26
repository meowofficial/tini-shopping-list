import 'package:flutter/material.dart';

import '../theme/core_theme.dart';

class AppCircularProgressIndicator extends StatelessWidget {
  const AppCircularProgressIndicator({
    required this.size,
    super.key,
  });

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: CircularProgressIndicator(
        color: CoreTheme.of(context).primaryColor,
      ),
    );
  }
}
