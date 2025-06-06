import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/application/stores/base_store.dart';
import '../../../../core/common/stream/state_streamable.dart';
import '../flow_states/shopping_list_item_addition_flow_state.dart';
import '../flow_states/shopping_list_item_editing_flow_state.dart';
import '../flow_states/shopping_list_overview_flow_state.dart';

abstract interface class ShoppingListFlowStore
    implements StateStreamable<ShoppingListFlowStoreState> {
  void initialize({
    required ShoppingListOverviewFlowState shoppingListOverviewFlowState,
    required ShoppingListItemAdditionFlowState shoppingListItemAdditionFlowState,
    required ShoppingListItemEditingFlowState shoppingListItemEditingFlowState,
  });

  void updateWith({
    ShoppingListOverviewFlowState Function()? shoppingListOverviewFlowState,
    ShoppingListItemAdditionFlowState Function()? shoppingListItemAdditionFlowState,
    ShoppingListItemEditingFlowState Function()? shoppingListItemEditingFlowState,
  });

  void dispose();
}

@LazySingleton(as: ShoppingListFlowStore)
class ShoppingListFlowStoreImpl extends BaseStore<ShoppingListFlowStoreState>
    implements ShoppingListFlowStore {
  ShoppingListFlowStoreImpl();

  @override
  void initialize({
    required ShoppingListOverviewFlowState shoppingListOverviewFlowState,
    required ShoppingListItemAdditionFlowState shoppingListItemAdditionFlowState,
    required ShoppingListItemEditingFlowState shoppingListItemEditingFlowState,
  }) {
    final initialState = ShoppingListFlowStoreState(
      shoppingListOverviewFlowState: shoppingListOverviewFlowState,
      shoppingListItemAdditionFlowState: shoppingListItemAdditionFlowState,
      shoppingListItemEditingFlowState: shoppingListItemEditingFlowState,
    );

    initializeState(initialState);
  }

  @override
  void updateWith({
    ShoppingListOverviewFlowState Function()? shoppingListOverviewFlowState,
    ShoppingListItemAdditionFlowState Function()? shoppingListItemAdditionFlowState,
    ShoppingListItemEditingFlowState Function()? shoppingListItemEditingFlowState,
  }) {
    final updatedState = state.copyWith(
      shoppingListOverviewFlowState: shoppingListOverviewFlowState,
      shoppingListItemAdditionFlowState: shoppingListItemAdditionFlowState,
      shoppingListItemEditingFlowState: shoppingListItemEditingFlowState,
    );

    emit(updatedState);
  }
}

class ShoppingListFlowStoreState extends Equatable {
  const ShoppingListFlowStoreState({
    required this.shoppingListOverviewFlowState,
    required this.shoppingListItemAdditionFlowState,
    required this.shoppingListItemEditingFlowState,
  });

  final ShoppingListOverviewFlowState shoppingListOverviewFlowState;
  final ShoppingListItemAdditionFlowState shoppingListItemAdditionFlowState;
  final ShoppingListItemEditingFlowState shoppingListItemEditingFlowState;

  @override
  List<Object?> get props {
    return [
      shoppingListOverviewFlowState,
      shoppingListItemAdditionFlowState,
      shoppingListItemEditingFlowState,
    ];
  }

  ShoppingListFlowStoreState copyWith({
    ShoppingListOverviewFlowState Function()? shoppingListOverviewFlowState,
    ShoppingListItemAdditionFlowState Function()? shoppingListItemAdditionFlowState,
    ShoppingListItemEditingFlowState Function()? shoppingListItemEditingFlowState,
  }) {
    return ShoppingListFlowStoreState(
      shoppingListOverviewFlowState: shoppingListOverviewFlowState == null
          ? this.shoppingListOverviewFlowState
          : shoppingListOverviewFlowState(),
      shoppingListItemAdditionFlowState: shoppingListItemAdditionFlowState == null
          ? this.shoppingListItemAdditionFlowState
          : shoppingListItemAdditionFlowState(),
      shoppingListItemEditingFlowState: shoppingListItemEditingFlowState == null
          ? this.shoppingListItemEditingFlowState
          : shoppingListItemEditingFlowState(),
    );
  }
}
