import 'package:flutter/material.dart';
import 'package:interface_adapters/presentation/phone_shopping_list_overview_screen/screen/presenters/shopping_list_overview_screen_state_presenter/shopping_list_overview_screen_state_presenter.dart';

import '../../../core/size_configs/navigation_bar_size_config.dart';
import '../../../core/ui_kit/circular_progress_indicator.dart';
import '../../../core/ui_kit/navigation_bar_title_widget.dart';
import '../../../core/ui_kit/scaffold.dart';
import '../../../core/utils/view_stream_builder.dart';

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
