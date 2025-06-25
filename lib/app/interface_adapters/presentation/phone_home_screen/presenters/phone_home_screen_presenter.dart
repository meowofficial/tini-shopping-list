import 'dart:async';

import '../../../../../../core/interface_adapters/presentation/base_view_streamable_presenter.dart';
import '../../../../../../core/interface_adapters/presentation/navigation/phone/phone_home_tab.dart';
import '../../../../../core/application/use_cases/read_ui_locale.dart';
import '../../../../../core/application/use_cases/watch_ui_locale.dart';
import '../../../../../core/domain/common/ui_locale.dart';
import '../../../../../core/interface_adapters/presentation/navigation/phone/phone_navigator.dart';
import '../interfaces/phone_home_screen_presenter.dart';
import '../l10n/phone_home_screen_view_translation.dart';
import '../views/phone_home_screen_view.dart';

class PhoneHomeScreenPresenterImpl extends BaseViewStreamablePresenter<PhoneHomeScreenView>
    implements PhoneHomeScreenPresenter {
  PhoneHomeScreenPresenterImpl({
    required PhoneHomeScreenViewTranslation translation,
    required PhoneNavigator navigator,
    required ReadUiLocale readUiLocale,
    required WatchUiLocale watchUiLocale,
  }) : _translation = translation,
       _navigator = navigator,
       _readUiLocale = readUiLocale,
       _watchUiLocale = watchUiLocale {
    final uiLocale = _readUiLocale();

    _translation.setUiLocale(uiLocale);

    final view = PhoneHomeScreenView(
      activeTab: _navigator.state.homeNavigationState!.activeTab,
      overviewTabLabel: _translation.overviewTabLabel,
      additionTabLabel: _translation.additionTabLabel,
    );

    initializeView(view);

    _activeHomeTabStreamSubscription = _navigator.stateStream
        .map((it) => it.homeNavigationState!.activeTab)
        .distinct()
        .listen(_onActiveHomeTabChanged);

    _uiLocaleStreamSubscription = _watchUiLocale().listen(_onUiLocaleChanged);
  }

  final PhoneHomeScreenViewTranslation _translation;
  final PhoneNavigator _navigator;

  final ReadUiLocale _readUiLocale;
  final WatchUiLocale _watchUiLocale;

  late final StreamSubscription<PhoneHomeTab> _activeHomeTabStreamSubscription;
  late final StreamSubscription<UiLocale> _uiLocaleStreamSubscription;

  void _onActiveHomeTabChanged(PhoneHomeTab activeTab) {
    if (view.activeTab != activeTab) {
      final updatedView = view.copyWith(
        activeTab: () => activeTab,
      );

      emit(updatedView);
    }
  }

  void _onUiLocaleChanged(UiLocale uiLocale) {
    _translation.setUiLocale(uiLocale);

    final updatedView = view.copyWith(
      overviewTabLabel: () => _translation.overviewTabLabel,
      additionTabLabel: () => _translation.additionTabLabel,
    );

    emit(updatedView);
  }

  @override
  void onTabPressed(PhoneHomeTab tab) {
    final homeNavigationState = _navigator.state.homeNavigationState!;

    if (homeNavigationState.activeTab != tab) {
      final updatedHomeNavigationState = homeNavigationState.copyWith(
        activeTab: () => tab,
      );

      _navigator.updateWith(
        homeNavigationState: () => updatedHomeNavigationState,
      );
    }
  }

  @override
  void dispose() {
    _uiLocaleStreamSubscription.cancel();
    _activeHomeTabStreamSubscription.cancel();
    super.dispose();
  }
}
