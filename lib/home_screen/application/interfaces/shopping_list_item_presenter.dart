import 'shopping_list_item_view.dart';

abstract interface class ShoppingListItemPresenter implements ShoppingListItemView {
  Stream<void> get updateStream;

  void onCheckboxPressed();
}
