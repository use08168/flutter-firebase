import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marketlyze_1/constants/gaps.dart';
import 'package:marketlyze_1/constants/sizes.dart';
import 'package:marketlyze_1/features/authentication/email_password_screen.dart';
import 'package:marketlyze_1/features/authentication/view_model/signup_view_model.dart';
import 'package:marketlyze_1/features/widget/button_wiget/authentication_button_widget.dart';

class UsernameScreen extends ConsumerStatefulWidget {
  // static const routeURL = "/Username";
  // static const routeName = "Username";
  const UsernameScreen({super.key});

  @override
  ConsumerState<UsernameScreen> createState() => _UsernameScreenState();
}

class _UsernameScreenState extends ConsumerState<UsernameScreen> {
  final TextEditingController _usernameController = TextEditingController();

  String _username = "";
  bool _changeHintText = false;

  @override
  void initState() {
    super.initState();
    _usernameController.addListener(() {
      setState(() {
        _username = _usernameController.text;
      });
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  void _goEmailPasswordScreen(BuildContext context) {
    setState(() {
      _changeHintText = true;
    });
    if (_username.isEmpty) return;
    ref.read(signUpForm.notifier).state = {"username": _username};
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EmailPasswordScreen(username: _username),
      ),
    );
  }

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Sign up',
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size36),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.v40,
              const Text(
                'Create username',
                style: TextStyle(
                  fontSize: Sizes.size20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Gaps.v8,
              const Text(
                'You can always change this later',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: Sizes.size16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Gaps.v16,
              TextField(
                controller: _usernameController,
                cursorColor: Theme.of(context).primaryColor,
                decoration: InputDecoration(
                  counterText: "30 / ${_username.length.toString()}",
                  hintText: _username.isEmpty && _changeHintText == true
                      ? 'enter your username please'
                      : 'Username',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                    ),
                  ),
                ),
              ),
              Gaps.v28,
              AuthenticationButtonWidget(
                goFunction: _goEmailPasswordScreen,
                text: "Next",
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          height: Sizes.size36,
          elevation: 0,
          child: Image.asset("assets/image/logo.png"),
        ),
      ),
    );
  }
}
