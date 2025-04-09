import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:marketlyze_1/constants/gaps.dart';
import 'package:marketlyze_1/constants/sizes.dart';
import 'package:marketlyze_1/features/profile/follow/follow_friend.dart';
import 'package:marketlyze_1/features/widget/follower_widget/friend_persistent_tabbar_widget.dart';

class PublicProfile extends StatefulWidget {
  const PublicProfile({
    super.key,
    required this.snap,
  });
  final dynamic snap;

  @override
  State<PublicProfile> createState() => _PublicProfileState();
}

class _PublicProfileState extends State<PublicProfile> {
  void _goFolloweButton(
    int follower,
    int following,
    dynamic followers,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FollowFriend(
          follower: follower,
          following: following,
          followers: followers,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: DefaultTabController(
          length: 2,
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  title: Text("${widget.snap["username"]}"),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: Sizes.size36,
                          vertical: Sizes.size10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 40,
                              foregroundColor: Theme.of(context).primaryColor,
                              foregroundImage: widget.snap["hasAvatar"] == true
                                  ? NetworkImage(
                                      "https://firebasestorage.googleapis.com/v0/b/marketlyze.appspot.com/o/avatars%2F${widget.snap["uid"]}?alt=media&lol=${DateTime.now().toString()}",
                                    )
                                  : null,
                            ),
                            Gaps.h20,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${widget.snap["realname"]}",
                                  style: const TextStyle(
                                    fontSize: Sizes.size16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Gaps.v7,
                                Text(
                                  "${widget.snap["birthday"]}",
                                  style: const TextStyle(
                                    fontSize: Sizes.size16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Gaps.v20,
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(
                          vertical: Sizes.size16,
                          horizontal: Sizes.size24,
                        ),
                        margin: const EdgeInsets.symmetric(
                          horizontal: Sizes.size14,
                        ),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 224, 243, 255),
                          borderRadius: BorderRadius.circular(
                            Sizes.size12,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "${widget.snap["bio"]}",
                              style: const TextStyle(
                                fontSize: Sizes.size16,
                                fontWeight: FontWeight.w400,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Gaps.v10,
                            Text(
                              "${widget.snap["link"]}",
                              style: const TextStyle(
                                fontSize: Sizes.size16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Gaps.v36,
                      SizedBox(
                        height: Sizes.size48,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Gaps.v32,
                            SizedBox(
                              width: Sizes.size64,
                              child: Column(
                                children: [
                                  const Text(
                                    "Post",
                                    style: TextStyle(
                                      fontSize: Sizes.size16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Gaps.v5,
                                  Text(
                                    "${widget.snap["reviewIds"].length}",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              child: VerticalDivider(
                                width: Sizes.size72,
                                thickness: Sizes.size1,
                                color: Colors.black87,
                                indent: Sizes.size5,
                                endIndent: Sizes.size5,
                              ),
                            ),
                            GestureDetector(
                              onTap: () => _goFolloweButton(
                                widget.snap["follower"].length,
                                widget.snap["following"].length,
                                widget.snap["follower"],
                              ),
                              child: SizedBox(
                                width: Sizes.size64,
                                child: Column(
                                  children: [
                                    const Text(
                                      //"Follwer",
                                      "Friends",
                                      style: TextStyle(
                                        fontSize: Sizes.size16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Gaps.v5,
                                    Text(
                                      "${widget.snap["follower"].length}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Gaps.v32,
                          ],
                        ),
                      ),
                      Gaps.v20,
                    ],
                  ),
                ),
                SliverPersistentHeader(
                  delegate: FriendPersistentTabBarWidget(),
                  pinned: true,
                )
              ];
            },
            body: TabBarView(
              children: [
                widget.snap["reviewIds"].isEmpty
                    ? const Center(
                        child: Text("no post"),
                      )
                    : StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("reviews")
                            .where("createrUid", isEqualTo: widget.snap["uid"])
                            .snapshots(),
                        builder: (context,
                            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                                snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: Colors.black,
                              ),
                            );
                          }
                          return GridView.builder(
                            keyboardDismissBehavior:
                                ScrollViewKeyboardDismissBehavior.onDrag,
                            padding: const EdgeInsets.all(Sizes.size3),
                            itemCount: snapshot.data!.docs.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: Sizes.size3,
                              mainAxisSpacing: Sizes.size3,
                              childAspectRatio: 9 / 12,
                            ),
                            itemBuilder: (context, index) => Column(
                              children: [
                                AspectRatio(
                                  aspectRatio: 9 / 12,
                                  child: FadeInImage.assetNetwork(
                                    fit: BoxFit.cover,
                                    placeholderFit: BoxFit.cover,
                                    placeholder: 'assets/image/grey.png',
                                    image: snapshot.data!.docs[index]
                                        ["imageUrl"][0],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                widget.snap["likePost"].isEmpty
                    ? const Center(
                        child: Text("no likes"),
                      )
                    : StreamBuilder(
                        stream: (widget.snap["likePost"].isNotEmpty)
                            ? FirebaseFirestore.instance
                                .collection("reviews")
                                .where("reviewId",
                                    whereIn: widget.snap["likePost"])
                                .snapshots()
                            : null,
                        builder: (context,
                            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                                snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: Colors.black,
                              ),
                            );
                          }
                          return GridView.builder(
                            keyboardDismissBehavior:
                                ScrollViewKeyboardDismissBehavior.onDrag,
                            padding: const EdgeInsets.all(Sizes.size3),
                            itemCount: (widget.snap["likePost"].isNotEmpty)
                                ? snapshot.data!.docs.length
                                : 0,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: Sizes.size3,
                              mainAxisSpacing: Sizes.size3,
                              childAspectRatio: 9 / 12,
                            ),
                            itemBuilder: (context, index) => Column(
                              children: [
                                AspectRatio(
                                  aspectRatio: 9 / 12,
                                  child: FadeInImage.assetNetwork(
                                    fit: BoxFit.cover,
                                    placeholderFit: BoxFit.cover,
                                    placeholder: 'assets/image/grey.png',
                                    image: snapshot.data!.docs[index]
                                        ["imageUrl"][0],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ],
            ),
          ),
        ),
      );
}
