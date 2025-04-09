import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marketlyze_1/features/text/inside_chat_room/repository/inside_chat_room_repository.dart';
import 'package:marketlyze_1/features/text/make_chat_room/model/chat_room_text_model.dart';

class InsideChatRoomViewModel extends AsyncNotifier<void> {
  late final InsideChatRoomRepository _insideChatRoomRepository;

  @override
  FutureOr<void> build() {
    _insideChatRoomRepository = ref.read(insideChatRoomRepo);
  }

  Future<void> sendText({
    required String text,
    required String chatRoomId,
    required String uid,
    required String username,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () async {
        await _insideChatRoomRepository.sendText(
          chatRoomId,
          ChatRoomTextModel(
            userId: uid,
            username: username,
            text: text,
            time: DateTime.now(),
          ),
        );
      },
    );
  }
}

final insideChatRoomProvider =
    AsyncNotifierProvider<InsideChatRoomViewModel, void>(
  () => InsideChatRoomViewModel(),
);
