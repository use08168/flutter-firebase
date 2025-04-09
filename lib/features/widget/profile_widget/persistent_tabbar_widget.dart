import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marketlyze_1/constants/sizes.dart';

class PersistentTabBarWidget extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.symmetric(
          horizontal: BorderSide(
            color: Colors.grey.shade200,
            width: 1,
          ),
        ),
      ),
      child: const TabBar(
        indicatorSize: TabBarIndicatorSize.label,
        indicatorColor: Colors.grey,
        labelPadding: EdgeInsets.symmetric(
          vertical: Sizes.size10,
        ),
        tabs: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Sizes.size40,
            ),
            child: Icon(Icons.grid_4x4_rounded),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Sizes.size40,
            ),
            child: FaIcon(FontAwesomeIcons.heart),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Sizes.size40,
            ),
            child: FaIcon(FontAwesomeIcons.bookmark),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 47;

  @override
  double get minExtent => 47;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
