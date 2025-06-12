import 'dart:async';

import 'package:meta/meta.dart';

import '../../../../common/stream/state_streamable.dart';

abstract class BaseNavigator<S> implements StateStreamable<S> {
  BaseNavigator();

  var _initialized = false;
  late S _state;

  @protected
  final stateStreamController = StreamController<S>.broadcast();

  @override
  S get state => _state;

  bool get initialized => _initialized;

  @override
  Stream<S> get stateStream => stateStreamController.stream;

  @protected
  void initializeState(S state) {
    _state = state;
    _initialized = true;
  }

  @protected
  void emit(S state) {
    _state = state;
    stateStreamController.add(state);
  }

  @mustCallSuper
  void dispose() {
    stateStreamController.close();
  }
}
