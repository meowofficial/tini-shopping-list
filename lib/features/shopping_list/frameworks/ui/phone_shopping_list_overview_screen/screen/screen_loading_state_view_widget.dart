import 'package:flutter/material.dart';

import '../../../../../../core/frameworks/ui/size_configs/navigation_bar_size_config.dart';
import '../../../../../../core/frameworks/ui/ui_kit/circular_progress_indicator.dart';
import '../../../../../../core/frameworks/ui/ui_kit/navigation_bar_title_widget.dart';
import '../../../../../../core/frameworks/ui/ui_kit/scaffold.dart';
import '../../../../../../core/frameworks/ui/utils/view_stream_builder.dart';
import '../../../../interface_adapters/presentation/phone_shopping_list_overview_screen/screen/interfaces/shopping_list_overview_screen_state_presenters.dart';

class ScreenLoadingStateViewWidget extends StatelessWidget {
  const ScreenLoadingStateViewWidget({
    required this.presenter,
    super.key,
  });

  final ShoppingListOverviewScreenLoadingStatePresenter presenter;

  @override
  Widget build(BuildContext context) {
    return ScreenLoadingStateViewInternalWidget(
      presenter: presenter,
      navigationBarSizeConfig: const NavigationBarSizeConfig(),
    );
  }
}

@visibleForTesting
class ScreenLoadingStateViewInternalWidget extends StatelessWidget {
  const ScreenLoadingStateViewInternalWidget({
    required this.presenter,
    required this.navigationBarSizeConfig,
    super.key,
  });

  final ShoppingListOverviewScreenLoadingStatePresenter presenter;
  final NavigationBarSizeConfig navigationBarSizeConfig;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      navigationBarMiddle: _buildTitle(),
      child: const Center(
        child: AppCircularProgressIndicator(
          size: 30,
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return ConverterViewStreamBuilder(
      viewStreamable: presenter,
      converter: (view) => view.title,
      builder: (context, title) {
        return NavigationBarTitleWidget(
          title: title,
          fontSize: navigationBarSizeConfig.getTitleFontSize(),
        );
      },
    );
  }
}
