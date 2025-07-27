import 'package:domain/core/value_objects/ui_locale.dart';
import 'package:injectable/injectable.dart';

import '../../../output_dtos/ui_locale_output_dto.dart';
import '../../ui_locale_output_dto_factory/ui_locale_output_dto_factory.dart';

@LazySingleton(as: UiLocaleOutputDtoFactory)
class UiLocaleOutputDtoFactoryImpl implements UiLocaleOutputDtoFactory {
  const UiLocaleOutputDtoFactoryImpl();

  @override
  UiLocaleOutputDto createDto({
    required UiLocale uiLocale,
  }) {
    switch (uiLocale) {
      case UiLocale.ru:
        return UiLocaleOutputDto.ru;
    }
  }
}
