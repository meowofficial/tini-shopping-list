import 'package:equatable/equatable.dart';

import '../../../../core/domain/entities/base_entity.dart';
import 'existing_shopping_list_draft_item.dart';

class ShoppingListItem extends BaseEntity<ShoppingListItemSnapshot> {
  ShoppingListItem({
    required String id,
    required String title,
    required bool checked,
  }) : _id = id,
       _title = title,
       _checked = checked;

  final String _id;
  String _title;
  bool _checked;

  String get id => _id;

  String get title => _title;

  bool get checked => _checked;

  @override
  ShoppingListItemSnapshot get snapshot {
    return ShoppingListItemSnapshot(
      id: id,
      title: title,
      checked: checked,
    );
  }

  void toggleCheck() {
    _checked = !_checked;
    emitUpdate();
  }

  void updateFromDraft({
    required ExistingShoppingListDraftItem existingShoppingListDraftItem,
  }) {
    _title = existingShoppingListDraftItem.title;
    emitUpdate();
  }
}

class ShoppingListItemSnapshot extends Equatable {
  const ShoppingListItemSnapshot({
    required this.id,
    required this.title,
    required this.checked,
  });

  final String id;
  final String title;
  final bool checked;

  @override
  List<Object?> get props {
    return [
      id,
      title,
      checked,
    ];
  }
}
