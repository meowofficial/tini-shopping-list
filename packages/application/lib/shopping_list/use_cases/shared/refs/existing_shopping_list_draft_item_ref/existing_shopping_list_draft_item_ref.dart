import 'package:common/stream/snapshot_streamable.dart';
import 'package:equatable/equatable.dart';

import '../../output_dtos/shopping_list_item_title_validation_error_output_dto.dart';

abstract interface class ExistingShoppingListDraftItemRef
    implements SnapshotStreamable<ExistingShoppingListDraftItemRefSnapshot> {}

class ExistingShoppingListDraftItemRefSnapshot extends Equatable {
  const ExistingShoppingListDraftItemRefSnapshot({
    required this.id,
    required this.title,
    required this.titleValidationError,
  });

  final String id;
  final String title;
  final ShoppingListItemTitleValidationErrorOutputDto? titleValidationError;

  @override
  List<Object?> get props {
    return [
      id,
      title,
      titleValidationError,
    ];
  }
}
