import 'package:equatable/equatable.dart';

abstract interface class AppRoute {
  String get id;

  AppRoute copyWith({
    String Function()? id,
  });
}

class SplashRoute extends Equatable implements AppRoute {
  const SplashRoute({
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
  SplashRoute copyWith({
    String Function()? id,
  }) {
    return SplashRoute(
      id: id == null ? this.id : id(),
    );
  }
}
