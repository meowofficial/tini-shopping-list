import 'package:equatable/equatable.dart';

sealed class ShoppingListOverviewScreenView {}

class ShoppingListOverviewScreenLoadingStateView extends Equatable
    implements ShoppingListOverviewScreenView {
  const ShoppingListOverviewScreenLoadingStateView();

  @override
  List<Object?> get props => [];
}

class ShoppingListOverviewScreenLoadedStateView extends Equatable
    implements ShoppingListOverviewScreenView {
  const ShoppingListOverviewScreenLoadedStateView();

  @override
  List<Object?> get props => [];
}
