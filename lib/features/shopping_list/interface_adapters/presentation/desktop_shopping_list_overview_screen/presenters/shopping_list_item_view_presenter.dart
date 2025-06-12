import 'dart:async';

import '../../../../../../core/interface_adapters/presentation/base_view_presenter.dart';
import '../../../../application/refs/entity_refs/shopping_list_item_ref.dart';
import '../../../../domain/entities/shopping_list_item.dart';
import '../interfaces/shopping_list_item_view_presenter.dart';
import '../views/shopping_list_item_view.dart';

class ShoppingListItemViewPresenterImpl extends BaseViewPresenter<ShoppingListItemView>
    implements ShoppingListItemViewPresenter {
  ShoppingListItemViewPresenterImpl({
    required ShoppingListItemRef shoppingListItemRef,
  }) {
    _id = shoppingListItemRef.snapshot.id;

    final view = _createShoppingListItemView(shoppingListItemRef.snapshot);

    initializeView(view);

    _snapshotStreamSubscription = shoppingListItemRef.snapshotStream.listen(
      _onShoppingListItemSnapshotChanged,
    );
  }

  late final String _id;
  late final StreamSubscription<ShoppingListItemSnapshot> _snapshotStreamSubscription;

  @override
  String get id => _id;

  ShoppingListItemView _createShoppingListItemView(ShoppingListItemSnapshot snapshot) {
    return ShoppingListItemView(
      id: snapshot.id,
      title: snapshot.title,
      checked: snapshot.checked,
    );
  }

  void _onShoppingListItemSnapshotChanged(ShoppingListItemSnapshot snapshot) {
    final updatedView = _createShoppingListItemView(snapshot);
    emit(updatedView);
  }

  @override
  void dispose() {
    _snapshotStreamSubscription.cancel();
    super.dispose();
  }
}
