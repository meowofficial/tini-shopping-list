import 'dart:async';

import '../../../../../../core/interface_adapters/presentation/base_view_streamable_presenter.dart';
import '../../../../../../core/interface_adapters/presentation/navigation/phone/phone_home_tab.dart';
import '../../../../../core/interface_adapters/presentation/navigation/phone/phone_navigator.dart';
import '../interfaces/phone_home_screen_presenter.dart';
import '../views/phone_home_screen_view.dart';

class PhoneHomeScreenPresenterImpl extends BaseViewStreamablePresenter<PhoneHomeScreenView>
    implements PhoneHomeScreenPresenter {
  PhoneHomeScreenPresenterImpl({
    required PhoneNavigator navigator,
  }) : _navigator = navigator {
    final view = PhoneHomeScreenView(
      activeTab: _navigator.state.homeNavigationState!.activeTab,
    );

    initializeView(view);

    _activeHomeTabStreamSubscription = _navigator.stateStream
        .map((it) => it.homeNavigationState!.activeTab)
        .distinct()
        .listen(_onActiveHomeTabChanged);
  }

  final PhoneNavigator _navigator;

  late final StreamSubscription<PhoneHomeTab> _activeHomeTabStreamSubscription;

  void _onActiveHomeTabChanged(PhoneHomeTab activeTab) {
    if (view.activeTab != activeTab) {
      final updatedView = view.copyWith(
        activeTab: () => activeTab,
      );

      emit(updatedView);
    }
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
    _activeHomeTabStreamSubscription.cancel();
    super.dispose();
  }
}
