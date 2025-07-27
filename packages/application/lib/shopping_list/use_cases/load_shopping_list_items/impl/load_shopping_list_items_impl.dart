import 'package:common/errors/unexpected_state_error.dart';
import 'package:domain/shopping_list/entities/shopping_list_item.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';

import '../../../flow_states/shopping_list_overview_flow_state.dart';
import '../../../repositories/local/shopping_list_local_repository/factories/shopping_list_item_local_dto_factory/shopping_list_item_local_dto_factory.dart';
import '../../../repositories/local/shopping_list_local_repository/shopping_list_local_repository.dart';
import '../../../stores/shopping_list_flow_store/shopping_list_flow_store.dart';
import '../load_shopping_list_items.dart';

@LazySingleton(as: LoadShoppingListItems)
class LoadShoppingListItemsImpl implements LoadShoppingListItems {
  const LoadShoppingListItemsImpl({
    required ShoppingListFlowStore shoppingListFlowStore,
    required ShoppingListItemLocalDtoFactory shoppingListItemLocalDtoFactory,
    required ShoppingListLocalRepository shoppingListRepository,
  }) : _shoppingListFlowStore = shoppingListFlowStore,
       _shoppingListItemLocalDtoFactory = shoppingListItemLocalDtoFactory,
       _shoppingListRepository = shoppingListRepository;

  final ShoppingListFlowStore _shoppingListFlowStore;
  final ShoppingListItemLocalDtoFactory _shoppingListItemLocalDtoFactory;
  final ShoppingListLocalRepository _shoppingListRepository;

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

    final shoppingListItemLocalDtos = await _shoppingListRepository.getShoppingListItemDtos();

    final shoppingListItems = shoppingListItemLocalDtos.map<ShoppingListItem>((
      shoppingListItemDto,
    ) {
      return _shoppingListItemLocalDtoFactory.createEntity(
        shoppingListItemDto: shoppingListItemDto,
      );
    }).toIList();

    updatedShoppingListOverviewFlowState = LoadedShoppingListOverviewFlowState(
      shoppingListItems: shoppingListItems,
    );

    _shoppingListFlowStore.updateWith(
      shoppingListOverviewFlowState: () => updatedShoppingListOverviewFlowState,
    );
  }
}
