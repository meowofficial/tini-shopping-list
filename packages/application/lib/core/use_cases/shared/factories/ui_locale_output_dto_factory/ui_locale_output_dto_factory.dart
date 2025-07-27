import 'package:domain/core/value_objects/ui_locale.dart';

import '../../output_dtos/ui_locale_output_dto.dart';

abstract interface class UiLocaleOutputDtoFactory {
  UiLocaleOutputDto createDto({
    required UiLocale uiLocale,
  });
}
