import 'package:berty1/accountss.dart';
import 'package:berty1/askai.dart';
import 'package:berty1/homepage.dart';
import 'package:berty1/search.dart';
import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

import 'package:material_symbols_icons/material_symbols_icons.dart';

class Btnnavigationbar extends StatefulWidget {
  const Btnnavigationbar({super.key});

  @override
  State<Btnnavigationbar> createState() => _StateBtnnavbar();
}

class _StateBtnnavbar extends State<Btnnavigationbar> {
  final iconList = <IconData>[
    Symbols.home,
    Symbols.person_2,
  ];
  int _bottomNavIndex = 0;
  List screens = [
    MyWidget(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(side: BorderSide(color: Color(0xFF0D6EFD))),
        child: IconButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Search(),
                ));
          },
          icon: Icon(Symbols.search, color: Colors.white),
        ),
        backgroundColor: Color(0xFF0D6EFD),
        onPressed: () {},
        //params
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        height: 70,
        icons: iconList,
        iconSize: 35,
        activeIndex: _bottomNavIndex,
        gapLocation: GapLocation.center,
        backgroundColor: Colors.white,
        inactiveColor: Colors.grey[300],
        activeColor: Colors.blue,
        notchSmoothness: null,
        leftCornerRadius: 0,
        rightCornerRadius: 0,
        splashColor: Colors.grey[300],

        onTap: (index) => setState(() => _bottomNavIndex = index),
        //other params
      ),
      body: screens[_bottomNavIndex],
    );
  }
}
