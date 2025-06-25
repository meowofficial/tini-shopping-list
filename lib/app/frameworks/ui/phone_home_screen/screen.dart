import 'package:flutter/cupertino.dart';

import '../../../../../injection_container.dart';
import '../../../interface_adapters/presentation/phone_home_screen/interfaces/phone_home_screen_presenter.dart';
import '../../../interface_adapters/presentation/phone_home_screen/presenters/phone_home_screen_presenter.dart';
import 'screen_view_widget.dart';

class PhoneHomeScreen extends StatefulWidget {
  const PhoneHomeScreen({
    super.key,
  });

  @override
  State<PhoneHomeScreen> createState() => _PhoneHomeScreenState();
}

class _PhoneHomeScreenState extends State<PhoneHomeScreen> {
  late final PhoneHomeScreenPresenter _presenter;

  @override
  void initState() {
    super.initState();

    _presenter = PhoneHomeScreenPresenterImpl(
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
    return PhoneHomeScreenViewWidget(
      presenter: _presenter,
    );
  }
}
