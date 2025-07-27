import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:interface_adapters/presentation/phone_shopping_list_item_addition_screen/screen/presenters/shopping_list_item_addition_screen_presenter/shopping_list_item_addition_screen_presenter.dart';
import 'package:interface_adapters/presentation/phone_shopping_list_item_addition_screen/screen/presenters/shopping_list_item_addition_screen_state_presenter/shopping_list_item_addition_screen_state_presenter.dart';

import 'screen_idle_state_view_widget.dart';
import 'screen_ready_state_view_widget.dart';

class PhoneShoppingListItemAdditionScreenViewWidget extends StatelessWidget {
  const PhoneShoppingListItemAdditionScreenViewWidget({
    required this.presenter,
    super.key,
  });

  final ShoppingListItemAdditionScreenPresenter presenter;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: presenter.updateStream,
      builder: (context, _) {
        final currentStatePresenter = presenter.currentStatePresenter;

        switch (currentStatePresenter) {
          case ShoppingListItemAdditionScreenIdleStatePresenter():
            return const ScreenIdleStateViewWidget();

          case ShoppingListItemAdditionScreenReadyStatePresenter():
            return ScreenReadyStateViewWidget(
              presenter: currentStatePresenter,
            );
        }
      },
    );
  }
}
