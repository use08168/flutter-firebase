import 'package:flutter/material.dart';
import 'package:marketlyze_1/constants/sizes.dart';

class CustomButtonWidget extends StatefulWidget {
  final void Function(BuildContext) goFunction;
  final String text;
  final double verticalPadding;
  final double horizontalMargin;
  final double insideHeight;
  final double radius;
  final Color textColor;
  final Color borderColor;

  const CustomButtonWidget({
    super.key,
    required this.goFunction,
    required this.text,
    required this.verticalPadding,
    required this.horizontalMargin,
    required this.insideHeight,
    required this.radius,
    required this.textColor,
    required this.borderColor,
  });

  @override
  State<CustomButtonWidget> createState() => _CustomButtonWidgetState();
}

class _CustomButtonWidgetState extends State<CustomButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: widget.verticalPadding,
      ),
      margin: EdgeInsets.symmetric(
        horizontal: widget.horizontalMargin,
      ),
      decoration: BoxDecoration(
        color: widget.borderColor,
        borderRadius: BorderRadius.circular(
          widget.radius,
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
        height: widget.insideHeight,
        child: TextButton(
          onPressed: () => widget.goFunction(context),
          child: Text(
            widget.text,
            style: TextStyle(
              fontSize: Sizes.size16,
              fontWeight: FontWeight.w500,
              color: widget.textColor,
            ),
          ),
        ),
      ),
    );
  }
}
