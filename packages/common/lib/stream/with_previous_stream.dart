import 'dart:async';

class WithPreviousStreamTransformer<T> extends StreamTransformerBase<T, (T, T?)> {
  WithPreviousStreamTransformer({
    this.seed,
  });

  final T? seed;

  @override
  Stream<(T, T?)> bind(Stream<T> stream) async* {
    var last = seed;

    await for (final current in stream) {
      yield (current, last);
      last = current;
    }
  }
}

extension WithPreviousStreamExtension<T> on Stream<T> {
  Stream<(T, T?)> get withPrevious {
    return transform(WithPreviousStreamTransformer());
  }

  Stream<(T, T)> withPreviousSeeded(T seed) {
    return transform(WithPreviousStreamTransformer(seed: seed)).cast();
  }
}
