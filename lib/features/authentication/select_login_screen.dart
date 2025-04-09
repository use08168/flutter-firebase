import 'package:flutter/material.dart';
import 'package:marketlyze_1/constants/gaps.dart';
import 'package:marketlyze_1/constants/sizes.dart';
import 'package:marketlyze_1/features/authentication/main_login_screen.dart';
import 'package:marketlyze_1/features/widget/button_wiget/authentication_button_widget.dart';

class SelectLoginScreen extends StatelessWidget {
  //static const routeURL = "/SelectLogin";
  //static const routeName = "SelectLogin";
  const SelectLoginScreen({super.key});

  void _goLoginScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MainLoginScreen(),
      ),
    );
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
          "Choose your login",
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
              goFunction: _goLoginScreen,
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
