import 'package:equatable/equatable.dart';

import '../shared/app_routes.dart';

class PhoneHomeRoute extends Equatable implements AppRoute {
  const PhoneHomeRoute({
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
  PhoneHomeRoute copyWith({
    String Function()? id,
  }) {
    return PhoneHomeRoute(
      id: id == null ? this.id : id(),
    );
  }
}

class PhoneShoppingListOverviewRoute extends Equatable implements AppRoute {
  const PhoneShoppingListOverviewRoute({
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
  PhoneShoppingListOverviewRoute copyWith({
    String Function()? id,
  }) {
    return PhoneShoppingListOverviewRoute(
      id: id == null ? this.id : id(),
    );
  }
}

class PhoneShoppingListItemAdditionRoute extends Equatable implements AppRoute {
  const PhoneShoppingListItemAdditionRoute({
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
  PhoneShoppingListItemAdditionRoute copyWith({
    String Function()? id,
  }) {
    return PhoneShoppingListItemAdditionRoute(
      id: id == null ? this.id : id(),
    );
  }
}
