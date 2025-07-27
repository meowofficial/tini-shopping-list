import 'dart:async';

import 'package:common/disposable.dart';
import 'package:common/stream/state_streamable.dart';
import 'package:meta/meta.dart';

abstract class BaseNavigator<S> implements StateStreamable<S>, Disposable {
  BaseNavigator();

  var _initialized = false;
  late S _state;

  @protected
  final stateStreamController = StreamController<S>.broadcast(sync: false);

  @protected
  final syncStateStreamController = StreamController<S>.broadcast(sync: true);

  @override
  S get state => _state;

  bool get initialized => _initialized;

  @override
  Stream<S> get stateStream => stateStreamController.stream;

  @override
  Stream<S> get syncStateStream => syncStateStreamController.stream;

  @protected
  void initializeState(S state) {
    _state = state;
    _initialized = true;
  }

  @protected
  void emit(S state) {
    _state = state;
    syncStateStreamController.add(state);
    stateStreamController.add(state);
  }

  @mustCallSuper
  @override
  void dispose() {
    stateStreamController.close();
    syncStateStreamController.close();
  }
}
