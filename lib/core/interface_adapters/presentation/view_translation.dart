import '../../domain/common/ui_locale.dart';

abstract interface class ViewTranslation {
  UiLocale get uiLocale;

  void setUiLocale(UiLocale uiLocale);
}
