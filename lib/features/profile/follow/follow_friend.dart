import 'package:flutter/material.dart';
import 'package:marketlyze_1/features/profile/follow/follower_screen.dart';
import 'package:marketlyze_1/features/profile/follow/following_screen.dart';

class FollowFriend extends StatefulWidget {
  const FollowFriend({
    super.key,
    required this.follower,
    required this.following,
    required this.followers,
  });

  final int follower;
  final int following;
  final dynamic followers;

  @override
  State<FollowFriend> createState() => _FollowFriendState();
}

class _FollowFriendState extends State<FollowFriend> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: DefaultTabController(
          length: 2,
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  pinned: true,
                  floating: true,
                  title: const Text("Friends"),
                  bottom: TabBar(
                    tabs: [
                      Tab(
                        text: "Follower ${widget.follower}",
                      ),
                      Tab(
                        text: "Following ${widget.following}",
                      ),
                    ],
                  ),
                ),
              ];
            },
            body: TabBarView(
              children: [
                FollowerScreen(followers: widget.followers),
                const FollowingScreen(),
              ],
            ),
          ),
        ),
      );
}
