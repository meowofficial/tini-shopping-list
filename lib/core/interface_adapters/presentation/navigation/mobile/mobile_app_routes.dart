import 'package:equatable/equatable.dart';

import '../shared/app_routes.dart';

class MobileHomeRoute extends Equatable implements AppRoute {
  const MobileHomeRoute({
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
  MobileHomeRoute copyWith({
    String Function()? id,
  }) {
    return MobileHomeRoute(
      id: id == null ? this.id : id(),
    );
  }
}

class MobileShoppingListOverviewRoute extends Equatable implements AppRoute {
  const MobileShoppingListOverviewRoute({
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
  MobileShoppingListOverviewRoute copyWith({
    String Function()? id,
  }) {
    return MobileShoppingListOverviewRoute(
      id: id == null ? this.id : id(),
    );
  }
}

class MobileShoppingListItemAdditionRoute extends Equatable implements AppRoute {
  const MobileShoppingListItemAdditionRoute({
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
  MobileShoppingListItemAdditionRoute copyWith({
    String Function()? id,
  }) {
    return MobileShoppingListItemAdditionRoute(
      id: id == null ? this.id : id(),
    );
  }
}
