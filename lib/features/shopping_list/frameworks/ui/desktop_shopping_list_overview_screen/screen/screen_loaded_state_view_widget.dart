import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/frameworks/ui/ui_kit/navigation_bar_title_widget.dart';
import '../../../../../../core/frameworks/ui/utils/view_stream_builder.dart';
import '../../../../interface_adapters/presentation/desktop_shopping_list_overview_screen/screen/interfaces/shopping_list_overview_screen_state_presenters.dart';
import '../shopping_list_item/shopping_list_item_view_widget.dart';

class ScreenLoadedStateViewWidget extends StatelessWidget {
  const ScreenLoadedStateViewWidget({
    required this.presenter,
    super.key,
  });

  final ShoppingListOverviewScreenLoadedStatePresenter presenter;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xfff2f2f7),
      navigationBar: CupertinoNavigationBar(
        transitionBetweenRoutes: false,
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        automaticallyImplyLeading: false,
        automaticallyImplyMiddle: false,
        automaticBackgroundVisibility: false,
        padding: EdgeInsetsDirectional.zero,
        middle: _buildTitle(),
      ),
      child: SizedBox.expand(
        child: Stack(
          children: [
            Scrollbar(
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
            Positioned(
              right: 40,
              bottom: 40,
              child: FloatingActionButton(
                backgroundColor: Theme.of(context).primaryColor,
                onPressed: presenter.onShoppingListItemAdditionButtonPressed,
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
          ],
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
        );
      },
    );
  }
}
