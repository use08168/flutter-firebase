import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marketlyze_1/constants/sizes.dart';
import 'package:marketlyze_1/features/widget/botton_widget/botton_icon_widget.dart';

class BottonTabbarWidget extends StatelessWidget {
  const BottonTabbarWidget({
    super.key,
    required this.select,
    required this.ontap,
  });

  final int select;
  final Function ontap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Sizes.size5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BottonIconWidget(
            text: 'Home',
            isSelected: select == 0,
            icon: FontAwesomeIcons.house,
            selectedIcon: FontAwesomeIcons.house,
            onTap: () => ontap(0),
            selectedIndex: select,
          ),
          BottonIconWidget(
            text: 'Search',
            isSelected: select == 1,
            icon: FontAwesomeIcons.magnifyingGlass,
            selectedIcon: FontAwesomeIcons.magnifyingGlass,
            onTap: () => ontap(1),
            selectedIndex: select,
          ),
          BottonIconWidget(
            text: 'Review',
            isSelected: select == 2,
            icon: FontAwesomeIcons.gift,
            selectedIcon: FontAwesomeIcons.gift,
            onTap: () => ontap(2),
            selectedIndex: select,
          ),
          BottonIconWidget(
            text: 'Other',
            isSelected: select == 3,
            icon: FontAwesomeIcons.file,
            selectedIcon: FontAwesomeIcons.solidFile,
            onTap: () => ontap(3),
            selectedIndex: select,
          ),
          BottonIconWidget(
            text: 'Profile',
            isSelected: select == 4,
            icon: FontAwesomeIcons.user,
            selectedIcon: FontAwesomeIcons.solidUser,
            onTap: () => ontap(4),
            selectedIndex: select,
          ),
        ],
      ),
    );
  }
}
