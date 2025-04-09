import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marketlyze_1/constants/gaps.dart';
import 'package:marketlyze_1/constants/sizes.dart';
import 'package:marketlyze_1/features/inbox/main_inbox_screen.dart';
import 'package:marketlyze_1/features/search/admin/main_admin_create_search_screen.dart';
import 'package:marketlyze_1/features/search/search_category/main_9_health_screen.dart';
import 'package:marketlyze_1/features/search/search_category/main_10_office_screen.dart';
import 'package:marketlyze_1/features/search/search_category/main_0_food_screen.dart';
import 'package:marketlyze_1/features/search/search_category/main_1_cloth_screen.dart';
import 'package:marketlyze_1/features/search/search_category/main_2_toy_screen.dart';
import 'package:marketlyze_1/features/search/search_category/main_3_sport_screen.dart';
import 'package:marketlyze_1/features/search/search_category/main_4_pet_screen.dart';
import 'package:marketlyze_1/features/search/search_category/main_5_home_screen.dart';
import 'package:marketlyze_1/features/search/search_category/main_6_daily_screen.dart';
import 'package:marketlyze_1/features/search/search_category/main_7_baby_screen.dart';
import 'package:marketlyze_1/features/search/search_category/main_8_book_screen.dart';
import 'package:marketlyze_1/features/widget/search_widget/search_icon_botton_widget.dart';
import 'package:marketlyze_1/features/widget/search_widget/search_tabbar_widget.dart';
import 'package:marketlyze_1/features/widget/search_widget/search_text_field_widget.dart';

class MainSearchScreen extends StatelessWidget {
  //static const routeURL = "/MainSearch";
  //static const routeName = "MainSearch";
  const MainSearchScreen({super.key});

  void _tapInboxScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const MainInboxScreen(),
      ),
    );
  }

  void _tapTextFieldScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const MainTextFieldWidget(),
      ),
    );
  }

// ---------- search type function --------- //

  void _tapMainFoodScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const MainFoodScreen(),
      ),
    );
  }

  void _tapMainClothScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const MainClothScreen(),
      ),
    );
  }

  void _tapMainToyScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const MainToyScreen(),
      ),
    );
  }

  void _tapMainSportScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const MainSportScreen(),
      ),
    );
  }

  void _tapMainPetScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const MainPetScreen(),
      ),
    );
  }

  void _tapMainFurnitureScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const MainFurnitureScreen(),
      ),
    );
  }

  void _tapMainDailyScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const MainDailyScreen(),
      ),
    );
  }

  void _tapMainBabyScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const MainBabyScreen(),
      ),
    );
  }

  void _tapMainBookScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const MainBookScreen(),
      ),
    );
  }

  void _tapMainHealthScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const MainHealthScreen(),
      ),
    );
  }

  void _tapMainOfficeScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const MainOfficeScreen(),
      ),
    );
  }

