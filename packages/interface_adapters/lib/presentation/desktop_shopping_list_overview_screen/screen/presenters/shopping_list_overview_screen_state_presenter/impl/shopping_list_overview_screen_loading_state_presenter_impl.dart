import 'dart:async';

import 'package:application/core/use_cases/read_ui_locale/read_ui_locale.dart';
import 'package:application/core/use_cases/shared/output_dtos/ui_locale_output_dto.dart';
import 'package:application/core/use_cases/watch_ui_locale/watch_ui_locale.dart';

import '../../../../../core/base_view_streamable_presenter.dart';
import '../../../l10n/shopping_list_overview_screen_loading_state_view_translation/shopping_list_overview_screen_loading_state_view_translation.dart';
import '../../../views/shopping_list_overview_screen_views.dart';
import '../../shopping_list_overview_screen_state_presenter/shopping_list_overview_screen_state_presenter.dart';

class ShoppingListOverviewScreenLoadingStatePresenterImpl
    extends BaseViewStreamablePresenter<ShoppingListOverviewScreenLoadingStateView>
    implements ShoppingListOverviewScreenLoadingStatePresenter {
  ShoppingListOverviewScreenLoadingStatePresenterImpl({
    required ShoppingListOverviewScreenLoadingStateViewTranslation translation,
    required ReadUiLocale readUiLocale,
    required WatchUiLocale watchUiLocale,
  }) : _translation = translation,
       _readUiLocale = readUiLocale,
       _watchUiLocale = watchUiLocale {
    final uiLocale = _readUiLocale();

    _translation.setUiLocale(uiLocale);

    _uiLocaleStreamSubscription = _watchUiLocale().listen(_onUiLocaleChanged);

    final view = ShoppingListOverviewScreenLoadingStateView(
      title: _translation.title,
    );

    initializeView(view);
  }

  final ShoppingListOverviewScreenLoadingStateViewTranslation _translation;

  final ReadUiLocale _readUiLocale;
  final WatchUiLocale _watchUiLocale;

  late final StreamSubscription<UiLocaleOutputDto> _uiLocaleStreamSubscription;

  void _onUiLocaleChanged(UiLocaleOutputDto uiLocale) {
    _translation.setUiLocale(uiLocale);

    final updatedView = view.copyWith(
      title: () => _translation.title,
    );

    emit(updatedView);
  }

  @override
  void dispose() {
    _uiLocaleStreamSubscription.cancel();
    super.dispose();
  }
}
