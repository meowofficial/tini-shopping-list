import 'dart:async';

import 'package:meta/meta.dart';

import '../../../../common/stream/state_streamable.dart';

abstract class BaseNavigator<S> implements StateStreamable<S> {
  BaseNavigator();

  late S _state;

  @protected
  StreamController<S>? stateStreamController;

  @override
  S get state => _state;

  @override
  Stream<S> get stateStream => stateStreamController!.stream;

  @protected
  void initializeState(S state) {
    _state = state;
    stateStreamController?.close();
    stateStreamController = StreamController<S>.broadcast();
  }

  @protected
  void emit(S state) {
    _state = state;
    stateStreamController!.add(state);
  }

  @mustCallSuper
  void dispose() {
    stateStreamController?.close();
  }
}
