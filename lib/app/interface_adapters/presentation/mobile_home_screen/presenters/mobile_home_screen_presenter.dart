import 'dart:async';

import '../../../../../../core/interface_adapters/presentation/base_presenter.dart';
import '../../../../../../core/interface_adapters/presentation/navigation/mobile/mobile_home_tab.dart';
import '../../../../../core/interface_adapters/presentation/navigation/mobile/mobile_navigator.dart';
import '../interfaces/mobile_home_screen_presenter.dart';
import '../views/mobile_home_screen_view.dart';

class MobileHomeScreenPresenterImpl extends BasePresenter<MobileHomeScreenView>
    implements MobileHomeScreenPresenter {
  MobileHomeScreenPresenterImpl({
    required MobileNavigator navigator,
  }) : _navigator = navigator {
    final view = MobileHomeScreenView(
      activeTab: _navigator.state.homeNavigationState!.activeTab,
    );

    initializeView(view);

    _activeHomeTabStreamSubscription = _navigator.stateStream
        .map((it) => it.homeNavigationState!.activeTab)
        .distinct()
        .listen(_onActiveHomeTabChanged);
  }

  final MobileNavigator _navigator;

  late final StreamSubscription<MobileHomeTab> _activeHomeTabStreamSubscription;

  void _onActiveHomeTabChanged(MobileHomeTab activeTab) {
    if (view.activeTab != activeTab) {
      final updatedView = view.copyWith(
        activeTab: () => activeTab,
      );

      emit(updatedView);
    }
  }

  @override
  void onTabPressed(MobileHomeTab tab) {
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
