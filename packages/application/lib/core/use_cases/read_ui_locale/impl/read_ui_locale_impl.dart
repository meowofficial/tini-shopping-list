import 'package:injectable/injectable.dart';

import '../../../stores/ui_locale_store/ui_locale_store.dart';
import '../../shared/factories/ui_locale_output_dto_factory/ui_locale_output_dto_factory.dart';
import '../../shared/output_dtos/ui_locale_output_dto.dart';
import '../read_ui_locale.dart';

@LazySingleton(as: ReadUiLocale)
class ReadUiLocaleImpl implements ReadUiLocale {
  const ReadUiLocaleImpl({
    required UiLocaleOutputDtoFactory uiLocaleOutputDtoFactory,
    required UiLocaleStore uiLocaleStore,
  }) : _uiLocaleOutputDtoFactory = uiLocaleOutputDtoFactory,
       _uiLocaleStore = uiLocaleStore;

  final UiLocaleOutputDtoFactory _uiLocaleOutputDtoFactory;
  final UiLocaleStore _uiLocaleStore;

  @override
  UiLocaleOutputDto call() {
    return _uiLocaleOutputDtoFactory.createDto(
      uiLocale: _uiLocaleStore.state.uiLocale,
    );
  }
}
