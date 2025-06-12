import '../../../../../../core/interface_adapters/presentation/base_view_presenter.dart';
import '../interfaces/shopping_list_overview_screen_view_presenters.dart';
import '../views/shopping_list_overview_screen_views.dart';

class ShoppingListOverviewScreenLoadingViewPresenterImpl
    extends BaseViewPresenter<ShoppingListOverviewScreenLoadingView>
    implements ShoppingListOverviewScreenLoadingViewPresenter {
  ShoppingListOverviewScreenLoadingViewPresenterImpl() {
    const view = ShoppingListOverviewScreenLoadingView();
    initializeView(view);
  }
}
