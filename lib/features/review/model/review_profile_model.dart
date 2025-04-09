class ReviewProfileModel {
  final String title;
  final String content;
  final String createrUid;
  final String creater;
  final String reviewId;
  final List likes;
  final List bookmarker;
  final List imageUrl;
  final int selectedIndex;
  final double ratingTo1;
  final double ratingTo2;
  final double ratingTo3;
  final double ratingTo4;
  final double ratingTo5;

  ReviewProfileModel({
    required this.title,
    required this.content,
    required this.createrUid,
    required this.creater,
    required this.reviewId,
    required this.likes,
    required this.bookmarker,
    required this.imageUrl,
    required this.selectedIndex,
    required this.ratingTo1,
    required this.ratingTo2,
    required this.ratingTo3,
    required this.ratingTo4,
    required this.ratingTo5,
  });

  ReviewProfileModel.empty()
      : title = "",
        content = "",
        createrUid = "",
        creater = "",
        reviewId = "",
        likes = [],
        bookmarker = [],
        imageUrl = [],
        selectedIndex = 0,
        ratingTo1 = 0.0,
        ratingTo2 = 0.0,
        ratingTo3 = 0.0,
        ratingTo4 = 0.0,
        ratingTo5 = 0.0;

  ReviewProfileModel.fromJson(Map<String, dynamic> json)
      : title = json["title"] ?? "no title",
        content = json["content"] ?? "no content",
        createrUid = json["createrUid"] ?? "no creater uid",
        creater = json["creater"] ?? "no creater",
        reviewId = json["reviewId"] ?? "no reviewId",
        likes = json["likes"] ?? [],
        bookmarker = json["bookmarker"] ?? [],
        imageUrl = json["imageUrl"] ?? [],
        selectedIndex = json["selectedIndex"] ?? 0,
        ratingTo1 = json["ratingTo1"] ?? 0.0,
        ratingTo2 = json["ratingTo2"] ?? 0.0,
        ratingTo3 = json["ratingTo3"] ?? 0.0,
        ratingTo4 = json["ratingTo4"] ?? 0.0,
        ratingTo5 = json["ratingTo5"] ?? 0.0;

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "content": content,
      "createrUid": createrUid,
      "creater": creater,
      "reviewId": reviewId,
      "likes": likes,
      "bookmarker": bookmarker,
      "imageUrl": imageUrl,
      "selectedIndex": selectedIndex,
      "ratingTo1": ratingTo1,
      "ratingTo2": ratingTo2,
      "ratingTo3": ratingTo3,
      "ratingTo4": ratingTo4,
      "ratingTo5": ratingTo5,
    };
  }

  ReviewProfileModel copyWith({
    String? title,
    String? content,
    String? createrUid,
    String? creater,
    String? reviewId,
    List? likes,
    List? bookmarker,
    List? imageUrl,
    int? selectedIndex,
    double? ratingTo1,
    double? ratingTo2,
    double? ratingTo3,
    double? ratingTo4,
    double? ratingTo5,
  }) {
    return ReviewProfileModel(
      title: title ?? this.title,
      content: content ?? this.content,
      createrUid: createrUid ?? this.createrUid,
      creater: creater ?? this.creater,
      reviewId: reviewId ?? this.reviewId,
      likes: likes ?? this.likes,
      bookmarker: bookmarker ?? this.bookmarker,
      imageUrl: imageUrl ?? this.imageUrl,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      ratingTo1: ratingTo1 ?? this.ratingTo1,
      ratingTo2: ratingTo2 ?? this.ratingTo2,
      ratingTo3: ratingTo3 ?? this.ratingTo3,
      ratingTo4: ratingTo4 ?? this.ratingTo4,
      ratingTo5: ratingTo5 ?? this.ratingTo5,
    );
  }
}
