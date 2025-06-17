import '../../../../../../core/common/stream/disposable.dart';
import '../../../../../../core/interface_adapters/presentation/navigation/mobile/mobile_home_tab.dart';
import '../../../../../../core/interface_adapters/presentation/view_streamable.dart';
import '../views/mobile_home_screen_view.dart';

abstract interface class MobileHomeScreenPresenter
    implements AsyncViewStreamable<MobileHomeScreenView>, Disposable {
  void onTabPressed(MobileHomeTab tab);
}
