import 'package:ek_shodbe_quran/component/admin/admin_order.dart';
import 'package:ek_shodbe_quran/component/admin/admin_question.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class admin extends StatefulWidget {
  const admin({super.key});

  @override
  State<admin> createState() => _adminState();
}

class _adminState extends State<admin> {
  PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);
  List<Widget> _buildScreens() {
    return [AdminOrder(), AdminQuestion()];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
          icon: ImageIcon(
            AssetImage('assets/icons/order.png'),
          ),
          title: ("অর্ডার"),
          activeColorPrimary: Theme.of(context).primaryColor,
          inactiveColorPrimary: CupertinoColors.systemGrey,
          activeColorSecondary: Colors.white,
          inactiveColorSecondary: Theme.of(context).primaryColor),
      PersistentBottomNavBarItem(
          icon: ImageIcon(
            AssetImage('assets/icons/chat.png'),
          ),
          title: ("প্রশ্নোত্তর"),
          activeColorPrimary: Theme.of(context).primaryColor,
          inactiveColorPrimary: CupertinoColors.systemGrey,
          activeColorSecondary: Colors.white,
          inactiveColorSecondary: Theme.of(context).primaryColor),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Colors.white, // Default is Colors.white.
        handleAndroidBackButtonPress: true, // Default is true.
        onItemSelected: (int index) {
          setState(
              () {}); // This is required to update the nav bar if Android back button is pressed
        },
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
        itemAnimationProperties: ItemAnimationProperties(
          // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimation(
          // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle:
            NavBarStyle.style7, // Choose the nav bar style with this property.
      ),
    );
  }
}
