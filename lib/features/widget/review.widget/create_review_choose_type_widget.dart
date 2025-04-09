import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marketlyze_1/constants/gaps.dart';
import 'package:marketlyze_1/constants/sizes.dart';

class CreateReviewChooseTypeWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool select;
  final int selectedIndex;
  final Function onTap;

  const CreateReviewChooseTypeWidget({
    super.key,
    required this.icon,
    required this.text,
    required this.select,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.size10,
          horizontal: Sizes.size16,
        ),
        decoration: BoxDecoration(
          color: select == true
              ? Theme.of(context).primaryColor
              : const Color.fromARGB(255, 224, 243, 255),
          borderRadius: BorderRadius.circular(
            Sizes.size14,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FaIcon(
              icon,
              size: Sizes.size18,
              color: select == true ? Colors.black87 : Colors.grey,
            ),
            Gaps.h8,
            Text(
              text,
              style: TextStyle(
                fontSize: Sizes.size16,
                fontWeight: select == true ? FontWeight.w500 : FontWeight.w400,
                color: select == true ? Colors.black87 : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
