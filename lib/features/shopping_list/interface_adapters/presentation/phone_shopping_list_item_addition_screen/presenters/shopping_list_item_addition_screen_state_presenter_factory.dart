import 'package:injectable/injectable.dart';

import '../../../../../../injection_container.dart';
import '../../../../application/refs/flow_state_refs/shopping_list_item_addition_flow_state_ref.dart';
import '../interfaces/shopping_list_item_addition_screen_state_presenter_factory.dart';
import '../interfaces/shopping_list_item_addition_screen_state_presenters.dart';
import 'shopping_list_item_addition_screen_idle_state_presenter.dart';
import 'shopping_list_item_addition_screen_ready_state_presenter.dart';

@LazySingleton(as: ShoppingListItemAdditionScreenStatePresenterFactory)
class ShoppingListItemAdditionScreenStatePresenterFactoryImpl
    implements ShoppingListItemAdditionScreenStatePresenterFactory {
  const ShoppingListItemAdditionScreenStatePresenterFactoryImpl();

  @override
  ShoppingListItemAdditionScreenStatePresenter create({
    required ShoppingListItemAdditionFlowStateRef shoppingListItemAdditionFlowStateRef,
  }) {
    switch (shoppingListItemAdditionFlowStateRef) {
      case IdleShoppingListItemAdditionFlowStateRef():
        return ShoppingListItemAdditionScreenIdleStatePresenterImpl();

      case OngoingShoppingListItemAdditionFlowStateRef():
        return ShoppingListItemAdditionScreenReadyStatePresenterImpl(
          submitNewShoppingListItemDraft: di(),
          updateNewShoppingListDraftItemTitle: di(),
          readShoppingListItemAdditionFlowState: di(),
          watchShoppingListItemAdditionFlowState: di(),
        );
    }
  }
}
