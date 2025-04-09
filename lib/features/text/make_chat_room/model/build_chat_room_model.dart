class BuildChatRoomModel {
  final String chatRoomName;
  final String chatRoomId;
  final List chatRoomUserId;
  final List chatRoomUsername;

  BuildChatRoomModel({
    required this.chatRoomName,
    required this.chatRoomId,
    required this.chatRoomUserId,
    required this.chatRoomUsername,
  });

  BuildChatRoomModel.empty()
      : chatRoomName = "",
        chatRoomId = "",
        chatRoomUserId = [],
        chatRoomUsername = [];

  BuildChatRoomModel.fromJson(Map<String, dynamic> json)
      : chatRoomName = json["chatRoomName"] ?? "no room name",
        chatRoomId = json["chatRoomId"] ?? "no room id",
        chatRoomUserId = json["chatRoomUserId"] ?? [],
        chatRoomUsername = json["chatRoomUsername"] ?? [];

  Map<String, dynamic> toJson() {
    return {
      "chatRoomName": chatRoomName,
      "chatRoomId": chatRoomId,
      "chatRoomUserId": chatRoomUserId,
      "chatRoomUsername": chatRoomUsername,
    };
  }

  BuildChatRoomModel copyWith({
    String? chatRoomName,
    String? chatRoomId,
    List? chatRoomUserId,
    List? chatRoomUsername,
  }) {
    return BuildChatRoomModel(
      chatRoomName: chatRoomName ?? this.chatRoomName,
      chatRoomId: chatRoomId ?? this.chatRoomId,
      chatRoomUserId: chatRoomUserId ?? this.chatRoomUserId,
      chatRoomUsername: chatRoomUsername ?? this.chatRoomUsername,
    );
  }
}
