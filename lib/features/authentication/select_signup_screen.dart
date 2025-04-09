import 'package:flutter/material.dart';
import 'package:marketlyze_1/constants/gaps.dart';
import 'package:marketlyze_1/constants/sizes.dart';
import 'package:marketlyze_1/features/authentication/username_screen.dart';
import 'package:marketlyze_1/features/widget/button_wiget/authentication_button_widget.dart';

class SelectSignUpScreen extends StatelessWidget {
  //static const routeURL = "/SelectSinUp";
  //static const routeName = "SelectSinUp";
  const SelectSignUpScreen({super.key});

  void _goSignUpScreen(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const UsernameScreen(),
        ));
  }

  void _return(BuildContext context) {
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Choose your sign up",
          style: TextStyle(
            fontSize: Sizes.size18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AuthenticationButtonWidget(
              goFunction: _goSignUpScreen,
              text: "email & password",
            ),
            Gaps.v32,
            AuthenticationButtonWidget(
              goFunction: _return,
              text: "Google",
            ),
            Gaps.v32,
            AuthenticationButtonWidget(
              goFunction: _return,
              text: "Kakao",
            ),
            Gaps.v32,
            AuthenticationButtonWidget(
              goFunction: _return,
              text: "Naver",
            ),
            Gaps.v36,
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: Sizes.size36,
        elevation: 0,
        child: Image.asset("assets/image/logo.png"),
      ),
    );
  }
}
