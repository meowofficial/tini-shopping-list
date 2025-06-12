abstract interface class ViewStreamable<V> {
  V get view;

  Stream<V> get viewStream;
}