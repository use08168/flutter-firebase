import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marketlyze_1/constants/gaps.dart';
import 'package:marketlyze_1/constants/sizes.dart';
import 'package:marketlyze_1/features/home/main_home_screen.dart';
import 'package:marketlyze_1/features/home/repository/post_repository.dart';
import 'package:marketlyze_1/features/home/view_model/post_view_model.dart';
import 'package:marketlyze_1/features/search/search_category/main_9_health_screen.dart';
import 'package:marketlyze_1/features/search/search_category/main_10_office_screen.dart';
import 'package:marketlyze_1/features/search/search_category/main_0_food_screen.dart';
import 'package:marketlyze_1/features/search/search_category/main_1_cloth_screen.dart';
import 'package:marketlyze_1/features/search/search_category/main_2_toy_screen.dart';
import 'package:marketlyze_1/features/search/search_category/main_3_sport_screen.dart';
import 'package:marketlyze_1/features/search/search_category/main_4_pet_screen.dart';
import 'package:marketlyze_1/features/search/search_category/main_6_daily_screen.dart';
import 'package:marketlyze_1/features/search/search_category/main_7_baby_screen.dart';
import 'package:marketlyze_1/features/search/search_category/main_8_book_screen.dart';
import 'package:marketlyze_1/features/widget/post_wiget/post_comments_widget.dart';
import 'package:marketlyze_1/features/widget/post_wiget/post_more_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MainPostWidget extends ConsumerStatefulWidget {
  final dynamic snap;
  final dynamic uidData;
  final String uid;
  final bool avatar;

  const MainPostWidget({
    super.key,
    required this.snap,
    required this.uidData,
    required this.uid,
    required this.avatar,
  });

  @override
  ConsumerState<MainPostWidget> createState() => _MainPostWidgetState();
}

class _MainPostWidgetState extends ConsumerState<MainPostWidget> {
  int activeindex = 0;
  List<FaIcon> selectedIcon = [
    const FaIcon(FontAwesomeIcons.utensils),
    const FaIcon(FontAwesomeIcons.shirt),
    const FaIcon(FontAwesomeIcons.shapes),
    const FaIcon(FontAwesomeIcons.basketball),
    const FaIcon(FontAwesomeIcons.paw),
    const FaIcon(FontAwesomeIcons.couch),
    const FaIcon(FontAwesomeIcons.jugDetergent),
    const FaIcon(FontAwesomeIcons.babyCarriage),
    const FaIcon(FontAwesomeIcons.book),
    const FaIcon(FontAwesomeIcons.heartPulse),
    const FaIcon(FontAwesomeIcons.pen),
  ];

  List<Widget> selectedWidget = [
    const MainFoodScreen(),
    const MainClothScreen(),
    const MainToyScreen(),
    const MainSportScreen(),
    const MainPetScreen(),
    const MainHomeScreen(),
    const MainDailyScreen(),
    const MainBabyScreen(),
    const MainBookScreen(),
    const MainHealthScreen(),
    const MainOfficeScreen(),
  ];

  List<String> liker = [];
  List<String> booker = [];

  @override
  void initState() {
    super.initState();
    liker = [widget.uidData];
    booker = [widget.uidData];
  }

  void _likeFunction() {
    final postLiker = widget.snap["likes"];
    final userId = widget.uid;
    final containsUserId = postLiker.contains(userId);

    if (!containsUserId) {
      ref.read(likeProvider.notifier).pressLikeIfNoUid(
            uid: widget.uid,
            reviewId: widget.snap["reviewId"],
            liker: liker,
          );
    } else {
      ref.read(likeProvider.notifier).pressLikeIfHaveUid(
            uid: widget.uid,
            reviewId: widget.snap["reviewId"],
            liker: liker,
          );
    }
    setState(() {});
  }

  void _bookmarkFunction() {
    final bookmarker = widget.snap["bookmarker"];
    final userId = widget.uid;
    final containBookmark = bookmarker.contains(userId);

    if (!containBookmark) {
      // ref.read(likeProvider.notifier).addBookmarkPress(
      //       uid: widget.uid,
      //       reviewId: widget.snap["reviewId"],
      //     );
      ref.read(postRepo).updateBookmarkInUser(
            widget.snap["reviewId"],
            userId,
          );
      ref.read(postRepo).updateBookmarkInReview(
            widget.snap["reviewId"],
            userId,
          );
    } else {
      // ref.read(likeProvider.notifier).removeBookmarkPress(
      //       uid: widget.uid,
      //       reviewId: widget.snap["reviewId"],
      //     );
      ref.read(postRepo).removeBookmarkInUser(
            widget.snap["reviewId"],
            userId,
          );
      ref.read(postRepo).removeBookmarkInReview(
            widget.snap["reviewId"],
            userId,
          );
    }
    setState(() {});
  }

