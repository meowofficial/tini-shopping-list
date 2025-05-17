import 'dart:async';

import 'package:shopping_list/home_screen/application/presenters/shopping_list_item_addition_presenter.dart';
import 'package:shopping_list/home_screen/application/presenters/shopping_list_item_presenter.dart';
import 'package:shopping_list/home_screen/domain/models/shopping_list_draft_item.dart';

import '../../domain/models/interfaces/shopping_list_draft_item.dart';
import '../../domain/models/interfaces/shopping_list_item.dart';
import '../../domain/models/shopping_list_item.dart';
import '../interfaces/home_screen_presenter.dart';
import '../interfaces/shopping_list_item_addition_presenter.dart';
import '../interfaces/shopping_list_item_presenter.dart';

class HomeScreenPresenterImpl implements HomeScreenPresenter {
  HomeScreenPresenterImpl() {
    _updateStreamController = StreamController.broadcast(
      onCancel: _dispose,
    );

    _items = [];

    _itemViews = _items.map((item) {
      return _createShoppingListItemPresenter(
        item: item,
      );
    }).toList();
  }

  late final StreamController<void> _updateStreamController;
  late final List<ShoppingListItem> _items;
  late final List<ShoppingListItemPresenter> _itemViews;

  ShoppingListItemAdditionPresenter? _itemAdditionView;
  ShoppingListDraftItem? _draftItem;

  void _emitUpdate() {
    _updateStreamController.add(null);
  }

  void _dispose() {
    _updateStreamController.close();
  }

  ShoppingListItemPresenter _createShoppingListItemPresenter({
    required ShoppingListItem item,
  }) {
    return ShoppingListItemPresenterImpl(
      item: item,
    );
  }

  @override
  Stream<void> get updateStream => _updateStreamController.stream;

  @override
  bool get doneButtonShown => _itemAdditionView != null;

  @override
  bool get additionButtonShown => _itemAdditionView == null;

  @override
  List<ShoppingListItemPresenter> get itemViews => _itemViews;

  @override
  ShoppingListItemAdditionPresenter? get itemAdditionView => _itemAdditionView;

  @override
  void onDoneButtonPressed() {
    if (_draftItem!.title.trim().isNotEmpty) {
      final item = ShoppingListItemImpl(
        checked: false,
        title: _draftItem!.title.trim(),
      );

      _items.add(item);

      _itemViews.add(_createShoppingListItemPresenter(
        item: item,
      ));
    }

    _draftItem = null;
    _itemAdditionView = null;

    _emitUpdate();
  }

  @override
  void onAdditionButtonPressed() {
    _draftItem = ShoppingListDraftItemImpl(
      title: '',
    );

    _itemAdditionView = ShoppingListItemAdditionPresenterImpl(
      item: _draftItem!,
    );

    _emitUpdate();
  }

  @override
  bool get clearingButtonShown {
    return itemAdditionView == null && _items.isNotEmpty;
  }

  @override
  void onClearingButtonPressed() {
    _items.clear();
    _itemViews.clear();
    _emitUpdate();
  }
}
