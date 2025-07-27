import 'package:injectable/injectable.dart';

import '../../../../core/stores/base_store.dart';
import '../../../flow_states/app_initialization_flow_state.dart';
import '../../app_initialization_flow_store/app_initialization_flow_store.dart';

@LazySingleton(as: AppInitializationFlowStore)
class AppInitializationFlowStoreImpl extends BaseStore<AppInitializationFlowStoreState>
    implements AppInitializationFlowStore {
  AppInitializationFlowStoreImpl();

  @override
  void initialize({
    required AppInitializationFlowState appInitializationFlowState,
  }) {
    final initialState = AppInitializationFlowStoreState(
      appInitializationFlowState: appInitializationFlowState,
    );

    initializeState(initialState);
  }

  @override
  void updateWith({
    AppInitializationFlowState Function()? appInitializationFlowState,
  }) {
    final updatedState = state.copyWith(
      appInitializationFlowState: appInitializationFlowState,
    );

    emit(updatedState);
  }
}
