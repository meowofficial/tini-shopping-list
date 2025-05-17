import 'shopping_list_item_addition_view.dart';

abstract interface class ShoppingListItemAdditionPresenter
    implements ShoppingListItemAdditionView {
  Stream<void> get updateStream;

  void changeTitle(String title);

  void onSubmitted();
}
