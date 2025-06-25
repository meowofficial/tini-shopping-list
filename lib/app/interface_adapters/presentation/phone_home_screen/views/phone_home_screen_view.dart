import 'package:equatable/equatable.dart';

import '../../../../../../core/interface_adapters/presentation/navigation/phone/phone_home_tab.dart';

class PhoneHomeScreenView extends Equatable {
  const PhoneHomeScreenView({
    required this.activeTab,
    required this.overviewTabLabel,
    required this.additionTabLabel,
  });

  final PhoneHomeTab activeTab;
  final String overviewTabLabel;
  final String additionTabLabel;

  @override
  List<Object?> get props {
    return [
      activeTab,
      overviewTabLabel,
      additionTabLabel,
    ];
  }

  PhoneHomeScreenView copyWith({
    PhoneHomeTab Function()? activeTab,
    String Function()? overviewTabLabel,
    String Function()? additionTabLabel,
  }) {
    return PhoneHomeScreenView(
      activeTab: activeTab == null ? this.activeTab : activeTab(),
      overviewTabLabel: overviewTabLabel == null ? this.overviewTabLabel : overviewTabLabel(),
      additionTabLabel: additionTabLabel == null ? this.additionTabLabel : additionTabLabel(),
    );
  }
}
