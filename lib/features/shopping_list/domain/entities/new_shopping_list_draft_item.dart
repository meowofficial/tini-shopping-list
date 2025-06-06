import 'package:equatable/equatable.dart';

import '../../../../core/domain/entities/base_entity.dart';
import '../validation/shopping_list_item/errors.dart';

class NewShoppingListDraftItem extends BaseEntity<NewShoppingListDraftItemSnapshot> {
  NewShoppingListDraftItem({
    required String title,
    required ShoppingListItemTitleValidationError? titleValidationError,
  })  : _title = title,
        _titleValidationError = titleValidationError;

  String _title;
  ShoppingListItemTitleValidationError? _titleValidationError;

  String get title => _title;

  ShoppingListItemTitleValidationError? get titleValidationError => _titleValidationError;

  @override
  NewShoppingListDraftItemSnapshot get snapshot {
    return NewShoppingListDraftItemSnapshot(
      title: title,
      titleValidationError: titleValidationError,
    );
  }

  void changeTitle({
    required String title,
    required ShoppingListItemTitleValidationError? titleValidationError,
  }) {
    _title = title;
    _titleValidationError = titleValidationError;

    emitUpdate();
  }
}

class NewShoppingListDraftItemSnapshot extends Equatable {
  const NewShoppingListDraftItemSnapshot({
    required this.title,
    required this.titleValidationError,
  });

  final String title;
  final ShoppingListItemTitleValidationError? titleValidationError;

  @override
  List<Object?> get props {
    return [
      title,
      titleValidationError,
    ];
  }
}
