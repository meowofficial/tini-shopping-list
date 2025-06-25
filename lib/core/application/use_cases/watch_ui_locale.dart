import 'package:injectable/injectable.dart';

import '../../domain/common/ui_locale.dart';
import '../stores/ui_locale_store.dart';

abstract interface class WatchUiLocale {
  Stream<UiLocale> call({
    bool sync = false,
  });
}

@LazySingleton(as: WatchUiLocale)
class WatchUiLocaleImpl implements WatchUiLocale {
  const WatchUiLocaleImpl({
    required UiLocaleStore uiLocaleStore,
  }) : _uiLocaleStore = uiLocaleStore;

  final UiLocaleStore _uiLocaleStore;

  @override
  Stream<UiLocale> call({
    bool sync = false,
  }) {
    final uiLocaleStoreStateStream = sync
        ? _uiLocaleStore.syncStateStream
        : _uiLocaleStore.stateStream;

    return uiLocaleStoreStateStream.map((state) => state.uiLocale).distinct();
  }
}
