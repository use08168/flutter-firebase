class ChatRoomTextModel {
  final String userId;
  final String username;
  final String text;
  final DateTime time;

  ChatRoomTextModel({
    required this.userId,
    required this.username,
    required this.text,
    required this.time,
  });

  ChatRoomTextModel.empty()
      : userId = "",
        username = "",
        text = "",
        time = DateTime.now();

  ChatRoomTextModel.fromJson(Map<String, dynamic> json)
      : userId = json["userId"] ?? "no userId",
        username = json["username"] ?? "no username",
        text = json["text"] ?? "no text",
        time = json["time"] ?? DateTime.now();

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "username": username,
      "text": text,
      "time": time,
    };
  }

  ChatRoomTextModel copyWith({
    String? userId,
    String? username,
    String? text,
    DateTime? time,
  }) {
    return ChatRoomTextModel(
      userId: userId ?? this.userId,
      username: username ?? this.username,
      text: text ?? this.text,
      time: time ?? this.time,
    );
  }
}
