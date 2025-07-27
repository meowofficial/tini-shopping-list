import 'package:common/disposable.dart';

import '../../../../core/update_streamable.dart';
import '../shopping_list_overview_screen_state_presenter/shopping_list_overview_screen_state_presenter.dart';

abstract interface class ShoppingListOverviewScreenPresenter
    implements AsyncUpdateStreamable, Disposable {
  ShoppingListOverviewScreenStatePresenter get currentStatePresenter;
}
