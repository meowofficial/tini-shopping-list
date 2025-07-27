import 'package:application/shopping_list/use_cases/shared/refs/shopping_list_item_ref/shopping_list_item_ref.dart';
import 'package:application/shopping_list/use_cases/toggle_shopping_list_item_check/toggle_shopping_list_item_check.dart';
import 'package:injectable/injectable.dart';

import '../../../presenters/shopping_list_item_presenter/impl/shopping_list_item_presenter_impl.dart';
import '../../../presenters/shopping_list_item_presenter/shopping_list_item_presenter.dart';
import '../shopping_list_item_presenter_factory.dart';

@LazySingleton(as: ShoppingListItemPresenterFactory)
class ShoppingListItemPresenterFactoryImpl implements ShoppingListItemPresenterFactory {
  const ShoppingListItemPresenterFactoryImpl({
    required ToggleShoppingListItemCheck toggleShoppingListItemCheck,
  }) : _toggleShoppingListItemCheck = toggleShoppingListItemCheck;

  final ToggleShoppingListItemCheck _toggleShoppingListItemCheck;

  @override
  ShoppingListItemPresenter create({
    required ShoppingListItemRef shoppingListItemRef,
  }) {
    return ShoppingListItemPresenterImpl(
      shoppingListItemRef: shoppingListItemRef,
      toggleShoppingListItemCheck: _toggleShoppingListItemCheck,
    );
  }
}
