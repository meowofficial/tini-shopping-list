import 'package:common/disposable.dart';
import 'package:common/stream/state_streamable.dart';
import 'package:domain/core/value_objects/ui_locale.dart';
import 'package:equatable/equatable.dart';

abstract interface class UiLocaleStore implements StateStreamable<UiLocaleStoreState>, Disposable {
  void initialize({
    required UiLocale uiLocale,
  });

  void updateWith({
    UiLocale Function()? uiLocale,
  });
}

class UiLocaleStoreState extends Equatable {
  const UiLocaleStoreState({
    required this.uiLocale,
  });

  final UiLocale uiLocale;

  @override
  List<Object?> get props {
    return [
      uiLocale,
    ];
  }

  UiLocaleStoreState copyWith({
    UiLocale Function()? uiLocale,
  }) {
    return UiLocaleStoreState(
      uiLocale: uiLocale == null ? this.uiLocale : uiLocale(),
    );
  }
}
