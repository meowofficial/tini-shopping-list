import 'package:flutter/widgets.dart';

import '../../../interface_adapters/presentation/view_streamable.dart';

class ViewStreamBuilder<V> extends ConverterViewStreamBuilder<V, V> {
  const ViewStreamBuilder({
    required super.viewStreamable,
    required super.builder,
    super.buildWhen,
    super.key,
  }) : super(converter: _identity);

  static V _identity<V>(V view) => view;
}

class ConverterViewStreamBuilder<V, S> extends StatefulWidget {
  const ConverterViewStreamBuilder({
    required this.viewStreamable,
    required this.converter,
    required this.builder,
    this.buildWhen,
    super.key,
  });

  final AsyncViewStreamable<V> viewStreamable;
  final S Function(V view) converter;
  final Widget Function(BuildContext context, S state) builder;
  final bool Function({required S previous, required S next})? buildWhen;

  @override
  State<ConverterViewStreamBuilder<V, S>> createState() => _ConverterViewStreamBuilderState<V, S>();
}

class _ConverterViewStreamBuilderState<V, S> extends State<ConverterViewStreamBuilder<V, S>> {
  late Stream<S> _stream;

  Stream<S> _createStream() {
    return widget.viewStreamable.viewStream.map(widget.converter).distinct((previous, next) {
      if (widget.buildWhen != null) {
        return !widget.buildWhen!(
          previous: previous,
          next: next,
        );
      }

      return previous == next;
    });
  }

  @override
  void initState() {
    super.initState();
    _stream = _createStream();
  }

  @override
  void didUpdateWidget(ConverterViewStreamBuilder<V, S> oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.viewStreamable.viewStream != widget.viewStreamable.viewStream) {
      _stream = _createStream();
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<S>(
      initialData: widget.converter(widget.viewStreamable.view),
      stream: _stream,
      builder: (context, snapshot) {
        return widget.builder(context, snapshot.requireData);
      },
    );
  }
}
