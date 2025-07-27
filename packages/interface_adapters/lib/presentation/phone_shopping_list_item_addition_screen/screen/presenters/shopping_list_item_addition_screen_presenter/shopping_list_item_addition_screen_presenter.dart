import 'package:common/disposable.dart';

import '../../../../core/update_streamable.dart';
import '../shopping_list_item_addition_screen_state_presenter/shopping_list_item_addition_screen_state_presenter.dart';

abstract interface class ShoppingListItemAdditionScreenPresenter
    implements AsyncUpdateStreamable, Disposable {
  ShoppingListItemAdditionScreenStatePresenter get currentStatePresenter;
}
