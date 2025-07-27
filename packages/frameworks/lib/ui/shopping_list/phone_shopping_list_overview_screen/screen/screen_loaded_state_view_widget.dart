import 'package:flutter/material.dart';
import 'package:interface_adapters/presentation/phone_shopping_list_overview_screen/screen/presenters/shopping_list_overview_screen_state_presenter/shopping_list_overview_screen_state_presenter.dart';

import '../../../core/size_configs/navigation_bar_size_config.dart';
import '../../../core/ui_kit/navigation_bar_title_widget.dart';
import '../../../core/ui_kit/scaffold.dart';
import '../../../core/utils/view_stream_builder.dart';
import '../shopping_list_item/shopping_list_item_view_widget.dart';

class ScreenLoadedStateViewWidget extends StatelessWidget {
  const ScreenLoadedStateViewWidget({
    required this.presenter,
    super.key,
  });

  final ShoppingListOverviewScreenLoadedStatePresenter presenter;

  @override
  Widget build(BuildContext context) {
    return ScreenLoadedStateViewInternalWidget(
      presenter: presenter,
      navigationBarSizeConfig: const NavigationBarSizeConfig(),
    );
  }
}

@visibleForTesting
class ScreenLoadedStateViewInternalWidget extends StatelessWidget {
  const ScreenLoadedStateViewInternalWidget({
    required this.presenter,
    required this.navigationBarSizeConfig,
    super.key,
  });

  final ShoppingListOverviewScreenLoadedStatePresenter presenter;
  final NavigationBarSizeConfig navigationBarSizeConfig;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      navigationBarMiddle: _buildTitle(),
      child: Scrollbar(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(
              scrollbars: false,
            ),
            child: CustomScrollView(
              primary: true,
              physics: ScrollConfiguration.of(context).getScrollPhysics(context),
              slivers: [
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 20,
                  ),
                ),
                StreamBuilder(
                  initialData: presenter.shoppingListItemPresenters,
                  stream: presenter.shoppingListItemPresenterStream,
                  builder: (context, snapshot) {
                    final shoppingListItemPresenters = snapshot.requireData;

                    return SliverList.separated(
                      itemCount: shoppingListItemPresenters.length,
                      itemBuilder: (context, index) {
                        final shoppingListItemPresenter = shoppingListItemPresenters[index];

                        return ShoppingListItemViewWidget(
                          presenter: shoppingListItemPresenter,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 10);
                      },
                    );
                  },
                ),
                const SliverSafeArea(
                  sliver: SliverToBoxAdapter(
                    child: SizedBox(
                      height: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
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
