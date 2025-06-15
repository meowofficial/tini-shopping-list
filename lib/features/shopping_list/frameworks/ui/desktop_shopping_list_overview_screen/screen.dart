import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../injection_container.dart';
import '../../../interface_adapters/presentation/desktop_shopping_list_overview_screen/interfaces/shopping_list_overview_screen_presenter.dart';
import '../../../interface_adapters/presentation/desktop_shopping_list_overview_screen/interfaces/shopping_list_overview_screen_view_presenters.dart';
import '../../../interface_adapters/presentation/desktop_shopping_list_overview_screen/presenters/shopping_list_overview_screen_presenter.dart';
import 'screen_body_loaded_view_widget.dart';
import 'screen_body_loading_view_widget.dart';

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
      loadShoppingListItems: di(),
      readShoppingListOverviewFlowState: di(),
      startShoppingListItemAddition: di(),
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
        return CupertinoPageScaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: const Color(0xfff2f2f7),
          navigationBar: const CupertinoNavigationBar(
            backgroundColor: Colors.white,
            brightness: Brightness.light,
            automaticallyImplyLeading: false,
            automaticallyImplyMiddle: false,
            padding: EdgeInsetsDirectional.zero,
            middle: Text(
              'Список покупок',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                height: 1.0,
                color: Colors.black,
                fontSize: 20,
              ),
            ),
          ),
          child: SizedBox.expand(
            child: _buildPageBody(
              context: context,
            ),
          ),
        );
      },
    );
  }

  Widget _buildPageBody({
    required BuildContext context,
  }) {
    final currentViewPresenter = _presenter.currentViewPresenter;

    switch (currentViewPresenter) {
      case ShoppingListOverviewScreenLoadingViewPresenter():
        return const ScreenBodyLoadingViewWidget();

      case ShoppingListOverviewScreenLoadedViewPresenter():
        return ScreenBodyLoadedViewWidget(
          presenter: currentViewPresenter,
        );
    }
  }
}
