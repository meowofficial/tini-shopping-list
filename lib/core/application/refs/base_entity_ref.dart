import 'package:meta/meta.dart';

import '../../common/stream/snapshot_streamable.dart';
import '../../domain/entities/base_entity.dart';

abstract class BaseEntityRef<T extends BaseEntity<S>, S> implements SnapshotStreamable<S> {
  BaseEntityRef({
    required this.entity,
  });

  @protected
  final T entity;

  @override
  S get snapshot => entity.snapshot;

  @override
  Stream<S> get snapshotStream => entity.snapshotStream;

  @override
  Stream<S> get syncSnapshotStream => entity.syncSnapshotStream;
}
