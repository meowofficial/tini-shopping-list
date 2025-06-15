import 'package:flutter/material.dart';

class ScreenBodyLoadingViewWidget extends StatelessWidget {
  const ScreenBodyLoadingViewWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        width: 50,
        height: 50,
        child: CircularProgressIndicator(),
      ),
    );
  }
}
