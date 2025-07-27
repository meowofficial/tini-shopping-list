import 'package:domain/shopping_list/entities/shopping_list_item.dart';

import '../../../../../../core/use_cases/shared/refs/base_entity_ref.dart';
import '../shopping_list_item_ref.dart';

class ShoppingListItemRefImpl
    extends BaseEntityRef<ShoppingListItemSnapshot, ShoppingListItemRefSnapshot>
    implements ShoppingListItemRef {
  ShoppingListItemRefImpl({
    required super.entity,
  });

  @override
  ShoppingListItemRefSnapshot createSnapshot(
    ShoppingListItemSnapshot entitySnapshot,
  ) {
    return ShoppingListItemRefSnapshot(
      id: entitySnapshot.id,
      title: entitySnapshot.title,
      checked: entitySnapshot.checked,
    );
  }
}
