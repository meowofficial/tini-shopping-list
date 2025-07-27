class Observable<T> {
  final _observers = <T>{};

  Iterable<T> get observers => _observers;

  void addObserver(T observer) => _observers.add(observer);

  void removeObserver(T observer) => _observers.remove(observer);

  void notify(void Function(T observer) action) {
    for (final observer in _observers) {
      action(observer);
    }
  }
}
