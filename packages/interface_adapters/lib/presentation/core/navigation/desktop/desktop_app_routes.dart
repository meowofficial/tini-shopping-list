import 'package:equatable/equatable.dart';

import '../shared/app_routes.dart';

class DesktopShoppingListOverviewRoute extends Equatable implements AppRoute {
  const DesktopShoppingListOverviewRoute({
    required this.id,
  });

  @override
  final String id;

  @override
  List<Object?> get props {
    return [
      id,
    ];
  }

  @override
  DesktopShoppingListOverviewRoute copyWith({
    String Function()? id,
  }) {
    return DesktopShoppingListOverviewRoute(
      id: id == null ? this.id : id(),
    );
  }
}

class DesktopShoppingListItemAdditionRoute extends Equatable implements AppRoute {
  const DesktopShoppingListItemAdditionRoute({
    required this.id,
  });

  @override
  final String id;

  @override
  List<Object?> get props {
    return [
      id,
    ];
  }

  @override
  DesktopShoppingListItemAdditionRoute copyWith({
    String Function()? id,
  }) {
    return DesktopShoppingListItemAdditionRoute(
      id: id == null ? this.id : id(),
    );
  }
}
