import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marketlyze_1/constants/gaps.dart';
import 'package:marketlyze_1/constants/sizes.dart';
import 'package:marketlyze_1/features/authentication/birthday_screen.dart';
import 'package:marketlyze_1/features/authentication/view_model/signup_view_model.dart';
import 'package:marketlyze_1/features/widget/button_wiget/authentication_button_widget.dart';

class EmailPasswordScreenArg {
  final String username;

  EmailPasswordScreenArg({required this.username});
}

class EmailPasswordScreen extends ConsumerStatefulWidget {
  // static const routeURL = "/EmailPassword";
  // static const routeName = "EmailPassword";

  final String username;

  const EmailPasswordScreen({
    super.key,
    required this.username,
  });

  @override
  ConsumerState<EmailPasswordScreen> createState() =>
      _EmailPasswordScreenState();
}

class _EmailPasswordScreenState extends ConsumerState<EmailPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _email = "";
  String _password = "";
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(() {
      setState(() {
        _email = _emailController.text;
      });
    });
    _passwordController.addListener(() {
      setState(() {
        _password = _passwordController.text;
      });
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

// ---------- email ---------- //

  String? _isEmailValid() {
    if (_email.isEmpty) return null;
    final regExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    );
    if (!regExp.hasMatch(_email)) {
      return 'Not Vaild';
    }
    if (_email.length > 100) {
      return 'Max length';
    }
    return null;
  }

// ---------- password ---------- //

  bool _isPasswordValid() {
    return _password.isNotEmpty &&
        _password.length > 7 &&
        _password.length < 21;
  }

  bool _isPasswordFormValid() {
    final passwordRegExp =
        RegExp(r"^(?=.*[a-zA-Z])(?=.*\d)(?=.*[@$!%*#?&])[a-zA-Z\d@$!%*#?&]+$");

// ---------- 위에 있는 RegExp는 아래에 있는 주소를 기준으로 형성 함 ---------- //

// http://www.foufos.gr
// https://www.foufos.gr
// http://foufos.gr
// http://www.foufos.gr/kino
// http://werer.gr
// www.foufos.gr
// www.mp3.com
// www.t.co
// http://t.co
// http://www.t.co
// https://www.t.co
// www.aa.com
// http://aa.com
// http://www.aa.com
// https://www.aa.com
// badurlnotvalid://www.google.com - captured url www.google.com
// htpp://www.google.com - captured url www.google.com

    return passwordRegExp.hasMatch(_password);
  }

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  void _onClearTap() {
    _passwordController.clear();
  }

  void _toggleObscureText() {
    _obscureText = !_obscureText;
    setState(() {});
  }

  void _goBirthdayScreen(BuildContext context) {
    if (_email.isEmpty ||
        _password.isEmpty ||
        _isEmailValid() != null ||
        !_isPasswordValid() ||
        !_isPasswordFormValid()) return;

// ---------- firebase 이메일 비번 전송 부분 ---------- //

    final state = ref.read(signUpForm.notifier).state;
    ref.read(signUpForm.notifier).state = {
      ...state,
      "email": _email,
      "password": _password,
    };

// ---------- 생일 화면으로 이동 ---------- //

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const BirthdayScreen(),
      ),
    );
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gaps.v40,
                Text(
                  'What is your email and password, ${widget.username}?',
                  style: const TextStyle(
                    fontSize: Sizes.size20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Gaps.v16,
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  onEditingComplete: () => _goBirthdayScreen(context),
                  autocorrect: false,
                  cursorColor: Theme.of(context).primaryColor,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    errorText: _isEmailValid(),
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
                Gaps.v32,
                TextField(
                  controller: _passwordController,
                  onEditingComplete: () => _goBirthdayScreen(context),
                  obscureText: _obscureText,
                  autocorrect: false,
                  cursorColor: Theme.of(context).primaryColor,
                  decoration: InputDecoration(
                    suffix: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: _onClearTap,
                          child: FaIcon(
                            FontAwesomeIcons.solidCircleXmark,
                            color: Colors.grey.shade500,
                            size: Sizes.size20,
                          ),
                        ),
                        Gaps.h16,
                        GestureDetector(
                          onTap: _toggleObscureText,
                          child: FaIcon(
                            _obscureText
                                ? FontAwesomeIcons.eye
                                : FontAwesomeIcons.eyeSlash,
                            color: Colors.grey.shade500,
                            size: Sizes.size20,
                          ),
                        ),
                      ],
                    ),
                    hintText: 'Make it strong!',
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
                Gaps.v10,
                const Text(
                  'Your password must have : ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gaps.v10,
                Row(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.circleCheck,
                      size: Sizes.size20,
                      color: _isPasswordValid()
                          ? Colors.green
                          : Colors.red.shade400,
                    ),
                    Gaps.h5,
                    const Text('8 to 20 characters')
                  ],
                ),
                Gaps.v10,
                Row(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.circleCheck,
                      size: Sizes.size20,
                      color: _isPasswordFormValid()
                          ? Colors.green
                          : Colors.red.shade400,
                    ),
                    Gaps.h5,
                    const Text('Letters, numbers, and special characters')
                  ],
                ),
                Gaps.v36,
                AuthenticationButtonWidget(
                  goFunction: _goBirthdayScreen,
                  text: "Next",
                ),
                Gaps.v32,
              ],
            ),
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
