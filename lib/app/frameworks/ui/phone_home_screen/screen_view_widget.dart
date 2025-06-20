import 'package:flutter/widgets.dart';

import '../../../../../../core/frameworks/ui/utils/view_stream_builder.dart';
import '../../../../../../core/interface_adapters/presentation/navigation/phone/phone_home_tab.dart';
import '../../../interface_adapters/presentation/phone_home_screen/interfaces/phone_home_screen_presenter.dart';
import '../navigation/phone/home_addition_tab/phone_home_addition_tab_router.dart';
import '../navigation/phone/home_overview_tab/phone_home_overview_tab_router.dart';
import 'widgets/home_tab_scaffold.dart';

class PhoneHomeScreenViewWidget extends StatelessWidget {
  const PhoneHomeScreenViewWidget({
    required this.presenter,
    super.key,
  });

  final PhoneHomeScreenPresenter presenter;

  @override
  Widget build(BuildContext context) {
    return ViewStreamBuilder(
      viewStreamable: presenter,
      builder: (context, view) {
        return HomeTabScaffold(
          activeTab: view.activeTab,
          onTabPressed: presenter.onTabPressed,
          tabBuilder: (context, tab) {
            switch (tab) {
              case PhoneHomeTab.overview:
                return const PhoneHomeOverviewTabRouter();

              case PhoneHomeTab.addition:
                return const PhoneHomeAdditionTabRouter();
            }
          },
        );
      },
    );
  }
}
