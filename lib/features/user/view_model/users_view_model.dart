import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marketlyze_1/features/authentication/repository/authentication_repository.dart';
import 'package:marketlyze_1/features/user/model/user_profile_models.dart';
import 'package:marketlyze_1/features/user/repository/user_repository.dart';

class UsersViewModel extends AsyncNotifier<UserProfileModel> {
  late final UserRepository _usersRepository;
  late final AuthenticationRepository _authenticationRepository;
  //late final PostRepository _postRepository;

  @override
  FutureOr<UserProfileModel> build() async {
    _usersRepository = ref.read(userRepo);

// -------- 로그인 가능한 회원의 정보를 통한 firebase 정보 수정 권한 요청 ---------- //

    _authenticationRepository = ref.read(authRepo);
    if (_authenticationRepository.isLoggedIn) {
      final profile = await _usersRepository
          .findProfile(_authenticationRepository.user!.uid);
      if (profile != null) {
        return UserProfileModel.fromJson(profile);
      }
    }
    return UserProfileModel.empty();
  }

  Future<void> createProfile({
    required UserCredential credential,
    required String username,
    required String email,
    required String birthday,
  }) async {
    if (credential.user == null) {
      throw Exception("Account not create");
    }
    state = const AsyncValue.loading();
    final profile = UserProfileModel(
      hasAvatar: false,
      bio: "Underfined bio",
      link: "Underfined link",
      follower: [],
      following: [],
      likePost: [],
      bookmark: [],
      reviewIds: [],
      chatRoomIds: [],
      realname: "Underfined realname",
      birthday: birthday,
      uid: credential.user!.uid,
      email: credential.user!.email ?? email,
      username: credential.user!.displayName ?? username,
    );
    await _usersRepository.createProfile(profile);
    state = AsyncValue.data(profile);
  }

  Future<void> onAvatarUpload() async {
    if (state.value == null) return;
    state = AsyncValue.data(state.value!.copyWith(hasAvatar: true));
    await _usersRepository.updateUser(state.value!.uid, {"hasAvatar": true});
  }

  Future<void> updateProfile({
    String? realname,
    String? username,
    String? bio,
    String? link,
  }) async {
    if (state.value == null) return;
    if (realname != null) {
      state = AsyncValue.data(state.value!.copyWith(realname: realname));
      await _usersRepository
          .updateUser(state.value!.uid, {"realname": realname});
    }
    if (username != null) {
      state = AsyncValue.data(state.value!.copyWith(username: username));
      await _usersRepository
          .updateUser(state.value!.uid, {"username": username});
    }
    if (bio != null) {
      state = AsyncValue.data(state.value!.copyWith(bio: bio));
      await _usersRepository.updateUser(state.value!.uid, {"bio": bio});
    }
    if (link != null) {
      state = AsyncValue.data(state.value!.copyWith(link: link));
      await _usersRepository.updateUser(state.value!.uid, {"link": link});
    }
  }

// ---------- firebase user에 bookmark를 넣고 제거하는 함수 ---------- //

  // Future<void> pressBookmarkIfNot(
  //     {List<String>? reviewId, String? uid, String? review}) async {
  //   if (review != null) {
  //     if (state.value != null) {
  //       state = AsyncValue.data(state.value!.copyWith(bookmark: reviewId));
  //       await _postRepository.updateBookmarkInUser(review, uid ?? "");
  //     }
  //   }
  // }

  // Future<void> pressBookmarkIfCancel(
  //     {List<String>? reviewId, String? uid, String? review}) async {
  //   if (review != null) {
  //     if (state.value != null) {
  //       state = AsyncValue.data(state.value!.copyWith(bookmark: reviewId));
  //       await _postRepository.removeBookmarkInUser(review, uid ?? "");
  //     }
  //   }
  // }
}

final usersProvider = AsyncNotifierProvider<UsersViewModel, UserProfileModel>(
  () => UsersViewModel(),
);
