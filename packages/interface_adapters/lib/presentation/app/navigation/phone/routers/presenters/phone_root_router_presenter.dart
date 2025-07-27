import 'package:common/disposable.dart';

import '../../../../../core/navigation/shared/app_routes.dart';
import '../../../../../core/view_streamable.dart';
import '../../../shared/uri_configs.dart';
import '../views/phone_root_router_view.dart';

abstract interface class PhoneRootRouterPresenter
    implements AsyncViewStreamable<PhoneRootRouterView>, Disposable {
  Stream<void> get navigatorUpdateStream;

  void onRouteAddedToNavigator(AppRoute route);

  void onRouteRemovedFromNavigator(AppRoute route);

  void onRoutePopped(AppRoute route);

  void onPlatformUriConfigChanged(UriConfig uriConfig);

  UriConfig? getCurrentUserConfig();
}
