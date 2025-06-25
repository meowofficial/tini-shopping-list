import '../../../../../application/refs/flow_state_refs/shopping_list_overview_flow_state_ref.dart';
import '../interfaces/shopping_list_overview_screen_state_presenters.dart';

abstract interface class ShoppingListOverviewScreenStatePresenterFactory {
  ShoppingListOverviewScreenStatePresenter create({
    required ShoppingListOverviewFlowStateRef shoppingListOverviewFlowStateRef,
  });
}
