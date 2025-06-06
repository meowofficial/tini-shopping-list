import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../common/stream/state_streamable.dart';
import '../user_intents/user_intents.dart';
import 'base_store.dart';

abstract interface class UserIntentStore implements StateStreamable<UserIntentStoreState> {
  void initialize({
    required UserIntent activeUserIntent,
  });

  void updateWith({
    UserIntent Function()? activeUserIntent,
  });

  void dispose();
}

@LazySingleton(as: UserIntentStore)
class UserIntentStoreImpl extends BaseStore<UserIntentStoreState> implements UserIntentStore {
  UserIntentStoreImpl();

  @override
  void initialize({
    required UserIntent activeUserIntent,
  }) {
    final initialState = UserIntentStoreState(
      activeUserIntent: activeUserIntent,
    );

    initializeState(initialState);
  }

  @override
  void updateWith({
    UserIntent Function()? activeUserIntent,
  }) {
    final updatedState = state.copyWith(
      activeUserIntent: activeUserIntent,
    );

    emit(updatedState);
  }
}

class UserIntentStoreState extends Equatable {
  const UserIntentStoreState({
    required this.activeUserIntent,
  });

  final UserIntent activeUserIntent;

  @override
  List<Object?> get props {
    return [
      activeUserIntent,
    ];
  }

  UserIntentStoreState copyWith({
    UserIntent Function()? activeUserIntent,
  }) {
    return UserIntentStoreState(
      activeUserIntent: activeUserIntent == null ? this.activeUserIntent : activeUserIntent(),
    );
  }
}
