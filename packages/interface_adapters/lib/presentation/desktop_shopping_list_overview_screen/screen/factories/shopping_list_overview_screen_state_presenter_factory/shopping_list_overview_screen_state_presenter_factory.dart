import 'package:application/shopping_list/use_cases/shared/refs/shopping_list_overview_flow_state_ref.dart';

import '../../presenters/shopping_list_overview_screen_state_presenter/shopping_list_overview_screen_state_presenter.dart';

abstract interface class ShoppingListOverviewScreenStatePresenterFactory {
  ShoppingListOverviewScreenStatePresenter create({
    required ShoppingListOverviewFlowStateRef shoppingListOverviewFlowStateRef,
  });
}
