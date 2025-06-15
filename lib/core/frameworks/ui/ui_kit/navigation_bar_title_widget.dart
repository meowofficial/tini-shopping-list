import 'package:flutter/material.dart';

class NavigationBarTitleWidget extends StatelessWidget {
  const NavigationBarTitleWidget({
    required this.title,
    super.key,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.w600,
        height: 1.0,
        color: Colors.black,
        fontSize: 20,
      ),
    );
  }
}
