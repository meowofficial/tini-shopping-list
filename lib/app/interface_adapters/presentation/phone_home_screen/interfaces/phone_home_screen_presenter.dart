import '../../../../../../core/interface_adapters/presentation/navigation/phone/phone_home_tab.dart';
import '../../../../../../core/interface_adapters/presentation/view_streamable.dart';
import '../../../../../core/common/disposable.dart';
import '../views/phone_home_screen_view.dart';

abstract interface class PhoneHomeScreenPresenter
    implements AsyncViewStreamable<PhoneHomeScreenView>, Disposable {
  void onTabPressed(PhoneHomeTab tab);
}
