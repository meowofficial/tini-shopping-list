import 'dart:async';

import 'package:meta/meta.dart';

import 'view_streamable.dart';

abstract class BaseViewPresenter<V> implements ViewStreamable<V> {
  BaseViewPresenter();

  var _initialized = false;
  late V _view;

  @protected
  final viewStreamController = StreamController<V>.broadcast();

  @override
  V get view {
    if (!_initialized) {
      throw StateError('Not initialized');
    }

    return _view;
  }

  @override
  Stream<V> get viewStream => viewStreamController.stream;

  @protected
  void initializeView(V view) {
    _view = view;
    _initialized = true;
  }

  @protected
  void emit(V view) {
    _view = view;
    viewStreamController.add(view);
  }

  @mustCallSuper
  void dispose() {
    viewStreamController.close();
  }
}