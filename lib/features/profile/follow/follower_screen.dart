import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marketlyze_1/constants/sizes.dart';
import 'package:marketlyze_1/features/widget/follower_widget/public_profile.dart';

class FollowerScreen extends ConsumerStatefulWidget {
  const FollowerScreen({
    super.key,
    required this.followers,
  });
  final dynamic followers;

  @override
  ConsumerState<FollowerScreen> createState() => _FollowerScreenState();
}

class _FollowerScreenState extends ConsumerState<FollowerScreen> {
  void _goFriendProfile(snap) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PublicProfile(
          snap: snap,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: widget.followers.isNotEmpty
            ? FirebaseFirestore.instance
                .collection("users")
                .where("uid", whereIn: widget.followers)
                .snapshots()
            : null,
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          }
          return widget.followers.length == 0
              ? const Center(
                  child: Text("No follower"),
                )
              : ListView.builder(
                  itemCount: widget.followers.length != 0
                      ? snapshot.data!.docs.length
                      : 0,
                  itemBuilder: (context, index) => Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: Sizes.size5,
                      horizontal: Sizes.size8,
                    ),
                    child: ListTile(
                      onTap: () => _goFriendProfile(
                        snapshot.data!.docs[index],
                      ),
                      tileColor: Colors.grey.shade200,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: Sizes.size5,
                        horizontal: Sizes.size10,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(Sizes.size10),
                      ),
                      leading: CircleAvatar(
                        radius: 35,
                        foregroundColor: Theme.of(context).primaryColor,
                        foregroundImage:
                            snapshot.data!.docs[index]["hasAvatar"] == true
                                ? NetworkImage(
                                    "https://firebasestorage.googleapis.com/v0/b/marketlyze.appspot.com/o/avatars%2F${snapshot.data!.docs[index]["uid"]}?alt=media&lol=${DateTime.now().toString()}",
                                  )
                                : null,
                      ),
                      title: Text(
                        "${snapshot.data!.docs[index]["username"]}",
                        style: const TextStyle(
                          fontSize: Sizes.size18,
                        ),
                      ),
                      subtitle:
                          Text("${snapshot.data!.docs[index]["realname"]}"),
                    ),
                  ),
                );
        },
      ),
    );
  }
}
