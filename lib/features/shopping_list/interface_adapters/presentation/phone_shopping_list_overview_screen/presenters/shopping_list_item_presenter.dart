import 'dart:async';

import '../../../../../../core/interface_adapters/presentation/base_view_streamable_presenter.dart';
import '../../../../application/refs/entity_refs/shopping_list_item_ref.dart';
import '../../../../application/use_cases/toggle_shopping_list_item_check.dart';
import '../../../../domain/entities/shopping_list_item.dart';
import '../interfaces/shopping_list_item_presenter.dart';
import '../views/shopping_list_item_view.dart';

class ShoppingListItemPresenterImpl extends BaseViewStreamablePresenter<ShoppingListItemView>
    implements ShoppingListItemPresenter {
  ShoppingListItemPresenterImpl({
    required ShoppingListItemRef shoppingListItemRef,
    required ToggleShoppingListItemCheck toggleShoppingListItemCheck,
  }) : _toggleShoppingListItemCheck = toggleShoppingListItemCheck {
    _shoppingListItemId = shoppingListItemRef.snapshot.id;

    final view = _createShoppingListItemView(shoppingListItemRef.snapshot);

    initializeView(view);

    _snapshotStreamSubscription = shoppingListItemRef.snapshotStream.listen(
      _onShoppingListItemSnapshotChanged,
    );
  }

  final ToggleShoppingListItemCheck _toggleShoppingListItemCheck;

  late final String _shoppingListItemId;
  late final StreamSubscription<ShoppingListItemSnapshot> _snapshotStreamSubscription;

  @override
  String get shoppingListItemId => _shoppingListItemId;

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
  void onCheckboxPressed() {
    _toggleShoppingListItemCheck(
      shoppingListItemId: _shoppingListItemId,
    );
  }

  @override
  void dispose() {
    _snapshotStreamSubscription.cancel();
    super.dispose();
  }
}
