import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import 'shopping_list_item_ref/shopping_list_item_ref.dart';

sealed class ShoppingListOverviewFlowStateRef {}

class InitialShoppingListOverviewFlowStateRef extends Equatable
    implements ShoppingListOverviewFlowStateRef {
  const InitialShoppingListOverviewFlowStateRef();

  @override
  List<Object?> get props => [];
}

class LoadingShoppingListOverviewFlowStateRef extends Equatable
    implements ShoppingListOverviewFlowStateRef {
  const LoadingShoppingListOverviewFlowStateRef();

  @override
  List<Object?> get props => [];
}

class LoadedShoppingListOverviewFlowStateRef extends Equatable
    implements ShoppingListOverviewFlowStateRef {
  const LoadedShoppingListOverviewFlowStateRef({
    required this.shoppingListItemRefs,
  });

  final IList<ShoppingListItemRef> shoppingListItemRefs;

  @override
  List<Object?> get props {
    return [
      shoppingListItemRefs,
    ];
  }
}
