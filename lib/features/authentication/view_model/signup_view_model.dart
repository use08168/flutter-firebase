import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:marketlyze_1/features/authentication/repository/authentication_repository.dart';
import 'package:marketlyze_1/features/main_screen.dart';
import 'package:marketlyze_1/features/user/view_model/users_view_model.dart';
import 'package:marketlyze_1/utils.dart';

class SignUpViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepository _authRepo;
  @override
  FutureOr<void> build() {
    _authRepo = ref.read(authRepo);
  }

  Future<void> signUp(BuildContext context) async {
    state = const AsyncValue.loading();
    final form = ref.read(signUpForm);
    final users = ref.read(usersProvider.notifier);
    state = await AsyncValue.guard(
      () async {
        final userCredential = await _authRepo.signUp(
          form["email"],
          form["password"],
        );
        await users.createProfile(
            credential: userCredential,
            username: form["username"],
            email: form["email"],
            birthday: form["birthday"]);
      },
    );
    if (state.hasError) {
      showFirebaseErrorSnack(context, state.error);
    } else {
      context.goNamed(MainScreen.routeName);
    }
  }
}

final signUpForm = StateProvider((ref) => {});

// ---------- 버튼 색으로 로딩중임을 표현할 떄 사용 ---------- //

final signUpProvider = AsyncNotifierProvider<SignUpViewModel, void>(
  () => SignUpViewModel(),
);
