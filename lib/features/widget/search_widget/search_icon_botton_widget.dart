import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marketlyze_1/constants/gaps.dart';
import 'package:marketlyze_1/constants/sizes.dart';

class SearchIconBottonWidget extends StatelessWidget {
  final void Function(BuildContext) function;
  final IconData icon;
  final Color color;
  final String text;
  final double textSize;
  final double iconSize;
  final FontWeight textWeight;

  const SearchIconBottonWidget({
    super.key,
    required this.function,
    required this.icon,
    required this.color,
    required this.text,
    required this.textSize,
    required this.textWeight,
    required this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => function(context),
      child: SizedBox(
        width: Sizes.size64,
        height: Sizes.size64,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(
              Sizes.size16,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.blueGrey.shade100,
                blurRadius: 5,
                spreadRadius: 0.1,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Gaps.v8,
              FaIcon(
                icon,
                color: Colors.white,
                size: iconSize,
              ),
              Gaps.v4,
              Text(
                text,
                style: TextStyle(
                  fontSize: textSize,
                  fontWeight: textWeight,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
