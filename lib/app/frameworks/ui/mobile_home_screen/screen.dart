import 'package:flutter/cupertino.dart';

import '../../../../../injection_container.dart';
import '../../../interface_adapters/presentation/mobile_home_screen/interfaces/mobile_home_screen_presenter.dart';
import '../../../interface_adapters/presentation/mobile_home_screen/presenters/mobile_home_screen_presenter.dart';
import 'screen_view_widget.dart';

class MobileHomeScreen extends StatefulWidget {
  const MobileHomeScreen({
    super.key,
  });

  @override
  State<MobileHomeScreen> createState() => _MobileHomeScreenState();
}

class _MobileHomeScreenState extends State<MobileHomeScreen> {
  late final MobileHomeScreenPresenter _presenter;

  @override
  void initState() {
    super.initState();

    _presenter = MobileHomeScreenPresenterImpl(
      navigator: di(),
    );
  }

  @override
  void dispose() {
    _presenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MobileHomeScreenViewWidget(
      presenter: _presenter,
    );
  }
}
