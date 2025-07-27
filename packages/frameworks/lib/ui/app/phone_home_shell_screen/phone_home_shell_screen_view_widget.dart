import 'package:flutter/widgets.dart';
import 'package:interface_adapters/presentation/app/phone_home_shell_screen/presenters/phone_home_shell_screen_presenter.dart';
import 'package:interface_adapters/presentation/core/navigation/phone/phone_home_tab.dart';

import '../../core/utils/view_stream_builder.dart';
import '../navigation/phone/home_addition_tab/phone_home_addition_tab_router.dart';
import '../navigation/phone/home_overview_tab/phone_home_overview_tab_router.dart';
import 'widgets/home_tab_scaffold.dart';

class PhoneHomeShellScreenViewWidget extends StatelessWidget {
  const PhoneHomeShellScreenViewWidget({
    required this.presenter,
    super.key,
  });

  final PhoneHomeShellScreenPresenter presenter;

  @override
  Widget build(BuildContext context) {
    return ViewStreamBuilder(
      viewStreamable: presenter,
      builder: (context, view) {
        return HomeTabScaffold(
          activeTab: view.activeTab,
          onTabPressed: presenter.onTabPressed,
          tabLabelBuilder: (tab) {
            return switch (tab) {
              PhoneHomeTab.overview => view.overviewTabLabel,
              PhoneHomeTab.addition => view.additionTabLabel,
            };
          },
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
