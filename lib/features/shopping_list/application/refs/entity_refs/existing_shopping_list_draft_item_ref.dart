import '../../../../../core/application/refs/base_ref.dart';
import '../../../../../core/common/stream/snapshot_streamable.dart';
import '../../../domain/entities/existing_shopping_list_draft_item.dart';

abstract interface class ExistingShoppingListDraftItemRef
    implements SnapshotStreamable<ExistingShoppingListDraftItemSnapshot> {}

class ExistingShoppingListDraftItemRefImpl
    extends BaseRef<ExistingShoppingListDraftItem, ExistingShoppingListDraftItemSnapshot>
    implements ExistingShoppingListDraftItemRef {
  ExistingShoppingListDraftItemRefImpl({
    required super.entity,
  });
}
