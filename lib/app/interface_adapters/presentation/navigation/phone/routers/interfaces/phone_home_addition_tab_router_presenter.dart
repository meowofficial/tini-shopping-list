import '../../../../../../../core/common/disposable.dart';
import '../../../../../../../core/interface_adapters/presentation/navigation/shared/app_routes.dart';
import '../../../../../../../core/interface_adapters/presentation/view_streamable.dart';
import '../views/phone_home_addition_tab_router_view.dart';

abstract interface class PhoneHomeAdditionTabRouterPresenter
    implements AsyncViewStreamable<PhoneHomeAdditionTabRouterView>, Disposable {
  void onRouteAddedToNavigator(AppRoute route);

  void onRouteRemovedFromNavigator(AppRoute route);

  void onRoutePopped(AppRoute route);
}
