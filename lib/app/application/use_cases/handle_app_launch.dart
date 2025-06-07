import 'package:injectable/injectable.dart';

import '../flow_states/app_initialization_flow_state.dart';
import '../stores/app_initialization_flow_store.dart';

abstract interface class HandleAppLaunch {
  void call();
}

@LazySingleton(as: HandleAppLaunch)
class HandleAppLaunchImpl implements HandleAppLaunch {
  const HandleAppLaunchImpl({
    required AppInitializationFlowStore appInitializationFlowStore,
  }) : _appInitializationFlowStore = appInitializationFlowStore;

  final AppInitializationFlowStore _appInitializationFlowStore;

  @override
  void call() {
    const updatedAppInitializationFlowState = LoadedAppInitializationFlowState();

    _appInitializationFlowStore.updateWith(
      appInitializationFlowState: () => updatedAppInitializationFlowState,
    );
  }
}
