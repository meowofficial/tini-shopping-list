import 'dart:async';

import 'package:meta/meta.dart';

import 'interfaces/shopping_list_draft_item.dart';

class ShoppingListDraftItemImpl implements ShoppingListDraftItem {
  ShoppingListDraftItemImpl({
    required this.title,
  }) {
    _updateStreamController = StreamController.broadcast(
      onCancel: dispose,
    );
  }

  late final StreamController<void> _updateStreamController;

  @override
  @protected
  String title;

  @protected
  void emitUpdate() {
    _updateStreamController.add(null);
  }

  @protected
  void dispose() {
    _updateStreamController.close();
  }

  @override
  Stream<void> get updateStream => _updateStreamController.stream;

  @override
  void changeTitle(String title) {
    this.title = title;
    emitUpdate();
  }
}
