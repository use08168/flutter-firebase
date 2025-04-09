import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marketlyze_1/constants/gaps.dart';
import 'package:marketlyze_1/constants/sizes.dart';
import 'package:marketlyze_1/features/inbox/main_inbox_screen.dart';
import 'package:marketlyze_1/features/review/servy/main_servy_screen.dart';

class MainReviewScreen extends StatelessWidget {
  //static const routeURL = "/MainReview";
  //static const routeName = "MainReview";
  const MainReviewScreen({super.key});

  void _showServy(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const MainSurveyScreen(),
      ),
    );
  }

  void _tapInboxScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const MainInboxScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Image.asset(
          "assets/image/logo.png",
          height: Sizes.size16,
        ),
        actions: [
          IconButton(
            onPressed: () => _tapInboxScreen(context),
            icon: const FaIcon(
              FontAwesomeIcons.bell,
              size: Sizes.size24,
            ),
          ),
          Gaps.h8,
        ],
      ),
      body: const Center(
        child: Text("review"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showServy(context),
        elevation: 2,
        backgroundColor: const Color.fromARGB(255, 224, 243, 255),
        label: const Text(
          "Review start!",
          style: TextStyle(
            fontSize: Sizes.size18,
            fontWeight: FontWeight.w400,
            color: Colors.black87,
          ),
        ),
        icon: const FaIcon(
          FontAwesomeIcons.plus,
          color: Colors.black87,
          size: Sizes.size18,
        ),
      ),
    );
  }
}
