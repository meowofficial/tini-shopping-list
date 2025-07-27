import 'package:equatable/equatable.dart';

sealed class AppInitializationFlowStateRef {}

class InitialAppInitializationFlowStateRef extends Equatable
    implements AppInitializationFlowStateRef {
  const InitialAppInitializationFlowStateRef();

  @override
  List<Object?> get props => [];
}

class LoadingAppInitializationFlowStateRef extends Equatable
    implements AppInitializationFlowStateRef {
  const LoadingAppInitializationFlowStateRef();

  @override
  List<Object?> get props => [];
}

class LoadedAppInitializationFlowStateRef extends Equatable
    implements AppInitializationFlowStateRef {
  const LoadedAppInitializationFlowStateRef();

  @override
  List<Object?> get props => [];
}
