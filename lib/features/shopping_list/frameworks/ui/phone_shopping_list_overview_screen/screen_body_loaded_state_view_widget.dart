import 'package:flutter/material.dart';

import '../../../interface_adapters/presentation/phone_shopping_list_overview_screen/interfaces/shopping_list_overview_screen_state_presenters.dart';
import 'shopping_list_item_view_widget.dart';

class ScreenBodyLoadedStateViewWidget extends StatelessWidget {
  const ScreenBodyLoadedStateViewWidget({
    required this.presenter,
    super.key,
  });

  final ShoppingListOverviewScreenLoadedStatePresenter presenter;

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
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
                initialData: presenter.shoppingListItemViewPresenters,
                stream: presenter.shoppingListItemViewPresenterStream,
                builder: (context, snapshot) {
                  final shoppingListItemViewPresenters = snapshot.requireData;

                  return SliverList.separated(
                    itemCount: shoppingListItemViewPresenters.length,
                    itemBuilder: (context, index) {
                      final shoppingListItemViewPresenter =
                          shoppingListItemViewPresenters[index];

                      return ShoppingListItemViewWidget(
                        presenter: shoppingListItemViewPresenter,
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
    );
  }
}
