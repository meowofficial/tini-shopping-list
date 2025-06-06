abstract interface class StateStreamable<S> {
  S get state;

  Stream<S> get stateStream;
}
