import 'package:flutter/material.dart';

class ScreenBodyLoadingStateViewWidget extends StatelessWidget {
  const ScreenBodyLoadingStateViewWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        width: 30,
        height: 30,
        child: CircularProgressIndicator(),
      ),
    );
  }
}
