import 'dart:async';

import 'package:common/disposable.dart';
import 'package:meta/meta.dart';

import 'entity.dart';

abstract class BaseEntity<S> implements Entity<S>, Disposable {
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
