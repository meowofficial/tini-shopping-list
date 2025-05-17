abstract interface class ShoppingListItem {
  Stream<void> get updateStream;

  bool get checked;

  String get title;

  void changeTitle(String title);

  void toggleCheck();
}