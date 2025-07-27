abstract interface class AsyncViewStreamable<V> {
  V get view;

  Stream<V> get viewStream;
}
