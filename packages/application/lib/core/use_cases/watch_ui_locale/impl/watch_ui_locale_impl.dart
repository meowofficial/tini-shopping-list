import 'package:injectable/injectable.dart';

import '../../../stores/ui_locale_store/ui_locale_store.dart';
import '../../shared/factories/ui_locale_output_dto_factory/ui_locale_output_dto_factory.dart';
import '../../shared/output_dtos/ui_locale_output_dto.dart';
import '../watch_ui_locale.dart';

@LazySingleton(as: WatchUiLocale)
class WatchUiLocaleImpl implements WatchUiLocale {
  const WatchUiLocaleImpl({
    required UiLocaleOutputDtoFactory uiLocaleOutputDtoFactory,
    required UiLocaleStore uiLocaleStore,
  }) : _uiLocaleOutputDtoFactory = uiLocaleOutputDtoFactory,
       _uiLocaleStore = uiLocaleStore;

  final UiLocaleOutputDtoFactory _uiLocaleOutputDtoFactory;
  final UiLocaleStore _uiLocaleStore;

  @override
  Stream<UiLocaleOutputDto> call({
    bool sync = false,
  }) {
    final uiLocaleStoreStateStream = sync
        ? _uiLocaleStore.syncStateStream
        : _uiLocaleStore.stateStream;

    return uiLocaleStoreStateStream.map((state) {
      return _uiLocaleOutputDtoFactory.createDto(
        uiLocale: state.uiLocale,
      );
    }).distinct();
  }
}
