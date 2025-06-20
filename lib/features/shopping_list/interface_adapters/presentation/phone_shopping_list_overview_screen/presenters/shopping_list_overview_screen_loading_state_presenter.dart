import '../../../../../../core/interface_adapters/presentation/base_view_streamable_presenter.dart';
import '../interfaces/shopping_list_overview_screen_state_presenters.dart';
import '../views/shopping_list_overview_screen_state_views.dart';

class ShoppingListOverviewScreenLoadingStatePresenterImpl
    extends BaseViewStreamablePresenter<ShoppingListOverviewScreenLoadingStateView>
    implements ShoppingListOverviewScreenLoadingStatePresenter {
  ShoppingListOverviewScreenLoadingStatePresenterImpl() {
    const view = ShoppingListOverviewScreenLoadingStateView();
    initializeView(view);
  }
}
