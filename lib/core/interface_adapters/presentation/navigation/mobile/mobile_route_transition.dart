import 'package:equatable/equatable.dart';

sealed class MobileRouteTransition {}

class MobileAdditionRouteTransition extends Equatable implements MobileRouteTransition {
  const MobileAdditionRouteTransition({
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

class MobileRemovalRouteTransition extends Equatable implements MobileRouteTransition {
  const MobileRemovalRouteTransition({
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
