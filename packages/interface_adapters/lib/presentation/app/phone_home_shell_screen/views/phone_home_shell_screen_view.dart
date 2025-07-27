import 'package:equatable/equatable.dart';

import '../../../core/navigation/phone/phone_home_tab.dart';

class PhoneHomeShellScreenView extends Equatable {
  const PhoneHomeShellScreenView({
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

  PhoneHomeShellScreenView copyWith({
    PhoneHomeTab Function()? activeTab,
    String Function()? overviewTabLabel,
    String Function()? additionTabLabel,
  }) {
    return PhoneHomeShellScreenView(
      activeTab: activeTab == null ? this.activeTab : activeTab(),
      overviewTabLabel: overviewTabLabel == null ? this.overviewTabLabel : overviewTabLabel(),
      additionTabLabel: additionTabLabel == null ? this.additionTabLabel : additionTabLabel(),
    );
  }
}
