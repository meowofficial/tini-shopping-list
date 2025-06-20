import '../../../../../../core/common/stream/disposable.dart';
import '../../../../../../core/interface_adapters/presentation/update_streamable.dart';
import 'shopping_list_item_addition_screen_state_presenters.dart';

abstract interface class ShoppingListItemAdditionScreenPresenter
    implements AsyncUpdateStreamable, Disposable {
  ShoppingListItemAdditionScreenStatePresenter get currentStatePresenter;
}
