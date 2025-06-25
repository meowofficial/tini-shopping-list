import '../../../../../../../core/common/disposable.dart';
import '../../../../../../../core/interface_adapters/presentation/view_streamable.dart';
import '../views/shopping_list_item_addition_screen_state_views.dart';

sealed class ShoppingListItemAdditionScreenStatePresenter implements Disposable {}

abstract interface class ShoppingListItemAdditionScreenIdleStatePresenter
    implements
        AsyncViewStreamable<ShoppingListItemAdditionScreenIdleStateView>,
        ShoppingListItemAdditionScreenStatePresenter {}

abstract interface class ShoppingListItemAdditionScreenReadyStatePresenter
    implements
        AsyncViewStreamable<ShoppingListItemAdditionScreenReadyStateView>,
        ShoppingListItemAdditionScreenStatePresenter {
  void onShoppingListItemTitleInputTextChanged(String value);

  void onShoppingListItemSubmissionButtonPressed();
}
