import 'package:flutter/material.dart';
import 'package:marketlyze_1/constants/sizes.dart';
import 'package:marketlyze_1/features/home/main_home_screen.dart';
import 'package:marketlyze_1/features/other/main_other_screen.dart';
import 'package:marketlyze_1/features/profile/main_profile_screen.dart';
import 'package:marketlyze_1/features/review/main_review_screen.dart';
import 'package:marketlyze_1/features/search/main_search_screen.dart';
import 'package:marketlyze_1/features/widget/botton_widget/botton_tabbar_widget.dart';

class MainScreen extends StatefulWidget {
  static const routeURL = "/MainScreen";
  static const routeName = "MainScreen";

  const MainScreen({
    super.key,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            Offstage(
              offstage: _selectedIndex != 0,
              child: const MainHomeScreen(),
            ),
            Offstage(
              offstage: _selectedIndex != 1,
              child: const MainSearchScreen(),
            ),
            Offstage(
              offstage: _selectedIndex != 2,
              child: const MainReviewScreen(),
            ),
            Offstage(
              offstage: _selectedIndex != 3,
              child: const MainOtherScreen(),
            ),
            Offstage(
              offstage: _selectedIndex != 4,
              child: const MainProfileScreen(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: Sizes.size86,
        child: BottonTabbarWidget(select: _selectedIndex, ontap: _onTap),
      ),
    );
  }
}
