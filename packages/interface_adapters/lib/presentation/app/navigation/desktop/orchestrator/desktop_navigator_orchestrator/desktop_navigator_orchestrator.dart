import 'package:common/disposable.dart';
import 'package:common/stream/state_streamable.dart';

import '../../../../../core/navigation/desktop/navigator/desktop_navigator.dart';
import '../../../../../core/navigation/shared/app_routes.dart';
import '../../../shared/uri_configs.dart';

abstract interface class DesktopNavigationOrchestrator
    implements AsyncStateStreamable<DesktopNavigatorState>, Disposable {
  void onRouteAddedToRootNavigator({
    required AppRoute route,
  });

  void onRouteRemovedFromRootNavigator({
    required AppRoute route,
  });

  void onRootRoutePopped({
    required AppRoute route,
  });

  void onPlatformUriConfigChanged(UriConfig uriConfig);

  UriConfig? getCurrentUserConfig();
}
