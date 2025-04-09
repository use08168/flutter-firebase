import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marketlyze_1/constants/gaps.dart';
import 'package:marketlyze_1/constants/sizes.dart';

class SearchTabBarWidget extends StatelessWidget {
  final void Function(BuildContext) function;

  const SearchTabBarWidget({
    super.key,
    required this.function,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => function(context),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.size8,
          horizontal: Sizes.size24,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.grey.shade300,
          ),
          borderRadius: BorderRadius.circular(
            Sizes.size16,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.blueGrey.shade100,
              blurRadius: 4,
              spreadRadius: 0.1,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: const Row(
          children: [
            FaIcon(
              FontAwesomeIcons.magnifyingGlass,
              size: Sizes.size16,
            ),
            Gaps.h16,
            Text(
              "Search",
              style: TextStyle(fontSize: Sizes.size16),
            ),
          ],
        ),
      ),
    );
  }
}
