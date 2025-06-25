import 'dart:async';

import 'package:meta/meta.dart';

import '../../common/disposable.dart';
import '../../common/stream/snapshot_streamable.dart';

abstract class BaseEntity<S> implements SnapshotStreamable<S>, Disposable {
  BaseEntity();

  @protected
  final snapshotStreamController = StreamController<S>.broadcast(sync: false);

  @protected
  final syncSnapshotStreamController = StreamController<S>.broadcast(sync: true);

  @override
  Stream<S> get snapshotStream => snapshotStreamController.stream;

  @override
  Stream<S> get syncSnapshotStream => syncSnapshotStreamController.stream;

  @protected
  void emitUpdate() {
    syncSnapshotStreamController.add(snapshot);
    snapshotStreamController.add(snapshot);
  }

  @mustCallSuper
  @override
  void dispose() {
    snapshotStreamController.close();
    syncSnapshotStreamController.close();
  }
}
