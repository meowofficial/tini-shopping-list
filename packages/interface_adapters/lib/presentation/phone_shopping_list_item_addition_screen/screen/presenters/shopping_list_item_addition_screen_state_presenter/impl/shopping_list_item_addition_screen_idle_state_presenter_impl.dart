import '../../../../../core/base_view_streamable_presenter.dart';
import '../../../views/shopping_list_item_addition_screen_state_views.dart';
import '../../shopping_list_item_addition_screen_state_presenter/shopping_list_item_addition_screen_state_presenter.dart';

class ShoppingListItemAdditionScreenIdleStatePresenterImpl
    extends BaseViewStreamablePresenter<ShoppingListItemAdditionScreenIdleStateView>
    implements ShoppingListItemAdditionScreenIdleStatePresenter {
  ShoppingListItemAdditionScreenIdleStatePresenterImpl() {
    const view = ShoppingListItemAdditionScreenIdleStateView();

    initializeView(view);
  }
}
