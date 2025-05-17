import 'dart:async';

import '../../domain/models/interfaces/shopping_list_item.dart';
import '../interfaces/shopping_list_item_presenter.dart';

class ShoppingListItemPresenterImpl implements ShoppingListItemPresenter {
  ShoppingListItemPresenterImpl({
    required ShoppingListItem item,
  }) : _item = item {
    _updateStreamController = StreamController.broadcast(
      onCancel: _dispose,
    );

    _itemUpdateStreamSubscription = item.updateStream.listen((_) {
      _onItemUpdated();
    });
  }

  final ShoppingListItem _item;

  late final StreamController<void> _updateStreamController;
  late final StreamSubscription<void> _itemUpdateStreamSubscription;

  void _emitUpdate() {
    _updateStreamController.add(null);
  }

  void _dispose() {
    _itemUpdateStreamSubscription.cancel();
    _updateStreamController.close();
  }

  void _onItemUpdated() {
    _emitUpdate();
  }

  @override
  bool get checked => _item.checked;

  @override
  String get title => _item.title;

  @override
  Stream<void> get updateStream => _updateStreamController.stream;

  @override
  void onCheckboxPressed() {
    _item.toggleCheck();
  }
}
