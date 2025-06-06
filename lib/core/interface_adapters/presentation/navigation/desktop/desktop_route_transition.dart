import 'package:equatable/equatable.dart';

sealed class DesktopRouteTransition {}

class DesktopAdditionRouteTransition extends Equatable implements DesktopRouteTransition {
  const DesktopAdditionRouteTransition({
    required this.displayTransition,
  });

  final bool displayTransition;

  @override
  List<Object?> get props {
    return [
      displayTransition,
    ];
  }
}

class DesktopRemovalRouteTransition extends Equatable implements DesktopRouteTransition {
  const DesktopRemovalRouteTransition({
    required this.displayTransition,
  });

  final bool displayTransition;

  @override
  List<Object?> get props {
    return [
      displayTransition,
    ];
  }
}
