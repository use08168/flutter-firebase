import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marketlyze_1/constants/sizes.dart';

class MainTextFieldWidget extends StatefulWidget {
  const MainTextFieldWidget({super.key});

  @override
  State<MainTextFieldWidget> createState() => _MainTextFieldWidgetState();
}

class SizeConfig {
  double widthSize(BuildContext context, double value) {
    return MediaQuery.of(context).size.width * value;
  }
}

class _MainTextFieldWidgetState extends State<MainTextFieldWidget> {
  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: Sizes.size10,
            horizontal: Sizes.size12,
          ),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: Sizes.size44,
                padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.size10,
                  vertical: Sizes.size3,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(
                    Sizes.size18,
                  ),
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: Navigator.of(context).pop,
                      icon: const FaIcon(
                        FontAwesomeIcons.angleLeft,
                        size: Sizes.size20,
                      ),
                    ),
                    SizedBox(
                      width: SizeConfig().widthSize(context, 0.75),
                      height: Sizes.size18,
                      child: TextField(
                        cursorColor: Theme.of(context).primaryColor,
                        decoration: const InputDecoration(
                          hintText: "search",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            vertical: Sizes.size9,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
