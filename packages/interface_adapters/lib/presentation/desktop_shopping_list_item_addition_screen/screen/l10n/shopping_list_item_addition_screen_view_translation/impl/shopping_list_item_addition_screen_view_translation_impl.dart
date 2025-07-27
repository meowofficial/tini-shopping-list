import 'package:application/core/use_cases/shared/output_dtos/ui_locale_output_dto.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/base_view_translation.dart';
import '../../shopping_list_item_addition_screen_view_translation/shopping_list_item_addition_screen_view_translation.dart';

@LazySingleton(as: ShoppingListItemAdditionScreenViewTranslation)
class ShoppingListItemAdditionScreenViewTranslationImpl extends BaseViewTranslation
    implements ShoppingListItemAdditionScreenViewTranslation {
  ShoppingListItemAdditionScreenViewTranslationImpl();

  @override
  String get title {
    switch (uiLocale) {
      case UiLocaleOutputDto.ru:
        return 'Добавление элемента';
    }
  }

  @override
  String get submissionButtonTitle {
    switch (uiLocale) {
      case UiLocaleOutputDto.ru:
        return 'Добавить';
    }
  }
}
