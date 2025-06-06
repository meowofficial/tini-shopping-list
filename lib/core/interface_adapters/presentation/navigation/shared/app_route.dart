abstract interface class AppRoute {
  String get id;

  AppRoute copyWith({
    String Function()? id,
  });
}
