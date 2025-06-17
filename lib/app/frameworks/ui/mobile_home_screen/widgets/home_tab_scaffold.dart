import 'package:flutter/cupertino.dart';

import '../../../../../../../core/common/errors/unexpected_state_error.dart';
import '../../../../../../../core/interface_adapters/presentation/navigation/mobile/mobile_home_tab.dart';

class HomeTabScaffold extends StatefulWidget {
  const HomeTabScaffold({
    required this.activeTab,
    required this.onTabPressed,
    required this.tabBuilder,
    super.key,
  });

  final MobileHomeTab activeTab;
  final void Function(MobileHomeTab) onTabPressed;
  final Widget Function(BuildContext, MobileHomeTab) tabBuilder;

  @override
  State<HomeTabScaffold> createState() => _HomeTabScaffoldState();
}

class _HomeTabScaffoldState extends State<HomeTabScaffold> {
  late final CupertinoTabController _tabController;

  int _getTabIndex(MobileHomeTab tab) {
    return switch (tab) {
      MobileHomeTab.overview => 0,
      MobileHomeTab.addition => 1,
    };
  }

  MobileHomeTab _getTabByIndex(int index) {
    return switch (index) {
      0 => MobileHomeTab.overview,
      1 => MobileHomeTab.addition,
      _ => throwStateError(),
    };
  }

  void _onTabPressed(int index) {
    final tab = _getTabByIndex(index);
    widget.onTabPressed(tab);
  }

  @override
  void initState() {
    super.initState();

    final initialIndex = _getTabIndex(widget.activeTab);

    _tabController = CupertinoTabController(
      initialIndex: initialIndex,
    );
  }

  @override
  void didUpdateWidget(covariant HomeTabScaffold oldWidget) {
    super.didUpdateWidget(oldWidget);

    final index = _getTabIndex(widget.activeTab);

    if (_tabController.index != index) {
      _tabController.index = index;
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      resizeToAvoidBottomInset: false,
      controller: _tabController,
      tabBar: CupertinoTabBar(
        items: [
          const BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.list_bullet,
              size: 28,
            ),
            label: 'Обзор',
          ),

          const BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.plus_app,
              size: 28,
            ),
            label: 'Добавление',
          ),
        ],
        onTap: _onTabPressed,
      ),
      tabBuilder: (context, index) {
        final tab = _getTabByIndex(index);
        return widget.tabBuilder(context, tab);
      },
    );
  }
}
