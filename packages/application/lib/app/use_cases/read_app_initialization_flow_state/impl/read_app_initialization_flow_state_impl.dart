import 'package:injectable/injectable.dart';

import '../../../stores/app_initialization_flow_store/app_initialization_flow_store.dart';
import '../../shared/factories/app_initialization_flow_state_ref_factory/app_initialization_flow_state_ref_factory.dart';
import '../../shared/refs/app_initialization_flow_state_ref.dart';
import '../read_app_initialization_flow_state.dart';

@LazySingleton(as: ReadAppInitializationFlowState)
class ReadAppInitializationFlowStateImpl implements ReadAppInitializationFlowState {
  const ReadAppInitializationFlowStateImpl({
    required AppInitializationFlowStore appInitializationFlowStore,
    required AppInitializationFlowStateRefFactory appInitializationFlowStateRefFactory,
  }) : _appInitializationFlowStore = appInitializationFlowStore,
       _appInitializationFlowStateRefFactory = appInitializationFlowStateRefFactory;

  final AppInitializationFlowStore _appInitializationFlowStore;
  final AppInitializationFlowStateRefFactory _appInitializationFlowStateRefFactory;

  @override
  AppInitializationFlowStateRef call() {
    return _appInitializationFlowStateRefFactory.createRef(
      flowState: _appInitializationFlowStore.state.appInitializationFlowState,
    );
  }
}
