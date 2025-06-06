import 'package:injectable/injectable.dart';

import '../../../../core/common/errors/unexpected_state_error.dart';
import '../flow_states/shopping_list_overview_flow_state.dart';
import '../repositories/shopping_list_repository.dart';
import '../stores/shopping_list_flow_store.dart';

abstract interface class LoadShoppingListItems {
  void call();
}

@LazySingleton(as: LoadShoppingListItems)
class LoadShoppingListItemsImpl implements LoadShoppingListItems {
  const LoadShoppingListItemsImpl({
    required ShoppingListFlowStore shoppingListFlowStore,
    required ShoppingListRepository shoppingListRepository,
  }) : _shoppingListFlowStore = shoppingListFlowStore,
       _shoppingListRepository = shoppingListRepository;

  final ShoppingListFlowStore _shoppingListFlowStore;
  final ShoppingListRepository _shoppingListRepository;

  @override
  void call() async {
    if (_shoppingListFlowStore.state.shoppingListOverviewFlowState
        is! InitialShoppingListOverviewFlowState) {
      throwStateError();
    }

    ShoppingListOverviewFlowState updatedShoppingListOverviewFlowState;

    updatedShoppingListOverviewFlowState = const LoadingShoppingListOverviewFlowState();

    _shoppingListFlowStore.updateWith(
      shoppingListOverviewFlowState: () => updatedShoppingListOverviewFlowState,
    );

    final shoppingListItems = await _shoppingListRepository.getShoppingListItems();

    updatedShoppingListOverviewFlowState = LoadedShoppingListOverviewFlowState(
      shoppingListItems: shoppingListItems,
    );

    _shoppingListFlowStore.updateWith(
      shoppingListOverviewFlowState: () => updatedShoppingListOverviewFlowState,
    );
  }
}
