import 'package:berty1/accountss.dart' show ProfilePage;
import 'package:berty1/askai.dart';
import 'package:berty1/grant.dart';
import 'package:berty1/homepage.dart';
import 'package:berty1/search.dart';

import 'package:cuberto_bottom_bar/cuberto_bottom_bar.dart';

import 'package:flutter/material.dart';

class BottomBarWithNormalStyle extends StatefulWidget {
  const BottomBarWithNormalStyle({super.key});

  @override
  State<BottomBarWithNormalStyle> createState() => _BottomBarWithNormalStyle();
}

class _BottomBarWithNormalStyle extends State<BottomBarWithNormalStyle> {
  List<TabData> tabs = [];
  final Color _inactiveColor = Colors.lightBlue;
  Color _currentColor = Colors.blue;
  int _currentPage = 0;
  late String _currentTitle;
  List screens = [
    MyWidget(),
    Search(),
    AskAI(),
    ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    tabs = [
      TabData(
          iconData: Icons.home,
          title: "Home",
          tabColor: Colors.black,
          tabGradient: getGradient(Color.fromARGB(255, 52, 142, 246))),
      TabData(
        iconData: Icons.search,
        title: "Search",
        tabColor: Colors.black,
        tabGradient: getGradient(Colors.pink),
      ),
      TabData(
        iconData: Icons.psychology,
        title: "AI",
        tabColor: Colors.black,
        tabGradient: getGradient(Colors.lightGreenAccent),
      ),
      TabData(
        iconData: Icons.person,
        title: "Profile",
        tabColor: Colors.black,
        tabGradient: getGradient(Colors.teal),
      ),
    ];
    _currentTitle = tabs[0].title;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: screens[_currentPage],
      bottomNavigationBar: CubertoBottomBar(
        key: const Key("BottomBar"),
        inactiveIconColor: _inactiveColor,
        tabStyle: CubertoTabStyle.styleFadedBackground,
        selectedTab: _currentPage,
        tabs: tabs
            .map(
              (value) => TabData(
                key: Key(value.title),
                iconData: value.iconData,
                title: value.title,
                tabColor: value.tabColor,
                tabGradient: value.tabGradient,
              ),
            )
            .toList(),
        onTabChangedListener: (position, title, color) {
          setState(() {
            _currentPage = position;
            _currentTitle = title;
            if (color != null) {
              _currentColor = color;
            }
          });
        },
      ),
    );
  }
}
