import 'package:equatable/equatable.dart';

sealed class PhoneRouteTransition {}

class PhoneAdditionRouteTransition extends Equatable implements PhoneRouteTransition {
  const PhoneAdditionRouteTransition({
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

class PhoneRemovalRouteTransition extends Equatable implements PhoneRouteTransition {
  const PhoneRemovalRouteTransition({
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
