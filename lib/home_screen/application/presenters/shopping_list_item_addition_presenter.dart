import 'dart:async';

import '../../domain/models/interfaces/shopping_list_draft_item.dart';
import '../interfaces/shopping_list_item_addition_presenter.dart';

class ShoppingListItemAdditionPresenterImpl
    implements ShoppingListItemAdditionPresenter {
  ShoppingListItemAdditionPresenterImpl({
    required ShoppingListDraftItem item,
  }) : _item = item {
    _updateStreamController = StreamController.broadcast(
      onCancel: _dispose,
    );

    _itemUpdateStreamSubscription = item.updateStream.listen((_) {
      _onItemUpdated();
    });
  }

  final ShoppingListDraftItem _item;

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
  String get title => _item.title;

  @override
  Stream<void> get updateStream => _updateStreamController.stream;

  @override
  void changeTitle(String title) {
    _item.changeTitle(title);
  }

  @override
  void onSubmitted() {
    // todo
  }
}
