import 'package:flutter/material.dart';
import 'package:marketlyze_1/constants/sizes.dart';

class TextBubbleWidget extends StatelessWidget {
  final double insideVerticalPadding;
  final double insidehorizontalPadding;
  final double outsidehorizontalMargin;
  final double borderRadius;
  final String text;

  const TextBubbleWidget({
    super.key,
    required this.insideVerticalPadding,
    required this.insidehorizontalPadding,
    required this.outsidehorizontalMargin,
    required this.borderRadius,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            vertical: insideVerticalPadding,
            horizontal: insidehorizontalPadding,
          ),
          margin: EdgeInsets.symmetric(
            horizontal: outsidehorizontalMargin,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              borderRadius,
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
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: Sizes.size16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade800,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
