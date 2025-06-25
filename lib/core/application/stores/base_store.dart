import 'dart:async';

import 'package:meta/meta.dart';

import '../../common/disposable.dart';
import '../../common/stream/state_streamable.dart';

abstract class BaseStore<S> implements StateStreamable<S>, Disposable {
  BaseStore();

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
