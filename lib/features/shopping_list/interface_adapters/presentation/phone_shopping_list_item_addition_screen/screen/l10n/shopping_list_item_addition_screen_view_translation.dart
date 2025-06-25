import 'package:injectable/injectable.dart';

import '../../../../../../../core/domain/common/ui_locale.dart';
import '../../../../../../../core/interface_adapters/presentation/base_view_translation.dart';
import '../../../../../../../core/interface_adapters/presentation/view_translation.dart';

abstract interface class ShoppingListItemAdditionScreenReadyStateViewTranslation
    implements ViewTranslation {
  String get title;

  String get submissionButtonTitle;
}

@LazySingleton(as: ShoppingListItemAdditionScreenReadyStateViewTranslation)
class ShoppingListItemAdditionScreenReadyStateViewTranslationImpl extends BaseViewTranslation
    implements ShoppingListItemAdditionScreenReadyStateViewTranslation {
  ShoppingListItemAdditionScreenReadyStateViewTranslationImpl();

  @override
  String get title {
    switch (uiLocale) {
      case UiLocale.ru:
        return 'Добавление элемента';
    }
  }

  @override
  String get submissionButtonTitle {
    switch (uiLocale) {
      case UiLocale.ru:
        return 'Добавить';
    }
  }
}
