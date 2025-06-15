abstract interface class SnapshotReadable<S> {
  S get snapshot;
}

abstract interface class AsyncSnapshotStreamable<S> implements SnapshotReadable<S> {
  Stream<S> get snapshotStream;
}

abstract interface class SyncSnapshotStreamable<S> implements SnapshotReadable<S> {
  Stream<S> get syncSnapshotStream;
}

abstract interface class SnapshotStreamable<S>
    implements AsyncSnapshotStreamable<S>, SyncSnapshotStreamable<S> {}
