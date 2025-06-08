abstract interface class SnapshotStreamable<S> {
  S get snapshot;

  Stream<S> get snapshotStream;
}
