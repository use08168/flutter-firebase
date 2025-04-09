import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marketlyze_1/constants/gaps.dart';
import 'package:marketlyze_1/constants/sizes.dart';
import 'package:marketlyze_1/features/user/view_model/users_view_model.dart';
import 'package:marketlyze_1/features/widget/profile_widget/profile_circleavatar_widget.dart';

class ProfileEditingScreen extends ConsumerStatefulWidget {
  const ProfileEditingScreen({super.key});

  @override
  ConsumerState<ProfileEditingScreen> createState() =>
      _ProfileEditingScreenState();
}

class _ProfileEditingScreenState extends ConsumerState<ProfileEditingScreen> {
  final TextEditingController _realnameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _linkController = TextEditingController();

  String _realname = "";
  String _username = "";
  String _bio = "";
  String _link = "";
  bool _realnameClick = false;
  bool _usernameClick = false;
  bool _bioClick = false;
  bool _linkClick = false;

  @override
  void initState() {
    super.initState();
    _realnameController.addListener(() {
      setState(() {
        _realname = _realnameController.text;
        _realnameClick = true;
      });
    });
    _usernameController.addListener(() {
      setState(() {
        _username = _usernameController.text;
        _usernameClick = true;
      });
    });
    _bioController.addListener(() {
      setState(() {
        _bio = _bioController.text;
        _bioClick = true;
      });
    });
    _linkController.addListener(() {
      setState(() {
        _link = _linkController.text;
        _linkClick = true;
      });
    });
  }

  @override
  void dispose() {
    _realnameController.dispose();
    _usernameController.dispose();
    _bioController.dispose();
    _linkController.dispose();
    super.dispose();
  }

  String? _isRealnameValid() {
    if (_realnameClick == true) {
      if (_realname.isEmpty) {
        return "You must enter your name";
      }
      if (_realname.length == 30) {
        return "Max length";
      }
    }
    return null;
  }

  String? _isUsernameValid() {
    if (_usernameClick == true) {
      if (_username.isEmpty) {
        return "You must enter username";
      }
      if (_username.length == 30) {
        return "Max length";
      }
    }
    return null;
  }

  String? _isBioValid() {
    if (_bioClick == true) {
      if (_bio.isEmpty) {
        return "Your bio erased";
      }
      if (_bio.length == 200) {
        return "Max length";
      }
    }
    return null;
  }

  String? _isLinkValid() {
    if (_linkClick == true) {
      if (_link.isEmpty) {
        return "Your link erased";
      }
      final regExp = RegExp(
        "(https?://(?:www.|(?!www))[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9].[^s]{2,}|www.[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9].[^s]{2,}|https?://(?:www.|(?!www))[a-zA-Z0-9]+.[^s]{2,}|www.[a-zA-Z0-9]+.[^s]{2,})",
      );
      if (!regExp.hasMatch(_link)) {
        return 'Not Vaild';
      }
      if (_link.length > 20) {
        return "Max length";
      }
    }

    return null;
  }

  Map<String, String> formData = {};
  void _onSubmitTap() {
    if (_isRealnameValid() != null ||
        _isUsernameValid() != null ||
        _isBioValid() != null ||
        _isLinkValid() != null) {
      return;
    }

    ref.read(usersProvider.notifier).updateProfile(
          realname: formData["realname"],
          username: formData["username"],
          bio: formData["bio"],
          link: formData["link"],
        );
    Navigator.of(context).pop();
  }

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(usersProvider).when(
          error: (error, stackTrace) => Center(
            child: Text(
              error.toString(),
            ),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          ),
          data: (data) => GestureDetector(
            onTap: _onScaffoldTap,
            child: Scaffold(
              appBar: AppBar(
                title: const Text("ProfileEdit screen"),
                actions: [
                  IconButton(
                    onPressed: _onSubmitTap,
                    icon: const FaIcon(
                      FontAwesomeIcons.check,
                      size: Sizes.size18,
                    ),
                  ),
                ],
                leading: IconButton(
                  onPressed: Navigator.of(context).pop,
                  icon: const FaIcon(
                    FontAwesomeIcons.angleLeft,
                    size: Sizes.size20,
                  ),
                ),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: Sizes.size36,
                    horizontal: Sizes.size36,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: ProfileCircleAvatarWidget(
                          circleSize: 60,
                          hasAvatar: data.hasAvatar,
                          uid: data.uid,
                        ),
                      ),
                      Gaps.v32,
                      const Text(
                        "Name",
                        style: TextStyle(
                          fontSize: Sizes.size20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextField(
                        controller: _realnameController,
                        autocorrect: false,
                        maxLength: 30,
                        cursorColor: Theme.of(context).primaryColor,
                        decoration: InputDecoration(
                          counterText: "30 / ${_realname.length.toString()}",
                          hintStyle: TextStyle(
                            color: _realnameClick == true
                                ? Colors.red.shade800
                                : Colors.black54,
                          ),
                          hintText: data.realname,
                          errorText: _isRealnameValid(),
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
                        onChanged: (newValue) {
                          formData['realname'] = newValue;
                        },
                      ),
                      Gaps.v32,
                      const Text(
                        "Username",
                        style: TextStyle(
                          fontSize: Sizes.size20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextField(
                        controller: _usernameController,
                        autocorrect: false,
                        maxLength: 30,
                        cursorColor: Theme.of(context).primaryColor,
                        decoration: InputDecoration(
                          counterText: "30 / ${_username.length.toString()}",
                          hintStyle: TextStyle(
                            color: _usernameClick == true
                                ? Colors.red.shade800
                                : Colors.black54,
                          ),
                          hintText: data.username,
                          errorText: _isUsernameValid(),
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
                        onChanged: (newValue) {
                          formData['username'] = newValue;
                        },
                      ),
                      Gaps.v32,
                      const Text(
                        "Bio",
                        style: TextStyle(
                          fontSize: Sizes.size20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextField(
                        controller: _bioController,
                        autocorrect: false,
                        maxLength: 200,
                        cursorColor: Theme.of(context).primaryColor,
                        decoration: InputDecoration(
                          counterText: "200 / ${_bio.length.toString()}",
                          hintStyle: TextStyle(
                            color: _bioClick == true
                                ? Colors.red.shade800
                                : Colors.black54,
                          ),
                          hintText: data.bio,
                          errorText: _isBioValid(),
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
                        onChanged: (newValue) {
                          formData['bio'] = newValue;
                        },
                      ),
                      Gaps.v32,
                      const Text(
                        "Link",
                        style: TextStyle(
                          fontSize: Sizes.size20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextField(
                        controller: _linkController,
                        autocorrect: false,
                        cursorColor: Theme.of(context).primaryColor,
                        decoration: InputDecoration(
                          hintStyle: TextStyle(
                            color: _linkClick == true
                                ? Colors.red.shade800
                                : Colors.black54,
                          ),
                          hintText: data.link,
                          errorText: _isLinkValid(),
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
                        onChanged: (newValue) {
                          formData['link'] = newValue;
                        },
                      ),
                      Gaps.v28,
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
  }
}
