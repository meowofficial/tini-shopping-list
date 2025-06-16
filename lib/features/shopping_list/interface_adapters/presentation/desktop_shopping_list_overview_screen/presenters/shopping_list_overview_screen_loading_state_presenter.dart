import '../../../../../../core/interface_adapters/presentation/base_view_presenter.dart';
import '../interfaces/shopping_list_overview_screen_state_presenters.dart';
import '../views/shopping_list_overview_screen_views.dart';

class ShoppingListOverviewScreenLoadingStatePresenterImpl
    extends BaseViewPresenter<ShoppingListOverviewScreenLoadingView>
    implements ShoppingListOverviewScreenLoadingStatePresenter {
  ShoppingListOverviewScreenLoadingStatePresenterImpl() {
    const view = ShoppingListOverviewScreenLoadingView();
    initializeView(view);
  }
}
