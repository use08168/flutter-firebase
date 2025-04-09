import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marketlyze_1/features/text/make_chat_room/model/chat_room_text_model.dart';

class InsideChatRoomRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> sendText(String chatRoomId, ChatRoomTextModel data) async {
    await _db
        .collection("chatroom")
        .doc(chatRoomId)
        .collection("text")
        .add(data.toJson());
  }
}

final insideChatRoomRepo = Provider((ref) => InsideChatRoomRepository());
