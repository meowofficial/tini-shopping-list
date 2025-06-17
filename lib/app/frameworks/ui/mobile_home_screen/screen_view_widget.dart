import 'package:flutter/widgets.dart';

import '../../../../../../core/frameworks/ui/utils/view_stream_builder.dart';
import '../../../../../../core/interface_adapters/presentation/navigation/mobile/mobile_home_tab.dart';
import '../../../interface_adapters/presentation/mobile_home_screen/interfaces/mobile_home_screen_presenter.dart';
import '../navigation/mobile/home_addition_tab/mobile_home_addition_tab_router.dart';
import '../navigation/mobile/home_overview_tab/mobile_home_overview_tab_router.dart';
import 'widgets/home_tab_scaffold.dart';

class MobileHomeScreenViewWidget extends StatelessWidget {
  const MobileHomeScreenViewWidget({
    required this.presenter,
    super.key,
  });

  final MobileHomeScreenPresenter presenter;

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
              case MobileHomeTab.overview:
                return const MobileHomeOverviewTabRouter();

              case MobileHomeTab.addition:
                return const MobileHomeAdditionTabRouter();
            }
          },
        );
      },
    );
  }
}
