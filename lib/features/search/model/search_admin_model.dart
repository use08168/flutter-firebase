class SearchAdminModel {
  final String title;
  final String content;
  final String uid;
  final String business;
  final String productName;
  final int selectedIndex;
  final List imageUrlForThumbnail;
  final List imageUrlForBanner;

  SearchAdminModel({
    required this.title,
    required this.content,
    required this.uid,
    required this.business,
    required this.productName,
    required this.selectedIndex,
    required this.imageUrlForThumbnail,
    required this.imageUrlForBanner,
  });

  SearchAdminModel.empty()
      : title = "",
        content = "",
        uid = "",
        business = "",
        productName = "",
        selectedIndex = 0,
        imageUrlForThumbnail = [],
        imageUrlForBanner = [];

  SearchAdminModel.fromJson(Map<String, dynamic> json)
      : title = json["title"] ?? "no title",
        content = json["content"] ?? "no content",
        uid = json["uid"] ?? "no uid",
        business = json["business"] ?? "no business",
        productName = json["productName"] ?? "no productName",
        selectedIndex = json["selectedIndex"] ?? 0,
        imageUrlForThumbnail = json["imageUrlForThumbnail"] ?? [],
        imageUrlForBanner = json["imageUrlForBanner"] ?? [];

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "content": content,
      "uid": uid,
      "business": business,
      "productName": productName,
      "selectedIndex": selectedIndex,
      "imageUrlForThumbnail": imageUrlForThumbnail,
      "imageUrlForBanner": imageUrlForBanner,
    };
  }

  SearchAdminModel copyWith({
    String? title,
    String? content,
    String? uid,
    String? business,
    String? productName,
    int? selectedIndex,
    List? imageUrlForThumbnail,
    List? imageUrlForBanner,
  }) {
    return SearchAdminModel(
      title: title ?? this.title,
      content: content ?? this.content,
      uid: uid ?? this.uid,
      business: business ?? this.business,
      productName: productName ?? this.productName,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      imageUrlForThumbnail: imageUrlForThumbnail ?? this.imageUrlForThumbnail,
      imageUrlForBanner: imageUrlForBanner ?? this.imageUrlForBanner,
    );
  }
}
