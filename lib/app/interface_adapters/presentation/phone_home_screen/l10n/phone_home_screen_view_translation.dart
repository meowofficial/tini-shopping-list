import 'package:injectable/injectable.dart';

import '../../../../../../../core/domain/common/ui_locale.dart';
import '../../../../../../../core/interface_adapters/presentation/base_view_translation.dart';
import '../../../../../../../core/interface_adapters/presentation/view_translation.dart';

abstract interface class PhoneHomeScreenViewTranslation implements ViewTranslation {
  String get overviewTabLabel;

  String get additionTabLabel;
}

@LazySingleton(as: PhoneHomeScreenViewTranslation)
class PhoneHomeScreenViewTranslationImpl extends BaseViewTranslation
    implements PhoneHomeScreenViewTranslation {
  PhoneHomeScreenViewTranslationImpl();

  @override
  String get overviewTabLabel {
    switch (uiLocale) {
      case UiLocale.ru:
        return 'Обзор';
    }
  }

  @override
  String get additionTabLabel {
    switch (uiLocale) {
      case UiLocale.ru:
        return 'Добавление';
    }
  }
}
