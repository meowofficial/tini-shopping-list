import 'package:injectable/injectable.dart';

import '../../../../../../../injection_container.dart';
import '../../../../../application/refs/entity_refs/shopping_list_item_ref.dart';
import '../interfaces/shopping_list_item_presenter.dart';
import '../interfaces/shopping_list_item_presenter_factory.dart';
import 'shopping_list_item_presenter.dart';

@LazySingleton(as: ShoppingListItemPresenterFactory)
class ShoppingListItemPresenterFactoryImpl implements ShoppingListItemPresenterFactory {
  const ShoppingListItemPresenterFactoryImpl();

  @override
  ShoppingListItemPresenter create({
    required ShoppingListItemRef shoppingListItemRef,
  }) {
    return ShoppingListItemPresenterImpl(
      shoppingListItemRef: shoppingListItemRef,
      toggleShoppingListItemCheck: di(),
    );
  }
}
