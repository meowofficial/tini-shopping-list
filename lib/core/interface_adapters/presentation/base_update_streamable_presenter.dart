import 'dart:async';

import 'package:meta/meta.dart';

import 'update_streamable.dart';

abstract class BaseUpdateStreamablePresenter implements AsyncUpdateStreamable {
  BaseUpdateStreamablePresenter();

  @protected
  final updateStreamController = StreamController<void>.broadcast(sync: false);

  @override
  Stream<void> get updateStream => updateStreamController.stream;

  @protected
  void emitUpdate() {
    updateStreamController.add(null);
  }

  @mustCallSuper
  void dispose() {
    updateStreamController.close();
  }
}
