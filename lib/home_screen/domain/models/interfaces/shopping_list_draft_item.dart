abstract interface class ShoppingListDraftItem {
  Stream<void> get updateStream;

  String get title;

  void changeTitle(String title);
}