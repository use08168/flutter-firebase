import 'package:flutter/material.dart';
import 'package:marketlyze_1/constants/sizes.dart';

class AuthenticationButtonWidget extends StatelessWidget {
  final void Function(BuildContext) goFunction;
  final String text;

  const AuthenticationButtonWidget({
    super.key,
    required this.goFunction,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: Sizes.size36,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          Sizes.size20,
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
        height: Sizes.size56,
        child: TextButton(
          onPressed: () => goFunction(context),
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
    );
  }
}
