import 'package:injectable/injectable.dart';

import '../../../../../../../core/domain/common/ui_locale.dart';
import '../../../../../../../core/interface_adapters/presentation/base_view_translation.dart';
import '../../../../../../../core/interface_adapters/presentation/view_translation.dart';

abstract interface class ShoppingListOverviewScreenLoadingStateViewTranslation
    implements ViewTranslation {
  String get title;
}

@LazySingleton(as: ShoppingListOverviewScreenLoadingStateViewTranslation)
class ShoppingListOverviewScreenLoadingStateViewTranslationImpl extends BaseViewTranslation
    implements ShoppingListOverviewScreenLoadingStateViewTranslation {
  ShoppingListOverviewScreenLoadingStateViewTranslationImpl();

  @override
  String get title {
    switch (uiLocale) {
      case UiLocale.ru:
        return 'Список покупок';
    }
  }
}
