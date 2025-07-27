import 'package:common/disposable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import '../../../../core/view_streamable.dart';
import '../../../shopping_list_item/presenters/shopping_list_item_presenter/shopping_list_item_presenter.dart';
import '../../views/shopping_list_overview_screen_views.dart';

sealed class ShoppingListOverviewScreenStatePresenter implements Disposable {}

abstract interface class ShoppingListOverviewScreenLoadingStatePresenter
    implements
        ShoppingListOverviewScreenStatePresenter,
        AsyncViewStreamable<ShoppingListOverviewScreenLoadingStateView> {}

abstract interface class ShoppingListOverviewScreenLoadedStatePresenter
    implements
        ShoppingListOverviewScreenStatePresenter,
        AsyncViewStreamable<ShoppingListOverviewScreenLoadedStateView> {
  IList<ShoppingListItemPresenter> get shoppingListItemPresenters;

  Stream<IList<ShoppingListItemPresenter>> get shoppingListItemPresenterStream;

  void onShoppingListItemAdditionButtonPressed();
}
