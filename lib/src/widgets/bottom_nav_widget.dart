import 'package:coverletter/src/constants/assets.dart';
import 'package:coverletter/src/cv-upload/views/home_page.dart';
import 'package:coverletter/src/history/history.dart';
import 'package:coverletter/src/profile/view/profile_page.dart';
import 'package:coverletter/src/theme/color.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:flutter/material.dart';

class BottomNavWidget extends StatefulWidget {
  const BottomNavWidget({super.key});

  @override
  State<BottomNavWidget> createState() => _BottomNavWidgetState();
}

class _BottomNavWidgetState extends State<BottomNavWidget> {
  late PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  final unselectedColor = AppColors.disabled;
  final selectedColor = AppColors.primaryMain;

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style6, // Choose the nav bar style with this property.
    );
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const ImageIcon(AssetImage(kHomeIcon)),
        title: "Home",
        activeColorPrimary: selectedColor,
        inactiveColorPrimary: unselectedColor,
      ),
      PersistentBottomNavBarItem(
        icon: const ImageIcon(
          AssetImage(kTimerIcon),
        ),
        title: "History",
        activeColorPrimary: selectedColor,
        inactiveColorPrimary: unselectedColor,
      ),
      PersistentBottomNavBarItem(
        icon: const ImageIcon(
          AssetImage(kUserProfile),
        ),
        title: "Profile",
        activeColorPrimary: selectedColor,
        inactiveColorPrimary: unselectedColor,
      ),
    ];
  }

  List<Widget> _buildScreens() {
    return const [
      HomePage(),
      HistoryPage(),
      ProfilePage(),
    ];
  }
}
