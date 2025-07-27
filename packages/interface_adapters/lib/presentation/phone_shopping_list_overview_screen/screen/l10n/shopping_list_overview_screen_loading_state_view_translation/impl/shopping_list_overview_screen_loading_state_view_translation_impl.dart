import 'package:application/core/use_cases/shared/output_dtos/ui_locale_output_dto.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/base_view_translation.dart';
import '../../shopping_list_overview_screen_loading_state_view_translation/shopping_list_overview_screen_loading_state_view_translation.dart';

@LazySingleton(as: ShoppingListOverviewScreenLoadingStateViewTranslation)
class ShoppingListOverviewScreenLoadingStateViewTranslationImpl extends BaseViewTranslation
    implements ShoppingListOverviewScreenLoadingStateViewTranslation {
  ShoppingListOverviewScreenLoadingStateViewTranslationImpl();

  @override
  String get title {
    switch (uiLocale) {
      case UiLocaleOutputDto.ru:
        return 'Список покупок';
    }
  }
}
