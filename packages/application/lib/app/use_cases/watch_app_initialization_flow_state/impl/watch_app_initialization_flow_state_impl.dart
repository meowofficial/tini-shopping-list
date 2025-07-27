import 'package:injectable/injectable.dart';

import '../../../stores/app_initialization_flow_store/app_initialization_flow_store.dart';
import '../../shared/factories/app_initialization_flow_state_ref_factory/app_initialization_flow_state_ref_factory.dart';
import '../../shared/refs/app_initialization_flow_state_ref.dart';
import '../watch_app_initialization_flow_state.dart';

@LazySingleton(as: WatchAppInitializationFlowState)
class WatchAppInitializationFlowStateImpl implements WatchAppInitializationFlowState {
  const WatchAppInitializationFlowStateImpl({
    required AppInitializationFlowStore appInitializationFlowStore,
    required AppInitializationFlowStateRefFactory appInitializationFlowStateRefFactory,
  }) : _appInitializationFlowStore = appInitializationFlowStore,
       _appInitializationFlowStateRefFactory = appInitializationFlowStateRefFactory;

  final AppInitializationFlowStore _appInitializationFlowStore;
  final AppInitializationFlowStateRefFactory _appInitializationFlowStateRefFactory;

  @override
  Stream<AppInitializationFlowStateRef> call({
    bool sync = false,
  }) {
    final appInitializationFlowStoreStateStream = sync
        ? _appInitializationFlowStore.syncStateStream
        : _appInitializationFlowStore.stateStream;

    return appInitializationFlowStoreStateStream.map((state) {
      return _appInitializationFlowStateRefFactory.createRef(
        flowState: state.appInitializationFlowState,
      );
    }).distinct();
  }
}
