import 'package:equatable/equatable.dart';

sealed class UriConfig {}

class ShoppingListOverviewUriConfig extends Equatable implements UriConfig {
  const ShoppingListOverviewUriConfig();

  @override
  List<Object?> get props => [];
}

class ShoppingListItemAdditionUriConfig extends Equatable implements UriConfig {
  const ShoppingListItemAdditionUriConfig();

  @override
  List<Object?> get props => [];
}

