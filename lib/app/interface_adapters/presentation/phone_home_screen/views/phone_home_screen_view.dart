import 'package:equatable/equatable.dart';

import '../../../../../../core/interface_adapters/presentation/navigation/phone/phone_home_tab.dart';

class PhoneHomeScreenView extends Equatable {
  const PhoneHomeScreenView({
    required this.activeTab,
  });

  final PhoneHomeTab activeTab;

  @override
  List<Object?> get props {
    return [
      activeTab,
    ];
  }

  PhoneHomeScreenView copyWith({
    PhoneHomeTab Function()? activeTab,
  }) {
    return PhoneHomeScreenView(
      activeTab: activeTab == null ? this.activeTab : activeTab(),
    );
  }
}
