import 'package:common/disposable.dart';

import '../../../core/navigation/phone/phone_home_tab.dart';
import '../../../core/view_streamable.dart';
import '../views/phone_home_shell_screen_view.dart';

abstract interface class PhoneHomeShellScreenPresenter
    implements AsyncViewStreamable<PhoneHomeShellScreenView>, Disposable {
  void onTabPressed(PhoneHomeTab tab);
}
