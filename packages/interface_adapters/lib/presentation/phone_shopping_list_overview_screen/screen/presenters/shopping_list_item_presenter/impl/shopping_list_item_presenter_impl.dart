import 'dart:async';

import 'package:application/shopping_list/use_cases/shared/refs/shopping_list_item_ref/shopping_list_item_ref.dart';
import 'package:application/shopping_list/use_cases/toggle_shopping_list_item_check/toggle_shopping_list_item_check.dart';

import '../../../../../core/base_view_streamable_presenter.dart';
import '../../../views/shopping_list_item_view.dart';
import '../shopping_list_item_presenter.dart';

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
  late final StreamSubscription<ShoppingListItemRefSnapshot> _snapshotStreamSubscription;

  @override
  String get shoppingListItemId => _shoppingListItemId;

  ShoppingListItemView _createShoppingListItemView(ShoppingListItemRefSnapshot snapshot) {
    return ShoppingListItemView(
      id: snapshot.id,
      title: snapshot.title,
      checked: snapshot.checked,
    );
  }

  void _onShoppingListItemSnapshotChanged(ShoppingListItemRefSnapshot snapshot) {
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
