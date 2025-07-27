import 'package:application/core/use_cases/shared/output_dtos/ui_locale_output_dto.dart';
import 'package:meta/meta.dart';

import 'view_translation.dart';

abstract class BaseViewTranslation implements ViewTranslation {
  UiLocaleOutputDto? _uiLocale;

  @protected
  @override
  UiLocaleOutputDto get uiLocale {
    if (_uiLocale == null) {
      throw StateError('$runtimeType is not initialized');
    }

    return _uiLocale!;
  }

  @override
  void setUiLocale(UiLocaleOutputDto uiLocale) {
    _uiLocale = uiLocale;
  }
}
