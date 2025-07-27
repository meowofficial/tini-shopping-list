import 'package:common/disposable.dart';

import '../../../../core/view_streamable.dart';
import '../../views/shopping_list_item_view.dart';

abstract interface class ShoppingListItemPresenter
    implements AsyncViewStreamable<ShoppingListItemView>, Disposable {
  String get shoppingListItemId;

  void onCheckboxPressed();
}
