import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marketlyze_1/features/text/make_chat_room/model/build_chat_room_model.dart';
import 'package:marketlyze_1/features/text/make_chat_room/model/chat_room_text_model.dart';

class BuildChatRoomRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<Map<String, dynamic>?> findProfile(String uid) async {
    final doc = await _db.collection("users").doc(uid).get();
    return doc.data();
  }

  Future<String> createChatRoom(BuildChatRoomModel chatData) async {
    final documentReference =
        await _db.collection("chatroom").add(chatData.toJson());
    final chatRoomId = documentReference.id;
    return chatRoomId;
  }

  Future<void> createChatRoomText(
      String chatRoomId, ChatRoomTextModel chatData) async {
    await _db
        .collection("chatroom")
        .doc(chatRoomId)
        .collection("text")
        .add(chatData.toJson());
  }

  // ---------- firebase에 chatRoomId 업데이트 하는 함수 ---------- //

  Future<void> updateChatRoomId(String chatRoomId) async {
    await _db
        .collection("chatroom")
        .doc(chatRoomId)
        .update({"chatRoomId": chatRoomId});
  }

  Future<void> updateChatRoomIdForUserProfile(
    List<String> uidList,
    String chatRoomId,
  ) async {
    final batchUpdate = FirebaseFirestore.instance.batch();

    for (String uid in uidList) {
      // 현재 사용자의 chatRoomIds 필드에 chatRoomId를 추가합니다.
      final userRef = FirebaseFirestore.instance.collection("users").doc(uid);
      batchUpdate.update(userRef, {
        "chatRoomIds": FieldValue.arrayUnion([chatRoomId]),
      });
    }

    // 일괄 업데이트를 실행합니다.
    await batchUpdate.commit();
  }
}

final buildChatRoomRepo = Provider((ref) => BuildChatRoomRepository());
