import 'package:flutter/material.dart';

import '../../../interface_adapters/presentation/desktop_shopping_list_overview_screen/interfaces/shopping_list_overview_screen_view_presenters.dart';
import 'shopping_list_item_view_widget.dart';

class ScreenBodyLoadedViewWidget extends StatelessWidget {
  const ScreenBodyLoadedViewWidget({
    required this.presenter,
    super.key,
  });

  final ShoppingListOverviewScreenLoadedViewPresenter presenter;

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                  SliverList.separated(
                    itemCount: presenter.shoppingListItemViewPresenters.length,
                    itemBuilder: (context, index) {
                      final shoppingListItemViewPresenter =
                          presenter.shoppingListItemViewPresenters[index];

                      return ShoppingListItemViewWidget(
                        presenter: shoppingListItemViewPresenter,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 10);
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
    );
  }
}
