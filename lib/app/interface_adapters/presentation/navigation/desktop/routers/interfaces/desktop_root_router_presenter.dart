import '../../../../../../../core/common/disposable.dart';
import '../../../../../../../core/interface_adapters/presentation/navigation/shared/app_routes.dart';
import '../../../../../../../core/interface_adapters/presentation/view_streamable.dart';
import '../../../shared/uri_configs.dart';
import '../views/desktop_root_router_view.dart';

abstract interface class DesktopRootRouterPresenter
    implements AsyncViewStreamable<DesktopRootRouterView>, Disposable {
  Stream<void> get navigatorUpdateStream;

  void onRouteAddedToNavigator(AppRoute route);

  void onRouteRemovedFromNavigator(AppRoute route);

  void onRoutePopped(AppRoute route);

  void onPlatformUriConfigChanged(UriConfig uriConfig);

  UriConfig? getCurrentUserConfig();
}
