import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:interface_adapters/presentation/phone_shopping_list_overview_screen/screen/presenters/shopping_list_overview_screen_presenter/shopping_list_overview_screen_presenter.dart';
import 'package:interface_adapters/presentation/phone_shopping_list_overview_screen/screen/presenters/shopping_list_overview_screen_state_presenter/shopping_list_overview_screen_state_presenter.dart';

import 'screen_loaded_state_view_widget.dart';
import 'screen_loading_state_view_widget.dart';

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
        final currentStatePresenter = presenter.currentStatePresenter;

        switch (currentStatePresenter) {
          case ShoppingListOverviewScreenLoadingStatePresenter():
            return ScreenLoadingStateViewWidget(
              presenter: currentStatePresenter,
            );

          case ShoppingListOverviewScreenLoadedStatePresenter():
            return ScreenLoadedStateViewWidget(
              presenter: currentStatePresenter,
            );
        }
      },
    );
  }
}
