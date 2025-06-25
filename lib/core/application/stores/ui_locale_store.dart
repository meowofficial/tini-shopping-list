import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/application/stores/base_store.dart';
import '../../../../core/common/stream/state_streamable.dart';
import '../../common/disposable.dart';
import '../../domain/common/ui_locale.dart';

abstract interface class UiLocaleStore implements StateStreamable<UiLocaleStoreState>, Disposable {
  void initialize({
    required UiLocale uiLocale,
  });

  void updateWith({
    UiLocale Function()? uiLocale,
  });
}

@LazySingleton(as: UiLocaleStore)
class UiLocaleStoreImpl extends BaseStore<UiLocaleStoreState> implements UiLocaleStore {
  UiLocaleStoreImpl();

  @override
  void initialize({
    required UiLocale uiLocale,
  }) {
    final initialState = UiLocaleStoreState(
      uiLocale: uiLocale,
    );

    initializeState(initialState);
  }

  @override
  void updateWith({
    UiLocale Function()? uiLocale,
  }) {
    final updatedState = state.copyWith(
      uiLocale: uiLocale,
    );

    emit(updatedState);
  }
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
