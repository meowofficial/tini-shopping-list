import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../injection_container.dart';
import '../../../interface_adapters/presentation/phone_shopping_list_item_addition_screen/screen/interfaces/shopping_list_item_addition_screen_presenter.dart';
import '../../../interface_adapters/presentation/phone_shopping_list_item_addition_screen/screen/presenters/shopping_list_item_addition_screen_presenter.dart';
import 'screen_view_widget.dart';

class PhoneShoppingListItemAdditionScreen extends StatefulWidget {
  const PhoneShoppingListItemAdditionScreen({
    super.key,
  });

  @override
  State<PhoneShoppingListItemAdditionScreen> createState() =>
      _PhoneShoppingListItemAdditionScreenState();
}

class _PhoneShoppingListItemAdditionScreenState extends State<PhoneShoppingListItemAdditionScreen> {
  late final ShoppingListItemAdditionScreenPresenter _presenter;

  @override
  void initState() {
    super.initState();

    _presenter = ShoppingListItemAdditionScreenPresenterImpl(
      readShoppingListItemAdditionFlowState: di(),
      watchShoppingListItemAdditionFlowState: di(),
      shoppingListItemAdditionScreenStatePresenterFactory: di(),
    );
  }

  @override
  void dispose() {
    _presenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PhoneShoppingListItemAdditionScreenViewWidget(
      presenter: _presenter,
    );
  }
}
