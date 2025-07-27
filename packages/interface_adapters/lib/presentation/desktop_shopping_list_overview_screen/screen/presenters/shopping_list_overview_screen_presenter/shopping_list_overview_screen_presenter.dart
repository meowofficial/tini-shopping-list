import 'package:common/disposable.dart';

import '../shopping_list_overview_screen_state_presenter/shopping_list_overview_screen_state_presenter.dart';

abstract interface class ShoppingListOverviewScreenPresenter implements Disposable {
  Stream<void> get updateStream;

  ShoppingListOverviewScreenStatePresenter get currentStatePresenter;
}
