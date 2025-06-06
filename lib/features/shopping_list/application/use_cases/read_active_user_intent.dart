import 'package:injectable/injectable.dart';

import '../../../../core/application/stores/user_intent_store.dart';
import '../../../../core/application/user_intents/user_intents.dart';

abstract interface class ReadActiveUserIntent {
  UserIntent? call();
}

@LazySingleton(as: ReadActiveUserIntent)
class ReadActiveUserIntentImpl implements ReadActiveUserIntent {
  const ReadActiveUserIntentImpl({
    required UserIntentStore userIntentStore,
  }) : _userIntentStore = userIntentStore;

  final UserIntentStore _userIntentStore;

  @override
  UserIntent? call() {
    return _userIntentStore.state.activeUserIntent;
  }
}
