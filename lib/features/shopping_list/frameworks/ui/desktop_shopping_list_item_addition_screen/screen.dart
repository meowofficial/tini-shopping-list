import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../injection_container.dart';
import '../../../interface_adapters/presentation/desktop_shopping_list_item_addition_screen/screen/interfaces/shopping_list_item_addition_screen_presenter.dart';
import '../../../interface_adapters/presentation/desktop_shopping_list_item_addition_screen/screen/presenters/shopping_list_item_addition_screen_presenter.dart';
import 'screen_view_widget.dart';

class DesktopShoppingListItemAdditionScreen extends StatefulWidget {
  const DesktopShoppingListItemAdditionScreen({
    super.key,
  });

  @override
  State<DesktopShoppingListItemAdditionScreen> createState() =>
      _DesktopShoppingListItemAdditionScreenState();
}

class _DesktopShoppingListItemAdditionScreenState
    extends State<DesktopShoppingListItemAdditionScreen> {
  late final ShoppingListItemAdditionScreenPresenter _presenter;

  @override
  void initState() {
    super.initState();

    _presenter = ShoppingListItemAdditionScreenPresenterImpl(
      translation: di(),
      readShoppingListItemAdditionFlowState: di(),
      readUiLocale: di(),
      submitNewShoppingListItemDraft: di(),
      stopShoppingListItemAddition: di(),
      updateNewShoppingListDraftItemTitle: di(),
      watchUiLocale: di(),
      watchShoppingListItemAdditionFlowState: di(),
    );
  }

  @override
  void dispose() {
    _presenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DesktopShoppingListItemAdditionScreenViewWidget(
      presenter: _presenter,
    );
  }
}
