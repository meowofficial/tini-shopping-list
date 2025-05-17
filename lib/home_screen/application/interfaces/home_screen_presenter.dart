import 'home_screen_view.dart';
import 'shopping_list_item_addition_presenter.dart';
import 'shopping_list_item_presenter.dart';

abstract interface class HomeScreenPresenter implements HomeScreenView {
  @override
  List<ShoppingListItemPresenter> get itemViews;

  @override
  ShoppingListItemAdditionPresenter? get itemAdditionView;

  Stream<void> get updateStream;

  void onDoneButtonPressed();

  void onClearingButtonPressed();

  void onAdditionButtonPressed();
}
