import 'dart:async';
import 'package:meta/meta.dart';

import 'interfaces/shopping_list_item.dart';

class ShoppingListItemImpl implements ShoppingListItem {
  ShoppingListItemImpl({
    required this.checked,
    required this.title,
  }) {
    _updateStreamController = StreamController.broadcast(
      onCancel: dispose,
    );
  }

  late final StreamController<void> _updateStreamController;

  @override
  @protected
  bool checked;

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

  @override
  void toggleCheck() {
    checked = !checked;
    emitUpdate();
  }
}
