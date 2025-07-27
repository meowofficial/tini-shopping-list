import 'package:common/stream/snapshot_streamable.dart';
import 'package:equatable/equatable.dart';

import '../../output_dtos/shopping_list_item_title_validation_error_output_dto.dart';

abstract interface class NewShoppingListDraftItemRef
    implements SnapshotStreamable<NewShoppingListDraftItemRefSnapshot> {}

class NewShoppingListDraftItemRefSnapshot extends Equatable {
  const NewShoppingListDraftItemRefSnapshot({
    required this.title,
    required this.titleValidationError,
  });

  final String title;
  final ShoppingListItemTitleValidationErrorOutputDto? titleValidationError;

  @override
  List<Object?> get props {
    return [
      title,
      titleValidationError,
    ];
  }
}
