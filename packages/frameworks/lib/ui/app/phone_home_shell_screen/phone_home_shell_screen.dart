import 'package:flutter/widgets.dart';
import 'package:interface_adapters/presentation/app/phone_home_shell_screen/presenters/impl/phone_home_shell_screen_presenter_impl.dart';
import 'package:interface_adapters/presentation/app/phone_home_shell_screen/presenters/phone_home_shell_screen_presenter.dart';

import '../../../../../injection_container.dart';
import 'phone_home_shell_screen_view_widget.dart';

class PhoneHomeShellScreen extends StatefulWidget {
  const PhoneHomeShellScreen({
    super.key,
  });

  @override
  State<PhoneHomeShellScreen> createState() => _PhoneHomeShellScreenState();
}

class _PhoneHomeShellScreenState extends State<PhoneHomeShellScreen> {
  late final PhoneHomeShellScreenPresenter _presenter;

  @override
  void initState() {
    super.initState();

    _presenter = PhoneHomeShellScreenPresenterImpl(
      translation: di(),
      navigator: di(),
      readUiLocale: di(),
      watchUiLocale: di(),
    );
  }

  @override
  void dispose() {
    _presenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PhoneHomeShellScreenViewWidget(
      presenter: _presenter,
    );
  }
}
