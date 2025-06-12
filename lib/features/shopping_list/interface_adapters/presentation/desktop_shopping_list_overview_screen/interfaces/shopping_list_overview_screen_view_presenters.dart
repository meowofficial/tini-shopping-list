import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import '../../../../../../core/common/stream/disposable.dart';
import '../../../../../../core/interface_adapters/presentation/view_streamable.dart';
import '../views/shopping_list_overview_screen_views.dart';
import 'shopping_list_item_view_presenter.dart';

sealed class ShoppingListOverviewScreenViewPresenter implements Disposable {}

abstract interface class ShoppingListOverviewScreenLoadingViewPresenter
    implements
        ShoppingListOverviewScreenViewPresenter,
        ViewStreamable<ShoppingListOverviewScreenLoadingView> {}

abstract interface class ShoppingListOverviewScreenLoadedViewPresenter
    implements
        ShoppingListOverviewScreenViewPresenter,
        ViewStreamable<ShoppingListOverviewScreenLoadedView> {
  IList<ShoppingListItemViewPresenter> get shoppingListItemViewPresenters;

  void onShoppingListItemAdditionButtonPressed();
}
