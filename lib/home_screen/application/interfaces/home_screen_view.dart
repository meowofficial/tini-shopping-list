import 'shopping_list_item_addition_view.dart';
import 'shopping_list_item_view.dart';

abstract interface class HomeScreenView {
  List<ShoppingListItemView> get itemViews;

  ShoppingListItemAdditionView? get itemAdditionView;

  bool get doneButtonShown;

  bool get clearingButtonShown;

  bool get additionButtonShown;
}
