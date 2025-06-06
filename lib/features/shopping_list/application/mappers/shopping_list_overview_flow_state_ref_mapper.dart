import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';

import '../flow_states/shopping_list_overview_flow_state.dart';
import '../refs/entity_refs/shopping_list_item_ref.dart';
import '../refs/flow_state_refs/shopping_list_overview_flow_state_ref.dart';

abstract interface class ShoppingListOverviewFlowStateRefMapper {
  ShoppingListOverviewFlowStateRef call(ShoppingListOverviewFlowState flowState);
}

@LazySingleton(as: ShoppingListOverviewFlowStateRefMapper)
class ShoppingListOverviewFlowStateRefMapperImpl implements ShoppingListOverviewFlowStateRefMapper {
  const ShoppingListOverviewFlowStateRefMapperImpl();

  @override
  ShoppingListOverviewFlowStateRef call(ShoppingListOverviewFlowState flowState) {
    switch (flowState) {
      case InitialShoppingListOverviewFlowState():
        return const InitialShoppingListOverviewFlowStateRef();

      case LoadingShoppingListOverviewFlowState():
        return const LoadingShoppingListOverviewFlowStateRef();

      case LoadedShoppingListOverviewFlowState():
        final shoppingListItems = flowState.shoppingListItems;

        final shoppingListItemRefs = shoppingListItems.map<ShoppingListItemRef>((entity) {
          return ShoppingListItemRefImpl(
            entity: entity,
          );
        }).toIList();

        return LoadedShoppingListOverviewFlowStateRef(
          shoppingListItemRefs: shoppingListItemRefs,
        );
    }
  }
}
