import 'package:ek_shodbe_quran/provider/userDetailsProvider.dart';
import 'package:ek_shodbe_quran/screens/drawer.dart';
import 'package:ek_shodbe_quran/screens/tabs/book_tab.dart';
import 'package:ek_shodbe_quran/screens/tabs/home_tab.dart';
import 'package:ek_shodbe_quran/screens/tabs/question_tab.dart';
import 'package:ek_shodbe_quran/screens/tabs/video_tab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String uid = '';
  String name = '';
  String email = '';

  @override
  void initState() {
    setState(() {
      uid = UserDetailsProvider().getId();
      name = UserDetailsProvider().getName();
      email = UserDetailsProvider().getEmail();
    });
    super.initState();
  }

  PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);
  List<Widget> _buildScreens() {
    return [HomeTab(), BookTab(), VideoTab(), QuestionTab()];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
          icon: ImageIcon(
            AssetImage('assets/icons/home.png'),
          ),
          title: ("হোম"),
          activeColorPrimary: Theme.of(context).primaryColor,
          inactiveColorPrimary: CupertinoColors.systemGrey,
          activeColorSecondary: Colors.white,
          inactiveColorSecondary: Theme.of(context).primaryColor),
      PersistentBottomNavBarItem(
          icon: ImageIcon(
            AssetImage('assets/icons/book.png'),
          ),
          title: ("বই"),
          activeColorPrimary: Theme.of(context).primaryColor,
          inactiveColorPrimary: CupertinoColors.systemGrey,
          activeColorSecondary: Colors.white,
          inactiveColorSecondary: Theme.of(context).primaryColor),
      PersistentBottomNavBarItem(
          icon: ImageIcon(
            AssetImage('assets/icons/play.png'),
          ),
          title: ("ভিডিও"),
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
      appBar: AppBar(
        flexibleSpace: (_controller.index != 0)
            ? const Image(
                image: AssetImage(
                    'assets/images/toprectangle.png'), // Replace with your image path
                fit: BoxFit.cover,
              )
            : null,
        foregroundColor: Colors.white,
        title: (_controller.index == 0)
            ? const Text('একশব্দে কুরআন শিক্ষা')
            : (_controller.index == 1)
                ? const Text('বই পড়া')
                : (_controller.index == 2)
                    ? const Text('ভিডিও')
                    : const Text('প্রশ্নোত্তর'),
        centerTitle: true,
      ),
      drawer: const MyDrawer(),
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
