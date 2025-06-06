import 'package:injectable/injectable.dart';

import '../stores/user_intent_store.dart';
import '../user_intents/user_intents.dart';

abstract interface class ActivateUserIntent {
  void call(UserIntent userIntent);
}

@LazySingleton(as: ActivateUserIntent)
class ActivateUserIntentImpl implements ActivateUserIntent {
  const ActivateUserIntentImpl({
    required UserIntentStore userIntentStore,
  }) : _userIntentStore = userIntentStore;

  final UserIntentStore _userIntentStore;

  @override
  void call(UserIntent userIntent) {
    _userIntentStore.updateWith(
      activeUserIntent: () => userIntent,
    );
  }
}
