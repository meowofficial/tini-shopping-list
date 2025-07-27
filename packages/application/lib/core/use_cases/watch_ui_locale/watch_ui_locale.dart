import '../shared/output_dtos/ui_locale_output_dto.dart';

abstract interface class WatchUiLocale {
  Stream<UiLocaleOutputDto> call({
    bool sync = false,
  });
}
