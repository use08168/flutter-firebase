class UserProfileModel {
  final String uid;
  final String email;
  final String realname;
  final String username;
  final String bio;
  final String link;
  final String birthday;
  final List follower;
  final List following;
  final List likePost;
  final List bookmark;
  final List reviewIds;
  final List chatRoomIds;
  final bool hasAvatar;

  UserProfileModel({
    required this.uid,
    required this.email,
    required this.realname,
    required this.username,
    required this.bio,
    required this.link,
    required this.birthday,
    required this.follower,
    required this.following,
    required this.likePost,
    required this.bookmark,
    required this.reviewIds,
    required this.chatRoomIds,
    required this.hasAvatar,
  });

  UserProfileModel.empty()
      : uid = "",
        email = "",
        realname = "",
        username = "",
        bio = "",
        link = "",
        birthday = "",
        follower = [],
        following = [],
        likePost = [],
        bookmark = [],
        reviewIds = [],
        chatRoomIds = [],
        hasAvatar = false;

  UserProfileModel.fromJson(Map<String, dynamic> json)
      : uid = json["uid"],
        email = json["email"],
        realname = json["realname"],
        username = json["username"],
        bio = json["bio"],
        link = json["link"],
        birthday = json["birthday"],
        follower = json["follower"],
        following = json["following"],
        likePost = json["likePost"],
        bookmark = json["bookmark"],
        reviewIds = json["reviewIds"] ?? "",
        chatRoomIds = json["chatRoomIds"] ?? "",
        hasAvatar = json["hasAvatar"] ?? false;

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "email": email,
      "realname": realname,
      "username": username,
      "bio": bio,
      "link": link,
      "birthday": birthday,
      "follower": follower,
      "following": following,
      "likePost": likePost,
      "bookmark": bookmark,
      "reviewIds": reviewIds,
      "chatRoomIds": chatRoomIds,
    };
  }

  UserProfileModel copyWith({
    String? uid,
    String? email,
    String? realname,
    String? username,
    String? bio,
    String? link,
    String? birthday,
    List? follower,
    List? following,
    List? likePost,
    List? bookmark,
    List? reviewIds,
    List? chatRoomIds,
    bool? hasAvatar,
  }) {
    return UserProfileModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      realname: realname ?? this.realname,
      username: username ?? this.username,
      bio: bio ?? this.bio,
      link: link ?? this.link,
      birthday: birthday ?? this.birthday,
      follower: follower ?? this.follower,
      following: following ?? this.following,
      likePost: likePost ?? this.likePost,
      bookmark: bookmark ?? this.bookmark,
      reviewIds: reviewIds ?? this.reviewIds,
      chatRoomIds: chatRoomIds ?? this.chatRoomIds,
      hasAvatar: hasAvatar ?? this.hasAvatar,
    );
  }
}
