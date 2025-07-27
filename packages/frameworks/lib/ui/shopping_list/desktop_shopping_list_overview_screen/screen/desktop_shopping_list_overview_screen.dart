import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:interface_adapters/presentation/desktop_shopping_list_overview_screen/screen/presenters/shopping_list_overview_screen_presenter/impl/shopping_list_overview_screen_presenter_impl.dart';
import 'package:interface_adapters/presentation/desktop_shopping_list_overview_screen/screen/presenters/shopping_list_overview_screen_presenter/shopping_list_overview_screen_presenter.dart';
import 'package:interface_adapters/presentation/desktop_shopping_list_overview_screen/screen/presenters/shopping_list_overview_screen_state_presenter/shopping_list_overview_screen_state_presenter.dart';

import '../../../../../../injection_container.dart';
import 'screen_loaded_state_view_widget.dart';
import 'screen_loading_state_view_widget.dart';

class DesktopShoppingListOverviewScreen extends StatefulWidget {
  const DesktopShoppingListOverviewScreen({
    super.key,
  });

  @override
  State<DesktopShoppingListOverviewScreen> createState() =>
      _DesktopShoppingListOverviewScreenState();
}

class _DesktopShoppingListOverviewScreenState extends State<DesktopShoppingListOverviewScreen> {
  late final ShoppingListOverviewScreenPresenter _presenter;

  @override
  void initState() {
    super.initState();

    _presenter = ShoppingListOverviewScreenPresenterImpl(
      shoppingListOverviewScreenStatePresenterFactory: di(),
      loadShoppingListItems: di(),
      readShoppingListOverviewFlowState: di(),
      watchShoppingListOverviewFlowState: di(),
    );
  }

  @override
  void dispose() {
    _presenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _presenter.updateStream,
      builder: (context, _) {
        final currentStatePresenter = _presenter.currentStatePresenter;

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
