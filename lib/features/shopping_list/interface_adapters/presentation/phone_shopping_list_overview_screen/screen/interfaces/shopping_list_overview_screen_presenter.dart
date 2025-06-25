import '../../../../../../../core/common/disposable.dart';
import '../../../../../../../core/interface_adapters/presentation/update_streamable.dart';
import 'shopping_list_overview_screen_state_presenters.dart';

abstract interface class ShoppingListOverviewScreenPresenter
    implements AsyncUpdateStreamable, Disposable {
  ShoppingListOverviewScreenStatePresenter get currentStatePresenter;
}
