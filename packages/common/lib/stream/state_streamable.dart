abstract interface class StateReadable<S> {
  S get state;
}

abstract interface class AsyncStateStreamable<S> implements StateReadable<S> {
  Stream<S> get stateStream;
}

abstract interface class SyncStateStreamable<S> implements StateReadable<S> {
  Stream<S> get syncStateStream;
}

abstract interface class StateStreamable<S>
    implements AsyncStateStreamable<S>, SyncStateStreamable<S> {}
