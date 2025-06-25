import 'dart:async';

import 'package:meta/meta.dart';

import '../../common/disposable.dart';
import 'view_streamable.dart';

abstract class BaseViewStreamablePresenter<V> implements AsyncViewStreamable<V>, Disposable {
  BaseViewStreamablePresenter();

  var _initialized = false;
  late V _view;

  @protected
  final viewStreamController = StreamController<V>.broadcast(sync: false);

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
  @override
  void dispose() {
    viewStreamController.close();
  }
}
