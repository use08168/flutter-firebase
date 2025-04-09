import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:marketlyze_1/constants/gaps.dart';
import 'package:marketlyze_1/constants/sizes.dart';
import 'package:marketlyze_1/features/authentication/repository/authentication_repository.dart';

class MainSettingScreen extends ConsumerWidget {
  const MainSettingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("main Setting"),
        leading: IconButton(
          onPressed: Navigator.of(context).pop,
          icon: const FaIcon(
            FontAwesomeIcons.angleLeft,
            size: Sizes.size20,
          ),
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text("Log Out"),
            textColor: Colors.red,
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text(
                    "Are you sure?",
                    style: TextStyle(
                      fontSize: Sizes.size24,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  content: const Text(
                    "Log out application?",
                    style: TextStyle(
                      fontSize: Sizes.size20,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        "No",
                        style: TextStyle(
                          fontSize: Sizes.size16,
                          color: Colors.grey.shade800,
                        ),
                      ),
                    ),
                    Gaps.h20,
                    TextButton(
                      onPressed: () {
                        ref.read(authRepo).signOut();
                        context.go("/");
                      },
                      child: Text(
                        "Yes",
                        style: TextStyle(
                          fontSize: Sizes.size16,
                          color: Colors.grey.shade800,
                        ),
                      ),
                    ),
                  ],
                  actionsAlignment: MainAxisAlignment.center,
                  backgroundColor: Colors.white,
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
