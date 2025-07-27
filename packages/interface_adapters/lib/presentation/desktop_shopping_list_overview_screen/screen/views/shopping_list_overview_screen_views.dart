import 'package:equatable/equatable.dart';

sealed class ShoppingListOverviewScreenView {}

class ShoppingListOverviewScreenLoadingStateView extends Equatable
    implements ShoppingListOverviewScreenView {
  const ShoppingListOverviewScreenLoadingStateView({
    required this.title,
  });

  final String title;

  @override
  List<Object?> get props {
    return [
      title,
    ];
  }

  ShoppingListOverviewScreenLoadingStateView copyWith({
    String Function()? title,
  }) {
    return ShoppingListOverviewScreenLoadingStateView(
      title: title == null ? this.title : title(),
    );
  }
}

class ShoppingListOverviewScreenLoadedStateView extends Equatable
    implements ShoppingListOverviewScreenView {
  const ShoppingListOverviewScreenLoadedStateView({
    required this.title,
  });

  final String title;

  @override
  List<Object?> get props {
    return [
      title,
    ];
  }

  ShoppingListOverviewScreenLoadedStateView copyWith({
    String Function()? title,
  }) {
    return ShoppingListOverviewScreenLoadedStateView(
      title: title == null ? this.title : title(),
    );
  }
}
