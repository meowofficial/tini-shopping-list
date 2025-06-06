import 'package:injectable/injectable.dart';

import '../../../../core/application/stores/user_intent_store.dart';
import '../../../../core/application/user_intents/user_intents.dart';

abstract interface class WatchActiveUserIntent {
  Stream<UserIntent> call();
}

@LazySingleton(as: WatchActiveUserIntent)
class WatchActiveUserIntentImpl implements WatchActiveUserIntent {
  const WatchActiveUserIntentImpl({
    required UserIntentStore userIntentStore,
  }) : _userIntentStore = userIntentStore;

  final UserIntentStore _userIntentStore;

  @override
  Stream<UserIntent> call() {
    return _userIntentStore.stateStream.map((state) {
      return state.activeUserIntent;
    }).distinct();
  }
}
