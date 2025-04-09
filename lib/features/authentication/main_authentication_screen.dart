import 'package:flutter/material.dart';
import 'package:marketlyze_1/constants/gaps.dart';
import 'package:marketlyze_1/constants/sizes.dart';
import 'package:marketlyze_1/features/authentication/select_login_screen.dart';
import 'package:marketlyze_1/features/authentication/select_signup_screen.dart';
import 'package:marketlyze_1/features/widget/button_wiget/authentication_button_widget.dart';

class MainAuthenticationScreen extends StatelessWidget {
  static const routeURL = "/";
  static const routeName = "MainAuthentication";
  const MainAuthenticationScreen({super.key});

  void _goSelectLoginScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SelectLoginScreen(),
      ),
    );
  }

  void _goSelectSignUpScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SelectSignUpScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Welecome to",
              style: TextStyle(
                fontSize: Sizes.size28,
                fontWeight: FontWeight.w600,
              ),
            ),
            Gaps.v12,
            Image.asset(
              "assets/image/logo.png",
              height: Sizes.size24,
            ),
            Gaps.v80,
            AuthenticationButtonWidget(
              goFunction: _goSelectLoginScreen,
              text: "go login screen",
            ),
            Gaps.v32,
            AuthenticationButtonWidget(
              goFunction: _goSelectSignUpScreen,
              text: "go sign up screen",
            ),
            Gaps.v96,
          ],
        ),
      ),
    );
  }
}
