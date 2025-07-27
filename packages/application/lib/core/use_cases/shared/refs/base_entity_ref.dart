import 'package:common/stream/snapshot_streamable.dart';
import 'package:domain/core/entities/entity.dart';
import 'package:meta/meta.dart';

abstract class BaseEntityRef<ES, S> implements SnapshotStreamable<S> {
  BaseEntityRef({
    required this.entity,
  });

  @protected
  final Entity<ES> entity;

  @override
  S get snapshot {
    return createSnapshot(entity.snapshot);
  }

  @override
  Stream<S> get snapshotStream {
    return entity.snapshotStream.map(createSnapshot);
  }

  @override
  Stream<S> get syncSnapshotStream {
    return entity.syncSnapshotStream.map(createSnapshot);
  }

  @protected
  S createSnapshot(ES entitySnapshot);
}
