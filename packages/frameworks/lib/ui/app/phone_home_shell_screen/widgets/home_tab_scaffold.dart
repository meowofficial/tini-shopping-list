import 'package:common/errors/unexpected_state_error.dart';
import 'package:flutter/cupertino.dart';
import 'package:interface_adapters/presentation/core/navigation/phone/phone_home_tab.dart';

class HomeTabScaffold extends StatefulWidget {
  const HomeTabScaffold({
    required this.activeTab,
    required this.onTabPressed,
    required this.tabBuilder,
    required this.tabLabelBuilder,
    super.key,
  });

  final PhoneHomeTab activeTab;
  final void Function(PhoneHomeTab) onTabPressed;
  final Widget Function(BuildContext, PhoneHomeTab) tabBuilder;
  final String Function(PhoneHomeTab) tabLabelBuilder;

  @override
  State<HomeTabScaffold> createState() => _HomeTabScaffoldState();
}

class _HomeTabScaffoldState extends State<HomeTabScaffold> {
  late final CupertinoTabController _tabController;

  int _getTabIndex(PhoneHomeTab tab) {
    return switch (tab) {
      PhoneHomeTab.overview => 0,
      PhoneHomeTab.addition => 1,
    };
  }

  PhoneHomeTab _getTabByIndex(int index) {
    return switch (index) {
      0 => PhoneHomeTab.overview,
      1 => PhoneHomeTab.addition,
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
          BottomNavigationBarItem(
            icon: const Icon(
              CupertinoIcons.list_bullet,
              size: 28,
            ),
            label: widget.tabLabelBuilder(PhoneHomeTab.overview),
          ),

          BottomNavigationBarItem(
            icon: const Icon(
              CupertinoIcons.plus_app,
              size: 28,
            ),
            label: widget.tabLabelBuilder(PhoneHomeTab.addition),
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
