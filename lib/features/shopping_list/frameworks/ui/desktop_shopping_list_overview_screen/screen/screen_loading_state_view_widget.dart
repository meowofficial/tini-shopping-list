import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/frameworks/ui/ui_kit/navigation_bar_title_widget.dart';
import '../../../../../../core/frameworks/ui/utils/view_stream_builder.dart';
import '../../../../interface_adapters/presentation/desktop_shopping_list_overview_screen/screen/interfaces/shopping_list_overview_screen_state_presenters.dart';

class ScreenLoadingStateViewWidget extends StatelessWidget {
  const ScreenLoadingStateViewWidget({
    required this.presenter,
    super.key,
  });

  final ShoppingListOverviewScreenLoadingStatePresenter presenter;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xfff2f2f7),
      navigationBar: CupertinoNavigationBar(
        transitionBetweenRoutes: false,
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        automaticallyImplyLeading: false,
        automaticallyImplyMiddle: false,
        automaticBackgroundVisibility: false,
        padding: EdgeInsetsDirectional.zero,
        middle: _buildTitle(),
      ),
      child: const SizedBox.expand(
        child: Center(
          child: SizedBox(
            width: 50,
            height: 50,
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return ConverterViewStreamBuilder(
      viewStreamable: presenter,
      converter: (view) => view.title,
      builder: (context, title) {
        return NavigationBarTitleWidget(
          title: title,
        );
      },
    );
  }
}
