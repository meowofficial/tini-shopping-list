import 'package:equatable/equatable.dart';

import '../../../../../../core/interface_adapters/presentation/navigation/mobile/mobile_home_tab.dart';

class MobileHomeScreenView extends Equatable {
  const MobileHomeScreenView({
    required this.activeTab,
  });

  final MobileHomeTab activeTab;

  @override
  List<Object?> get props {
    return [
      activeTab,
    ];
  }

  MobileHomeScreenView copyWith({
    MobileHomeTab Function()? activeTab,
  }) {
    return MobileHomeScreenView(
      activeTab: activeTab == null ? this.activeTab : activeTab(),
    );
  }
}
