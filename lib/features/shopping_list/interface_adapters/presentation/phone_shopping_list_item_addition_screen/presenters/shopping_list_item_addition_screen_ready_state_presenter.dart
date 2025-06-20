import '../../../../../../core/interface_adapters/presentation/base_view_streamable_presenter.dart';
import '../interfaces/shopping_list_item_addition_screen_state_presenters.dart';
import '../views/shopping_list_item_addition_screen_state_views.dart';

class ShoppingListItemAdditionScreenIdleStatePresenterImpl
    extends BaseViewStreamablePresenter<ShoppingListItemAdditionScreenIdleStateView>
    implements ShoppingListItemAdditionScreenIdleStatePresenter {
  ShoppingListItemAdditionScreenIdleStatePresenterImpl() {
    const view = ShoppingListItemAdditionScreenIdleStateView();

    initializeView(view);
  }
}
