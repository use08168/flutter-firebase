import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marketlyze_1/constants/sizes.dart';

class MainToyScreen extends StatelessWidget {
  const MainToyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: Navigator.of(context).pop,
          icon: const FaIcon(
            FontAwesomeIcons.angleLeft,
            size: Sizes.size20,
          ),
        ),
        title: const Text("Toy"),
      ),
    );
  }
}
