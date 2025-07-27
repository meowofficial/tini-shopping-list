import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:interface_adapters/presentation/phone_shopping_list_overview_screen/screen/presenters/shopping_list_overview_screen_presenter/impl/shopping_list_overview_screen_presenter_impl.dart';
import 'package:interface_adapters/presentation/phone_shopping_list_overview_screen/screen/presenters/shopping_list_overview_screen_presenter/shopping_list_overview_screen_presenter.dart';

import '../../../../../../injection_container.dart';
import 'phone_shopping_list_overview_screen_view_widget.dart';

class PhoneShoppingListOverviewScreen extends StatefulWidget {
  const PhoneShoppingListOverviewScreen({
    super.key,
  });

  @override
  State<PhoneShoppingListOverviewScreen> createState() => _PhoneShoppingListOverviewScreenState();
}

class _PhoneShoppingListOverviewScreenState extends State<PhoneShoppingListOverviewScreen> {
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
    return PhoneShoppingListOverviewScreenViewWidget(
      presenter: _presenter,
    );
  }
}
