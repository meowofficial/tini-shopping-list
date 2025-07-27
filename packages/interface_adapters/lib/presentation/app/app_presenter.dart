import 'package:application/app/use_cases/handle_app_launch/handle_app_launch.dart';
import 'package:application/app/use_cases/initialize_app_initialization_flow_store/initialize_app_initialization_flow_store.dart';
import 'package:application/app/use_cases/read_app_initialization_flow_state/read_app_initialization_flow_state.dart';
import 'package:application/app/use_cases/shared/refs/app_initialization_flow_state_ref.dart';

abstract interface class AppPresenter {
  void initialize();
}

class AppPresenterImpl implements AppPresenter {
  const AppPresenterImpl({
    required InitializeAppInitializationFlowStore initializeAppInitializationFlowStore,
    required HandleAppLaunch handleAppLaunch,
    required ReadAppInitializationFlowState readAppInitializationFlowState,
  }) : _initializeAppInitializationFlowStore = initializeAppInitializationFlowStore,
       _handleAppLaunch = handleAppLaunch,
       _readAppInitializationFlowState = readAppInitializationFlowState;

  final InitializeAppInitializationFlowStore _initializeAppInitializationFlowStore;
  final HandleAppLaunch _handleAppLaunch;
  final ReadAppInitializationFlowState _readAppInitializationFlowState;

  @override
  void initialize() {
    _initializeAppInitializationFlowStore();

    final appInitializationFlowState = _readAppInitializationFlowState();

    switch (appInitializationFlowState) {
      case InitialAppInitializationFlowStateRef():
        _handleAppLaunch();

      case LoadingAppInitializationFlowStateRef():
      case LoadedAppInitializationFlowStateRef():
        break;
    }
  }
}