  void _goSelectedWidget(selected) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => selectedWidget[selected],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(
          Sizes.size5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size10,
          vertical: Sizes.size8,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size5,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        foregroundColor: Theme.of(context).primaryColor,
                        foregroundImage: widget.avatar == true
                            ? NetworkImage(
                                "https://firebasestorage.googleapis.com/v0/b/marketlyze.appspot.com/o/avatars%2F${widget.snap["createrUid"]}?alt=media&lol=${DateTime.now().toString()}",
                              )
                            : null,
                      ),
                      Gaps.h10,
                      Text(
                        widget.snap?["creater"] ?? "",
                        style: const TextStyle(
                          fontSize: Sizes.size20,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => _goSelectedWidget(
                      widget.snap?["selectedIndex"],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        right: Sizes.size5,
                      ),
                      child: FaIcon(
                        selectedIcon[widget.snap?["selectedIndex"]].icon,
                        color: Colors.black54,
                        size: Sizes.size19,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Gaps.v5,
            Column(
              children: [
                CarouselSlider.builder(
                  options: CarouselOptions(
                    height: 480,
                    aspectRatio: 9 / 12,
                    viewportFraction: 1,
                    enableInfiniteScroll: false,
                    onPageChanged: (index, reason) {
                      setState(() {
                        activeindex = index;
                      });
                    },
                  ),
                  itemCount: widget.snap["imageUrl"].length,
                  itemBuilder: (context, index, realIndex) {
                    final urlImage = widget.snap["imageUrl"][index].toString();
                    return buildImage(urlImage, index);
                  },
                ),
              ],
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Sizes.size44,
                      width: Sizes.size44,
                      child: IconButton(
                        onPressed: _likeFunction,
                        icon: widget.snap["likes"].contains(widget.uid)
                            ? const FaIcon(
                                FontAwesomeIcons.solidHeart,
                                size: Sizes.size28,
                                color: Colors.redAccent,
                              )
                            : const FaIcon(
                                FontAwesomeIcons.heart,
                                size: Sizes.size28,
                              ),
                      ),
                    ),
                    SizedBox(
                      height: Sizes.size44,
                      width: Sizes.size44,
                      child: IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(
                                  Sizes.size7,
                                ),
                              ),
                            ),
                            backgroundColor: Colors.white,
                            context: context,
                            builder: (BuildContext context) {
                              return PostCommentsWidget(
                                snap: widget.snap,
                              );
                            },
                          );
                        },
                        icon: const Icon(
                          Icons.chat_bubble_outline_rounded,
                          size: Sizes.size28,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Sizes.size44,
                      width: Sizes.size44,
                      child: IconButton(
                        onPressed: () {},
                        icon: const FaIcon(
                          FontAwesomeIcons.paperPlane,
                          size: Sizes.size24,
                        ),
                      ),
                    ),
                  ],
                ),
                buildIndicator(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: Sizes.size44,
                      width: Sizes.size44,
                      child: IconButton(
                        onPressed: _bookmarkFunction,
                        icon: widget.snap["bookmarker"].contains(widget.uid)
                            ? FaIcon(
                                FontAwesomeIcons.solidBookmark,
                                color: Theme.of(context).primaryColor,
                              )
                            : const FaIcon(
                                FontAwesomeIcons.bookmark,
                              ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Text(
              "likes ${widget.snap["likes"].length}",
              style: const TextStyle(
                fontSize: Sizes.size18,
              ),
            ),
            Text(widget.snap?["title"] ?? ""),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.snap?["content"] ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Gaps.h44,
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(
                            Sizes.size7,
                          ),
                        ),
                      ),
                      backgroundColor: Colors.white,
                      context: context,
                      builder: (BuildContext context) {
                        return PostMoreWidget(
                          snap: widget.snap,
                        );
                      },
                    );
                  },
                  child: const Text("More"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildImage(String urlImage, int index) => Container(
        margin: const EdgeInsets.symmetric(
          horizontal: Sizes.size3,
        ),
        color: Colors.grey,
        child: Image.network(
          urlImage,
        ),
      );

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeindex,
        count: widget.snap["imageUrl"].length,
        effect: ScrollingDotsEffect(
          dotHeight: Sizes.size8,
          dotWidth: Sizes.size8,
          activeDotColor: Theme.of(context).primaryColor,
          activeDotScale: 1.2,
          spacing: Sizes.size5,
        ),
      );
}
