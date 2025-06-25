import 'dart:async';

import '../../../../../../../core/application/use_cases/read_ui_locale.dart';
import '../../../../../../../core/application/use_cases/watch_ui_locale.dart';
import '../../../../../../../core/domain/common/ui_locale.dart';
import '../../../../../../../core/interface_adapters/presentation/base_view_streamable_presenter.dart';
import '../interfaces/shopping_list_overview_screen_state_presenters.dart';
import '../l10n/shopping_list_overview_screen_loading_state_view_translation.dart';
import '../views/shopping_list_overview_screen_state_views.dart';

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

  late final StreamSubscription<UiLocale> _uiLocaleStreamSubscription;

  void _onUiLocaleChanged(UiLocale uiLocale) {
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
