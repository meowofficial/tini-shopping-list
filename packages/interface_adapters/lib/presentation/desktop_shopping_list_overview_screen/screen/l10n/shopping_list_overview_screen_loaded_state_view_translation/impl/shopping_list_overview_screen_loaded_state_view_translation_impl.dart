import 'package:application/core/use_cases/shared/output_dtos/ui_locale_output_dto.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/base_view_translation.dart';
import '../../shopping_list_overview_screen_loaded_state_view_translation/shopping_list_overview_screen_loaded_state_view_translation.dart';

@LazySingleton(as: ShoppingListOverviewScreenLoadedStateViewTranslation)
class ShoppingListOverviewScreenLoadedStateViewTranslationImpl extends BaseViewTranslation
    implements ShoppingListOverviewScreenLoadedStateViewTranslation {
  ShoppingListOverviewScreenLoadedStateViewTranslationImpl();

  @override
  String get title {
    switch (uiLocale) {
      case UiLocaleOutputDto.ru:
        return 'Список покупок';
    }
  }
}
