import '../../../../../../../core/common/disposable.dart';
import '../../../../../../../core/interface_adapters/presentation/navigation/shared/app_routes.dart';
import '../../../../../../../core/interface_adapters/presentation/view_streamable.dart';
import '../views/phone_home_overview_tab_router_view.dart';

abstract interface class PhoneHomeOverviewTabRouterPresenter
    implements AsyncViewStreamable<PhoneHomeOverviewTabRouterView>, Disposable {
  void onRouteAddedToNavigator(AppRoute route);

  void onRouteRemovedFromNavigator(AppRoute route);

  void onRoutePopped(AppRoute route);
}
