import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';

import '../../../../../flow_states/shopping_list_overview_flow_state.dart';
import '../../../refs/shopping_list_item_ref/impl/shopping_list_item_ref_impl.dart';
import '../../../refs/shopping_list_item_ref/shopping_list_item_ref.dart';
import '../../../refs/shopping_list_overview_flow_state_ref.dart';
import '../shopping_list_overview_flow_state_ref_factory.dart';

@LazySingleton(as: ShoppingListOverviewFlowStateRefFactory)
class ShoppingListOverviewFlowStateRefFactoryImpl
    implements ShoppingListOverviewFlowStateRefFactory {
  const ShoppingListOverviewFlowStateRefFactoryImpl();

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
