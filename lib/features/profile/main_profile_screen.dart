import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marketlyze_1/constants/gaps.dart';
import 'package:marketlyze_1/constants/sizes.dart';
import 'package:marketlyze_1/features/profile/edit/profile_editing_screen.dart';
import 'package:marketlyze_1/features/profile/follow/follow_friend.dart';
import 'package:marketlyze_1/features/profile/setting/main_setting_screen.dart';
import 'package:marketlyze_1/features/user/view_model/users_view_model.dart';
import 'package:marketlyze_1/features/widget/button_wiget/custom_button_widget.dart';
import 'package:marketlyze_1/features/widget/profile_widget/persistent_tabbar_widget.dart';

class MainProfileScreen extends ConsumerStatefulWidget {
  //static const routeURL = "/MainProfile";
  //static const routeName = "MainProfile";
  const MainProfileScreen({super.key});

  @override
  ConsumerState<MainProfileScreen> createState() => _MainProfileScreenState();
}

class _MainProfileScreenState extends ConsumerState<MainProfileScreen> {
  void _settingButton() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MainSettingScreen(),
      ),
    );
  }

  void _profileEditingButton(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ProfileEditingScreen(),
      ),
    );
  }

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
  Widget build(BuildContext context) {
    return ref.watch(usersProvider).when(
          error: (error, stackTrace) => Center(
            child: Text(
              error.toString(),
            ),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          ),
          data: (data) => DefaultTabController(
            length: 3,
            child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    title: Text(data.username),
                    actions: [
                      IconButton(
                        onPressed: _settingButton,
                        icon: const FaIcon(
                          FontAwesomeIcons.gear,
                          size: Sizes.size18,
                        ),
                      ),
                      Gaps.h8,
                    ],
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
                                foregroundImage: data.hasAvatar
                                    ? NetworkImage(
                                        "https://firebasestorage.googleapis.com/v0/b/marketlyze.appspot.com/o/avatars%2F${data.uid}?alt=media&lol=${DateTime.now().toString()}",
                                      )
                                    : null,
                              ),
                              Gaps.h20,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data.realname,
                                    style: const TextStyle(
                                      fontSize: Sizes.size16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Gaps.v7,
                                  Text(
                                    data.birthday,
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
                                data.bio,
                                style: const TextStyle(
                                  fontSize: Sizes.size16,
                                  fontWeight: FontWeight.w400,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Gaps.v10,
                              Text(
                                data.link,
                                style: const TextStyle(
                                  fontSize: Sizes.size16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Gaps.v16,
                        // TextBubbleWidget(
                        //   insideVerticalPadding: Sizes.size10,
                        //   insidehorizontalPadding: Sizes.size14,
                        //   outsidehorizontalMargin: Sizes.size16,
                        //   borderRadius: Sizes.size14,
                        //   text: data.bio,
                        // ),
                        // Gaps.v16,
                        // TextBubbleWidget(
                        //   insideVerticalPadding: Sizes.size10,
                        //   insidehorizontalPadding: Sizes.size14,
                        //   outsidehorizontalMargin: Sizes.size16,
                        //   borderRadius: Sizes.size14,
                        //   text: data.link,
                        // ),
                        // Gaps.v16,
                        // Container(
                        //   padding: const EdgeInsets.symmetric(
                        //     horizontal: Sizes.size56,
                        //   ),
                        //   child: Text(
                        //     data.bio,
                        //   ),
                        // ),
                        // Gaps.v16,
                        // Container(
                        //   padding: const EdgeInsets.symmetric(
                        //     horizontal: Sizes.size56,
                        //   ),
                        //   child: Text(
                        //     data.link,
                        //   ),
                        // ),
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
                                      "${data.reviewIds.length}",
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
                                  data.follower.length,
                                  data.following.length,
                                  data.follower,
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
                                        data.follower.length.toString(),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Gaps.v32,
                              // const VerticalDivider(
                              //   width: Sizes.size72,
                              //   thickness: Sizes.size1,
                              //   color: Colors.black87,
                              //   indent: Sizes.size5,
                              //   endIndent: Sizes.size5,
                              // ),
                              // GestureDetector(
                              //   onTap: () => _goFolloweButton(
                              //     data.follower.length,
                              //     data.following.length,
                              //     1,
                              //   ),
                              //   child: SizedBox(
                              //     width: Sizes.size64,
                              //     child: Column(
                              //       children: [
                              //         const Text(
                              //           "Follwing",
                              //           style: TextStyle(
                              //             fontSize: Sizes.size16,
                              //             fontWeight: FontWeight.w600,
                              //           ),
                              //         ),
                              //         Gaps.v5,
                              //         Text(
                              //           data.following.length.toString(),
                              //           style: const TextStyle(
                              //             fontWeight: FontWeight.w400,
                              //           ),
                              //         ),
                              //       ],
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        Gaps.v20,
                        CustomButtonWidget(
                          goFunction: _profileEditingButton,
                          text: "porofile edit",
                          verticalPadding: Sizes.size1,
                          horizontalMargin: Sizes.size10,
                          insideHeight: Sizes.size40,
                          radius: Sizes.size10,
                          borderColor: Colors.white,
                          textColor: Colors.grey.shade800,
                        ),
                        Gaps.v28,
                      ],
                    ),
                  ),
                  SliverPersistentHeader(
                    delegate: PersistentTabBarWidget(),
                    pinned: true,
                  ),
                ];
              },
              body: TabBarView(
                children: [
                  data.reviewIds.isEmpty
                      ? const Center(
                          child: Text("no post"),
                        )
                      : StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection("reviews")
                              .where("createrUid", isEqualTo: data.uid)
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
                  data.likePost.isEmpty
                      ? const Center(
                          child: Text("no likes"),
                        )
                      : StreamBuilder(
                          stream: (data.likePost.isNotEmpty)
                              ? FirebaseFirestore.instance
                                  .collection("reviews")
                                  .where("reviewId", whereIn: data.likePost)
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
                              itemCount: (data.likePost.isNotEmpty)
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
                  data.bookmark.isEmpty
                      ? const Center(
                          child: Text("no bookmark"),
                        )
                      : StreamBuilder(
                          stream: (data.bookmark.isNotEmpty)
                              ? FirebaseFirestore.instance
                                  .collection("reviews")
                                  .where("reviewId", whereIn: data.bookmark)
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
                              itemCount: (data.bookmark.isNotEmpty)
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
}
