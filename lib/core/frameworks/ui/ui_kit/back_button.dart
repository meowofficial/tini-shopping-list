import 'package:flutter/cupertino.dart';

import '../theme/core_theme.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({
    required this.onPressed,
    super.key,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoNavigationBarBackButton(
      color: CoreTheme.of(context).primaryColor,
      onPressed: onPressed,
    );
  }
}
