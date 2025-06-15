import '../../../../../../core/common/stream/disposable.dart';
import '../../../../../../core/interface_adapters/presentation/view_streamable.dart';
import '../views/shopping_list_item_addition_screen_view.dart';

abstract interface class ShoppingListItemAdditionScreenPresenter
    implements Disposable, AsyncViewStreamable<ShoppingListItemAdditionScreenView> {
  void onShoppingListItemTitleInputTextChanged(String value);

  void onShoppingListItemSubmissionButtonPressed();

  void onBackButtonPressed();
}
