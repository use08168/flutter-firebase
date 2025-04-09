import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marketlyze_1/constants/gaps.dart';
import 'package:marketlyze_1/constants/sizes.dart';
import 'package:marketlyze_1/features/authentication/view_model/signup_view_model.dart';
import 'package:marketlyze_1/features/widget/button_wiget/authentication_button_widget.dart';

class BirthdayScreen extends ConsumerStatefulWidget {
  // static const routeURL = "/Birthday";
  // static const routeName = "Birthday";
  const BirthdayScreen({super.key});

  @override
  ConsumerState<BirthdayScreen> createState() => _BirthdayScreenState();
}

class _BirthdayScreenState extends ConsumerState<BirthdayScreen> {
  DateTime _dateTime = DateTime.now();
  bool _checkBirthday = false;

  void _showDatePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dateTime,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != _dateTime) {
      setState(() {
        _dateTime = picked;
        _checkBirthday = true;
      });
    } else if (picked == null) {
      setState(() {
        _checkBirthday = false;
      });
    }

    final state = ref.read(signUpForm.notifier).state;
    ref.read(signUpForm.notifier).state = {
      ...state,
      "birthday": _dateTime.toString().split(" ").first.toString()
    };
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          "Accept?",
          style: TextStyle(
            fontSize: Sizes.size24,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        content: Text(
          "Your bithday is ${_dateTime.toString().split(" ").first} right?",
          style: const TextStyle(
            fontSize: Sizes.size20,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
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
// ---------- firebase로 이메일 비번 전송 ---------- //

              ref.read(signUpProvider.notifier).signUp(context);
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
      barrierDismissible: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sign up',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size36,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gaps.v40,
            const Text(
              'Enter your birthday',
              style: TextStyle(
                fontSize: Sizes.size20,
                fontWeight: FontWeight.w700,
              ),
            ),
            Gaps.v8,
            const Text(
              'You can`t change this later',
              style: TextStyle(
                color: Colors.black54,
                fontSize: Sizes.size16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Text(
              'Please enter be careful',
              style: TextStyle(
                color: Colors.black54,
                fontSize: Sizes.size16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Gaps.v24,
            Text(
              _dateTime.toString().split(" ").first,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: Sizes.size24,
                fontWeight: FontWeight.w600,
              ),
            ),
            Gaps.v32,
            AuthenticationButtonWidget(
              goFunction: _showDatePicker,
              text: "Choose date",
            ),
            Gaps.v28,
            if (_checkBirthday == true)
              AuthenticationButtonWidget(
                goFunction: _showDialog,
                text: "Submit",
              ),
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
