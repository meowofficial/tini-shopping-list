import 'package:equatable/equatable.dart';

import '../../core/entities/base_entity.dart';
import '../validation/shopping_list_item_title_validator/shopping_list_item_title_validation_error.dart';

class ExistingShoppingListDraftItem extends BaseEntity<ExistingShoppingListDraftItemSnapshot> {
  ExistingShoppingListDraftItem({
    required String id,
    required String title,
    required ShoppingListItemTitleValidationError? titleValidationError,
  }) : _id = id,
       _title = title,
       _titleValidationError = titleValidationError;

  final String _id;
  String _title;
  ShoppingListItemTitleValidationError? _titleValidationError;

  String get id => _id;

  String get title => _title;

  ShoppingListItemTitleValidationError? get titleValidationError => _titleValidationError;

  @override
  ExistingShoppingListDraftItemSnapshot get snapshot {
    return ExistingShoppingListDraftItemSnapshot(
      id: id,
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

class ExistingShoppingListDraftItemSnapshot extends Equatable {
  const ExistingShoppingListDraftItemSnapshot({
    required this.id,
    required this.title,
    required this.titleValidationError,
  });

  final String id;
  final String title;
  final ShoppingListItemTitleValidationError? titleValidationError;

  @override
  List<Object?> get props {
    return [
      id,
      title,
      titleValidationError,
    ];
  }
}
