import 'package:common/stream/with_previous_stream.dart';
import 'package:common/typedefs/value_with_previous.dart';
import 'package:injectable/injectable.dart';

import '../../../shared/base_navigator.dart';
import '../phone_navigator.dart';

@LazySingleton(as: PhoneNavigator)
class PhoneNavigatorImpl extends BaseNavigator<PhoneNavigatorState> implements PhoneNavigator {
  PhoneNavigatorImpl();

  @override
  late final Stream<ValueWithPrevious<PhoneNavigatorState>> stateStreamWithPrevious;

  @override
  void initialize({
    required PhoneNavigatorStackState rootStackState,
    required PhoneHomeNavigationState? homeNavigationState,
  }) {
    final updatedState = PhoneNavigatorState(
      rootStackState: rootStackState,
      homeNavigationState: homeNavigationState,
    );

    initializeState(updatedState);

    stateStreamWithPrevious = stateStream.withPreviousSeeded(updatedState);
  }

  @override
  void updateWith({
    PhoneNavigatorStackState Function()? rootStackState,
    PhoneHomeNavigationState? Function()? homeNavigationState,
  }) {
    final updatedState = state.copyWith(
      rootStackState: rootStackState,
      homeNavigationState: homeNavigationState,
    );

    emit(updatedState);
  }
}
