import 'package:equatable/equatable.dart';

sealed class ShoppingListOverviewScreenView {}

class ShoppingListOverviewScreenLoadingView extends Equatable
    implements ShoppingListOverviewScreenView {
  const ShoppingListOverviewScreenLoadingView();

  @override
  List<Object?> get props => [];
}

class ShoppingListOverviewScreenLoadedView extends Equatable
    implements ShoppingListOverviewScreenView {
  const ShoppingListOverviewScreenLoadedView();

  @override
  List<Object?> get props => [];
}
