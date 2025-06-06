import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import '../../domain/entities/shopping_list_item.dart';

sealed class ShoppingListOverviewFlowState {}

class InitialShoppingListOverviewFlowState extends Equatable
    implements ShoppingListOverviewFlowState {
  const InitialShoppingListOverviewFlowState();

  @override
  List<Object?> get props => [];
}

class LoadingShoppingListOverviewFlowState extends Equatable
    implements ShoppingListOverviewFlowState {
  const LoadingShoppingListOverviewFlowState();

  @override
  List<Object?> get props => [];
}

class LoadedShoppingListOverviewFlowState extends Equatable
    implements ShoppingListOverviewFlowState {
  const LoadedShoppingListOverviewFlowState({
    required this.shoppingListItems,
  });

  final IList<ShoppingListItem> shoppingListItems;

  @override
  List<Object?> get props {
    return [
      shoppingListItems,
    ];
  }
}
