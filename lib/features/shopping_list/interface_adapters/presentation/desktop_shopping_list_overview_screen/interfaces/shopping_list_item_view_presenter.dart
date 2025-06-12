import '../../../../../../core/common/stream/disposable.dart';
import '../../../../../../core/interface_adapters/presentation/view_streamable.dart';
import '../views/shopping_list_item_view.dart';

abstract interface class ShoppingListItemViewPresenter
    implements ViewStreamable<ShoppingListItemView>, Disposable {
  String get id;
}
