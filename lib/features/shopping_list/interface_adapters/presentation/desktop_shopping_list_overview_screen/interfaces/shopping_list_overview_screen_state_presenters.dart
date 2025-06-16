import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import '../../../../../../core/common/stream/disposable.dart';
import '../../../../../../core/interface_adapters/presentation/view_streamable.dart';
import '../views/shopping_list_overview_screen_views.dart';
import 'shopping_list_item_presenter.dart';

sealed class ShoppingListOverviewScreenStatePresenter implements Disposable {}

abstract interface class ShoppingListOverviewScreenLoadingStatePresenter
    implements
        ShoppingListOverviewScreenStatePresenter,
        AsyncViewStreamable<ShoppingListOverviewScreenLoadingView> {}

abstract interface class ShoppingListOverviewScreenLoadedStatePresenter
    implements
        ShoppingListOverviewScreenStatePresenter,
        AsyncViewStreamable<ShoppingListOverviewScreenLoadedView> {
  IList<ShoppingListItemPresenter> get shoppingListItemViewPresenters;

  Stream<IList<ShoppingListItemPresenter>> get shoppingListItemViewPresenterStream;

  void onShoppingListItemAdditionButtonPressed();
}
