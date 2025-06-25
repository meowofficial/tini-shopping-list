import 'package:injectable/injectable.dart';

import '../../domain/common/ui_locale.dart';
import '../stores/ui_locale_store.dart';

abstract interface class ReadUiLocale {
  UiLocale call();
}

@LazySingleton(as: ReadUiLocale)
class ReadUiLocaleImpl implements ReadUiLocale {
  const ReadUiLocaleImpl({
    required UiLocaleStore uiLocaleStore,
  }) : _uiLocaleStore = uiLocaleStore;

  final UiLocaleStore _uiLocaleStore;

  @override
  UiLocale call() {
    return _uiLocaleStore.state.uiLocale;
  }
}
