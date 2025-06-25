import 'package:injectable/injectable.dart';

import '../../../../../../../injection_container.dart';
import '../../../../../application/refs/flow_state_refs/shopping_list_overview_flow_state_ref.dart';
import '../interfaces/shopping_list_overview_screen_state_presenter_factory.dart';
import '../interfaces/shopping_list_overview_screen_state_presenters.dart';
import 'shopping_list_overview_screen_loaded_state_presenter.dart';
import 'shopping_list_overview_screen_loading_state_presenter.dart';

@LazySingleton(as: ShoppingListOverviewScreenStatePresenterFactory)
class ShoppingListOverviewScreenStatePresenterFactoryImpl
    implements ShoppingListOverviewScreenStatePresenterFactory {
  const ShoppingListOverviewScreenStatePresenterFactoryImpl();

  @override
  ShoppingListOverviewScreenStatePresenter create({
    required ShoppingListOverviewFlowStateRef shoppingListOverviewFlowStateRef,
  }) {
    switch (shoppingListOverviewFlowStateRef) {
      case InitialShoppingListOverviewFlowStateRef():
      case LoadingShoppingListOverviewFlowStateRef():
        return ShoppingListOverviewScreenLoadingStatePresenterImpl(
          translation: di(),
          readUiLocale: di(),
          watchUiLocale: di(),
        );

      case LoadedShoppingListOverviewFlowStateRef():
        return ShoppingListOverviewScreenLoadedStatePresenterImpl(
          translation: di(),
          shoppingListItemPresenterFactory: di(),
          readShoppingListOverviewFlowState: di(),
          readUiLocale: di(),
          watchShoppingListOverviewFlowState: di(),
          watchUiLocale: di(),
        );
    }
  }
}
