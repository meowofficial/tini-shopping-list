import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_list/home_screen/frameworks/presentation/views/shopping_list_item_addition_view_widget.dart';
import 'package:shopping_list/home_screen/frameworks/presentation/views/shopping_list_item_view_widget.dart';

import '../../../application/interfaces/home_screen_presenter.dart';
import '../../../application/interfaces/home_screen_view.dart';
import '../../../application/interfaces/shopping_list_item_addition_view.dart';
import '../../../application/interfaces/shopping_list_item_view.dart';

class HomeScreenViewWidget extends StatelessWidget implements HomeScreenView {
  const HomeScreenViewWidget({
    required HomeScreenPresenter presenter,
    super.key,
  }) : _presenter = presenter;

  final HomeScreenPresenter _presenter;

  Widget? _buildTrailing({
    required BuildContext context,
  }) {
    if (doneButtonShown) {
      return CupertinoButton(
        padding: EdgeInsets.symmetric(
          horizontal: 16,
        ),
        onPressed: _presenter.onDoneButtonPressed,
        child: Text(
          'Готово',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).primaryColor,
            fontFamily: 'Inter',
            height: 1.0,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      );
    }

    if (clearingButtonShown) {
      return CupertinoButton(
        padding: EdgeInsets.symmetric(
          horizontal: 16,
        ),
        onPressed: _presenter.onClearingButtonPressed,
        child: Text(
          'Очистить',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).primaryColor,
            fontFamily: 'Inter',
            height: 1.0,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      );
    }

    return null;
  }

  Widget _buildPageBody({
    required BuildContext context,
  }) {
    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: Scrollbar(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context).copyWith(
                      scrollbars: false,
                    ),
                    child: CustomScrollView(
                      primary: true,
                      physics: ScrollConfiguration.of(context)
                          .getScrollPhysics(context),
                      slivers: [
                        SliverToBoxAdapter(
                          child: SizedBox(
                            height: 20,
                          ),
                        ),
                        SliverList.separated(
                          itemCount: _presenter.itemViews.length,
                          itemBuilder: (context, index) {
                            final itemPresenter = _presenter.itemViews[index];

                            return ShoppingListItemViewWidget(
                              presenter: itemPresenter,
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(height: 10);
                          },
                        ),
                        SliverSafeArea(
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
              ),
            ),
            if (_presenter.itemAdditionView != null)
              SafeArea(
                child: ShoppingListItemAdditionViewWidget(
                  presenter: _presenter.itemAdditionView!,
                  onSubmitted: _presenter.onDoneButtonPressed,
                ),
              ),
            SafeArea(
              child: Container(
                color: Colors.transparent,
                height: MediaQuery.of(context).viewInsets.bottom,
              ),
            ),
          ],
        ),
        if (additionButtonShown)
          Positioned(
            right: 40,
            bottom: 40,
            child: FloatingActionButton(
              backgroundColor: Theme.of(context).primaryColor,
              onPressed: _presenter.onAdditionButtonPressed,
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _presenter.updateStream,
      builder: (context, _) {
        return CupertinoPageScaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Color(0xfff2f2f7),
          navigationBar: CupertinoNavigationBar(
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
            trailing: _buildTrailing(
              context: context,
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

  @override
  bool get doneButtonShown => _presenter.doneButtonShown;

  @override
  bool get clearingButtonShown => _presenter.clearingButtonShown;

  @override
  bool get additionButtonShown => _presenter.additionButtonShown;

  @override
  ShoppingListItemAdditionView? get itemAdditionView =>
      _presenter.itemAdditionView;

  @override
  List<ShoppingListItemView> get itemViews => _presenter.itemViews;
}
