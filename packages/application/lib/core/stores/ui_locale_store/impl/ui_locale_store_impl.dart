import 'package:domain/core/value_objects/ui_locale.dart';
import 'package:injectable/injectable.dart';

import '../../base_store.dart';
import '../../ui_locale_store/ui_locale_store.dart';

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
