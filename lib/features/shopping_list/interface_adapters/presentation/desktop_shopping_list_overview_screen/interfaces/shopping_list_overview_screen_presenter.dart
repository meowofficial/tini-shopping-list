import '../../../../../../core/common/stream/disposable.dart';
import 'shopping_list_overview_screen_state_presenters.dart';

abstract interface class ShoppingListOverviewScreenPresenter implements Disposable {
  Stream<void> get updateStream;

  ShoppingListOverviewScreenStatePresenter get currentStatePresenter;
}
