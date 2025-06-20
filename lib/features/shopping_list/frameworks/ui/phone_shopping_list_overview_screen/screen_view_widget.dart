import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../core/frameworks/ui/ui_kit/navigation_bar_title_widget.dart';
import '../../../interface_adapters/presentation/phone_shopping_list_overview_screen/interfaces/shopping_list_overview_screen_presenter.dart';
import '../../../interface_adapters/presentation/phone_shopping_list_overview_screen/interfaces/shopping_list_overview_screen_state_presenters.dart';
import 'screen_body_loaded_state_view_widget.dart';
import 'screen_body_loading_state_view_widget.dart';

class PhoneShoppingListOverviewScreenViewWidget extends StatelessWidget {
  const PhoneShoppingListOverviewScreenViewWidget({
    required this.presenter,
    super.key,
  });

  final ShoppingListOverviewScreenPresenter presenter;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: presenter.updateStream,
      builder: (context, _) {
        return CupertinoPageScaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: const Color(0xfff2f2f7),
          navigationBar: const CupertinoNavigationBar(
            transitionBetweenRoutes: false,
            backgroundColor: Colors.white,
            brightness: Brightness.light,
            automaticallyImplyLeading: false,
            automaticallyImplyMiddle: false,
            padding: EdgeInsetsDirectional.zero,
            middle: NavigationBarTitleWidget(
              title: 'Список покупок',
            ),
          ),
          child: SizedBox.expand(
            child: _buildScreenBody(
              context: context,
            ),
          ),
        );
      },
    );
  }

  Widget _buildScreenBody({
    required BuildContext context,
  }) {
    final currentStatePresenter = presenter.currentStatePresenter;

    switch (currentStatePresenter) {
      case ShoppingListOverviewScreenLoadingStatePresenter():
        return const ScreenBodyLoadingStateViewWidget();

      case ShoppingListOverviewScreenLoadedStatePresenter():
        return ScreenBodyLoadedStateViewWidget(
          presenter: currentStatePresenter,
        );
    }
  }
}
