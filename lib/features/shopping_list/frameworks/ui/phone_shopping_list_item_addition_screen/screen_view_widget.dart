import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../core/frameworks/ui/ui_kit/navigation_bar_title_widget.dart';
import '../../../interface_adapters/presentation/phone_shopping_list_item_addition_screen/interfaces/shopping_list_item_addition_screen_presenter.dart';
import '../../../interface_adapters/presentation/phone_shopping_list_item_addition_screen/interfaces/shopping_list_item_addition_screen_state_presenters.dart';
import 'screen_body_idle_state_view_widget.dart';
import 'screen_body_ready_state_view_widget.dart';

class PhoneShoppingListItemAdditionScreenViewWidget extends StatelessWidget {
  const PhoneShoppingListItemAdditionScreenViewWidget({
    required this.presenter,
    super.key,
  });

  final ShoppingListItemAdditionScreenPresenter presenter;

  @override
  Widget build(BuildContext context) {
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
          title: 'Добавление элемента',
        ),
      ),
      child: SizedBox.expand(
        child: _buildScreenBody(
          context: context,
        ),
      ),
    );
  }

  Widget _buildScreenBody({
    required BuildContext context,
  }) {
    final currentStatePresenter = presenter.currentStatePresenter;

    switch (currentStatePresenter) {
      case ShoppingListItemAdditionScreenIdleStatePresenter():
        return const ScreenBodyIdleStateViewWidget();

      case ShoppingListItemAdditionScreenReadyStatePresenter():
        return ScreenBodyReadyStateViewWidget(
          presenter: currentStatePresenter,
        );
    }
  }
}
