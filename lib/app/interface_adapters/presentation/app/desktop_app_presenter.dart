import '../../../application/refs/flow_state_refs/app_initialization_flow_state_ref.dart';
import '../../../application/use_cases/handle_app_launch.dart';
import '../../../application/use_cases/initialize_stores.dart';
import '../../../application/use_cases/read_app_initialization_flow_state.dart';

abstract interface class AppPresenter {}

class AppPresenterImpl implements AppPresenter {
  AppPresenterImpl({
    required InitializeStores initializeStores,
    required HandleAppLaunch handleAppLaunch,
    required ReadAppInitializationFlowState readAppInitializationFlowState,
  }) : _initializeStores = initializeStores,
       _handleAppLaunch = handleAppLaunch,
       _readAppInitializationFlowState = readAppInitializationFlowState {
    final appInitializationFlowState = _readAppInitializationFlowState();

    switch (appInitializationFlowState) {
      case InitialAppInitializationFlowStateRef():
        _initializeStores();
        _handleAppLaunch();

      case LoadingAppInitializationFlowStateRef():
      case LoadedAppInitializationFlowStateRef():
        break;
    }
  }

  final InitializeStores _initializeStores;
  final HandleAppLaunch _handleAppLaunch;
  final ReadAppInitializationFlowState _readAppInitializationFlowState;
}
