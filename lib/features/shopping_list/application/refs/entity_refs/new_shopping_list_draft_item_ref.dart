import '../../../../../core/application/refs/base_ref.dart';
import '../../../../../core/common/stream/snapshot_streamable.dart';
import '../../../domain/entities/new_shopping_list_draft_item.dart';

abstract interface class NewShoppingListDraftItemRef
    implements SnapshotStreamable<NewShoppingListDraftItemSnapshot> {}

class NewShoppingListDraftItemRefImpl
    extends BaseRef<NewShoppingListDraftItem, NewShoppingListDraftItemSnapshot>
    implements NewShoppingListDraftItemRef {
  NewShoppingListDraftItemRefImpl({
    required super.entity,
  });
}
