import 'package:flutter/material.dart';

import '../theme/app_styles.dart';

class AppCheckbox extends StatelessWidget {
  const AppCheckbox({
    required this.value,
    required this.onChanged,
    super.key,
  });

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: value,
      onChanged: (value) {
        onChanged(value!);
      },
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      splashRadius: 0,
      activeColor: AppStyles.pink,
      checkColor: AppStyles.white,
      autofocus: false,
      side: const BorderSide(
        width: 1,
        color: AppStyles.grey2,
      ),
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          width: 3,
          color: AppStyles.grey2,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
