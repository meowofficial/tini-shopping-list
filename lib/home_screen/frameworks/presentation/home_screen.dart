import 'package:flutter/widgets.dart';
import 'package:shopping_list/home_screen/application/interfaces/home_screen_presenter.dart';
import 'package:shopping_list/home_screen/application/presenters/home_screen_presenter.dart';

import 'views/home_screen_view_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeScreenPresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = HomeScreenPresenterImpl();
  }

  @override
  Widget build(BuildContext context) {
    return HomeScreenViewWidget(
      presenter: _presenter,
    );
  }
}
