import 'package:application/core/use_cases/shared/output_dtos/ui_locale_output_dto.dart';

abstract interface class ViewTranslation {
  UiLocaleOutputDto get uiLocale;

  void setUiLocale(UiLocaleOutputDto uiLocale);
}
