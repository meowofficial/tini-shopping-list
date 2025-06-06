import 'dart:async';

import 'package:meta/meta.dart';

import '../../common/stream/snapshot_streamable.dart';

abstract class BaseEntity<S> implements SnapshotStreamable<S> {
  BaseEntity();

  @protected
  final snapshotStreamController = StreamController<S>.broadcast();

  @override
  Stream<S> get snapshotStream => snapshotStreamController.stream;

  @protected
  void emitUpdate() {
    snapshotStreamController.add(snapshot);
  }

  @mustCallSuper
  void dispose() {
    snapshotStreamController.close();
  }
}
