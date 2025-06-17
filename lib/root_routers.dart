import 'package:flutter/material.dart';

import 'app/frameworks/ui/navigation/desktop/desktop_root_router.dart';
import 'app/frameworks/ui/navigation/mobile/root/mobile_root_router.dart';

class RootRouter extends StatelessWidget {
  const RootRouter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    if (width < 600) {
      return const MobileRootRouter();
    }

    if (width < 1000) {
      return Container(
        color: Colors.green,
      );
    }

    return const DesktopRootRouter();
  }
}
