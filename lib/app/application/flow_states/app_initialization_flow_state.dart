import 'package:equatable/equatable.dart';

sealed class AppInitializationFlowState {}

class InitialAppInitializationFlowState extends Equatable implements AppInitializationFlowState {
  const InitialAppInitializationFlowState();

  @override
  List<Object?> get props => [];
}

class LoadingAppInitializationFlowState extends Equatable implements AppInitializationFlowState {
  const LoadingAppInitializationFlowState();

  @override
  List<Object?> get props => [];
}

class LoadedAppInitializationFlowState extends Equatable implements AppInitializationFlowState {
  const LoadedAppInitializationFlowState();

  @override
  List<Object?> get props => [];
}
