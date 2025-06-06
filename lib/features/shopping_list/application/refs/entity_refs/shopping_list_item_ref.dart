import '../../../../../core/application/refs/base_ref.dart';
import '../../../../../core/common/stream/snapshot_streamable.dart';
import '../../../domain/entities/shopping_list_item.dart';

abstract interface class ShoppingListItemRef
    implements SnapshotStreamable<ShoppingListItemSnapshot> {}

class ShoppingListItemRefImpl extends BaseRef<ShoppingListItem, ShoppingListItemSnapshot>
    implements ShoppingListItemRef {
  ShoppingListItemRefImpl({
    required super.entity,
  });
}
