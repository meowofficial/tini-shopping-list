import 'package:meta/meta.dart';

import '../../domain/common/ui_locale.dart';
import 'view_translation.dart';

abstract class BaseViewTranslation implements ViewTranslation {
  UiLocale? _uiLocale;

  @protected
  @override
  UiLocale get uiLocale {
    if (_uiLocale == null) {
      throw StateError('$runtimeType is not initialized');
    }

    return _uiLocale!;
  }

  @override
  void setUiLocale(UiLocale uiLocale) {
    _uiLocale = uiLocale;
  }
}