// ---------- admin용 search 데이터 입력 기능 ---------- //

  void _showAdminCreate(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const MainAdminCreaeSearchScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          "assets/image/logo.png",
          height: Sizes.size16,
        ),
        actions: [
          IconButton(
            onPressed: () => _showAdminCreate(context),
            icon: const FaIcon(
              FontAwesomeIcons.userSecret,
            ),
          ),
          IconButton(
            onPressed: () => _tapInboxScreen(context),
            icon: const FaIcon(
              FontAwesomeIcons.bell,
              size: Sizes.size24,
            ),
          ),
          Gaps.h8,
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: Sizes.size7,
                horizontal: Sizes.size10,
              ),
              child: SearchTabBarWidget(
                function: _tapTextFieldScreen,
              ),
            ),
            Gaps.v20,
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size10,
              ),
              child: Wrap(
                direction: Axis.horizontal,
                runSpacing: Sizes.size16,
                spacing: Sizes.size16,
                children: [
                  SearchIconBottonWidget(
                    function: _tapMainFoodScreen,
                    color: Colors.grey.shade400,
                    icon: FontAwesomeIcons.utensils,
                    text: "Food",
                    iconSize: Sizes.size28,
                    textSize: Sizes.size14,
                    textWeight: FontWeight.w600,
                  ),
                  SearchIconBottonWidget(
                    function: _tapMainClothScreen,
                    color: Colors.blue,
                    icon: FontAwesomeIcons.shirt,
                    text: "Cloth",
                    iconSize: Sizes.size28,
                    textSize: Sizes.size14,
                    textWeight: FontWeight.w600,
                  ),
                  SearchIconBottonWidget(
                    function: _tapMainToyScreen,
                    color: Colors.red,
                    icon: FontAwesomeIcons.shapes,
                    text: "Toy",
                    iconSize: Sizes.size28,
                    textSize: Sizes.size14,
                    textWeight: FontWeight.w600,
                  ),
                  SearchIconBottonWidget(
                    function: _tapMainSportScreen,
                    color: Colors.deepOrange,
                    icon: FontAwesomeIcons.basketball,
                    text: "Sport",
                    iconSize: Sizes.size28,
                    textSize: Sizes.size14,
                    textWeight: FontWeight.w600,
                  ),
                  SearchIconBottonWidget(
                    function: _tapMainPetScreen,
                    color: const Color.fromARGB(255, 255, 25, 101),
                    icon: FontAwesomeIcons.paw,
                    text: "Pet",
                    iconSize: Sizes.size28,
                    textSize: Sizes.size14,
                    textWeight: FontWeight.w600,
                  ),
                  SearchIconBottonWidget(
                    function: _tapMainFurnitureScreen,
                    color: const Color.fromARGB(255, 233, 91, 39),
                    icon: FontAwesomeIcons.couch,
                    text: "Home",
                    iconSize: Sizes.size28,
                    textSize: Sizes.size14,
                    textWeight: FontWeight.w600,
                  ),
                  SearchIconBottonWidget(
                    function: _tapMainDailyScreen,
                    color: const Color.fromARGB(255, 129, 230, 14),
                    icon: FontAwesomeIcons.jugDetergent,
                    text: "Daily",
                    iconSize: Sizes.size28,
                    textSize: Sizes.size14,
                    textWeight: FontWeight.w600,
                  ),
                  SearchIconBottonWidget(
                    function: _tapMainBabyScreen,
                    color: Colors.amberAccent,
                    icon: FontAwesomeIcons.babyCarriage,
                    text: "Baby",
                    iconSize: Sizes.size28,
                    textSize: Sizes.size14,
                    textWeight: FontWeight.w600,
                  ),
                  SearchIconBottonWidget(
                    function: _tapMainBookScreen,
                    color: Colors.brown,
                    icon: FontAwesomeIcons.book,
                    text: "Book",
                    iconSize: Sizes.size28,
                    textSize: Sizes.size14,
                    textWeight: FontWeight.w600,
                  ),
                  SearchIconBottonWidget(
                    function: _tapMainHealthScreen,
                    color: const Color.fromARGB(255, 255, 1, 1),
                    icon: FontAwesomeIcons.heartPulse,
                    text: "Health",
                    iconSize: Sizes.size28,
                    textSize: Sizes.size14,
                    textWeight: FontWeight.w600,
                  ),
                  // SearchIconBottonWidget(
                  //   function: _nullPush,
                  //   color: Colors.blueGrey,
                  //   icon: FontAwesomeIcons.car,
                  //   text: "Moblity",
                  //   iconSize: Sizes.size28,
                  //   textSize: Sizes.size14,
                  //   textWeight: FontWeight.w600,
                  // ),
                  SearchIconBottonWidget(
                    function: _tapMainOfficeScreen,
                    color: Colors.black45,
                    icon: FontAwesomeIcons.pen,
                    text: "Office",
                    iconSize: Sizes.size28,
                    textSize: Sizes.size14,
                    textWeight: FontWeight.w600,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
