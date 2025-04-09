import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marketlyze_1/features/authentication/repository/authentication_repository.dart';
import 'package:marketlyze_1/features/text/make_chat_room/model/build_chat_room_model.dart';
import 'package:marketlyze_1/features/text/make_chat_room/model/chat_room_text_model.dart';
import 'package:marketlyze_1/features/text/make_chat_room/repository/build_chat_room_repository.dart';
import 'package:marketlyze_1/features/user/view_model/users_view_model.dart';

class BuildChatRoomViewModel extends AsyncNotifier<BuildChatRoomModel> {
  late final BuildChatRoomRepository _buildChatRoomRepository;

  @override
  FutureOr<BuildChatRoomModel> build() async {
    _buildChatRoomRepository = ref.read(buildChatRoomRepo);

    final authenticationRepository = ref.read(authRepo);
    if (authenticationRepository.isLoggedIn) {
      final profile = await _buildChatRoomRepository
          .findProfile(authenticationRepository.user!.uid);
      if (profile != null) {
        return BuildChatRoomModel.fromJson(profile);
      }
    }
    return BuildChatRoomModel.empty();
  }

  Future<void> createChatroom({
    required List<String> userId,
    required List<String> username,
    required String chatRoomName,
    required String createrUid,
    required String createrName,
  }) async {
    state = const AsyncValue.loading();
    final userProfile = ref.read(usersProvider).value;
    if (userProfile == null) {
      return;
    }
    final chatRoomUsersId = [...userId, createrUid];
    final chatRoomUsersname = [...username, createrName];
    final chatRoomId = await _buildChatRoomRepository.createChatRoom(
      BuildChatRoomModel(
        chatRoomName: chatRoomName,
        chatRoomId: "",
        chatRoomUserId: chatRoomUsersId,
        chatRoomUsername: chatRoomUsersname,
      ),
    );
    await _buildChatRoomRepository.updateChatRoomId(chatRoomId);
    await _buildChatRoomRepository.updateChatRoomIdForUserProfile(
        chatRoomUsersId, chatRoomId);
    await _buildChatRoomRepository.createChatRoomText(
      chatRoomId,
      ChatRoomTextModel(
        userId: "",
        username: "",
        text: "",
        time: DateTime.now(),
      ),
    );
  }
}

final buildChatRoomProvider =
    AsyncNotifierProvider<BuildChatRoomViewModel, BuildChatRoomModel>(
  () => BuildChatRoomViewModel(),
);
