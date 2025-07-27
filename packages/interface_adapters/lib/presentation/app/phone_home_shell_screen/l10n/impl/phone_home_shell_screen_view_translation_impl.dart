import 'package:application/core/use_cases/shared/output_dtos/ui_locale_output_dto.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/base_view_translation.dart';
import '../phone_home_shell_screen_view_translation.dart';

@LazySingleton(as: PhoneHomeShellScreenViewTranslation)
class PhoneHomeShellScreenViewTranslationImpl extends BaseViewTranslation
    implements PhoneHomeShellScreenViewTranslation {
  PhoneHomeShellScreenViewTranslationImpl();

  @override
  String get overviewTabLabel {
    switch (uiLocale) {
      case UiLocaleOutputDto.ru:
        return 'Обзор';
    }
  }

  @override
  String get additionTabLabel {
    switch (uiLocale) {
      case UiLocaleOutputDto.ru:
        return 'Добавление';
    }
  }
}
