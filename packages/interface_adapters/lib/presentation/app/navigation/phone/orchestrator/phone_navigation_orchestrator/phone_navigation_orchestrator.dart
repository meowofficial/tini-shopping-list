import 'package:common/disposable.dart';

import '../../../../../core/navigation/phone/phone_home_tab.dart';
import '../../../../../core/navigation/shared/app_routes.dart';
import '../../../shared/uri_configs.dart';

abstract interface class PhoneNavigationOrchestrator implements Disposable {
  void onRouteAddedToRootNavigator({
    required AppRoute route,
  });

  void onRouteRemovedFromRootNavigator({
    required AppRoute route,
  });

  void onRootRoutePopped({
    required AppRoute route,
  });

  void onRouteAddedToHomeTabNavigator({
    required AppRoute route,
    required PhoneHomeTab homeTab,
  });

  void onRouteRemovedFromHomeTabNavigator({
    required AppRoute route,
    required PhoneHomeTab homeTab,
  });

  void onHomeTabRoutePopped({
    required AppRoute route,
    required PhoneHomeTab homeTab,
  });

  void onPlatformUriConfigChanged(UriConfig uriConfig);

  UriConfig? getCurrentUriConfig();
}
