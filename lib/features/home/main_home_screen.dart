import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marketlyze_1/constants/gaps.dart';
import 'package:marketlyze_1/constants/sizes.dart';
import 'package:marketlyze_1/features/text/main_text_screen.dart';
import 'package:marketlyze_1/features/user/view_model/users_view_model.dart';
import 'package:marketlyze_1/features/widget/post_wiget/main_post_widget.dart';

class MainHomeScreen extends ConsumerStatefulWidget {
  //static const routeURL = "/MainHomeScreen";
  //static const routeName = "MainHomeScreen";

  const MainHomeScreen({super.key});

  @override
  ConsumerState<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends ConsumerState<MainHomeScreen> {
  void _tapTextScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const MainTextScreen(),
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
          data: (data) => Scaffold(
            appBar: AppBar(
              title: Image.asset(
                "assets/image/logo.png",
                height: Sizes.size16,
              ),
              actions: [
                IconButton(
                  onPressed: () => _tapTextScreen(context),
                  icon: const FaIcon(
                    FontAwesomeIcons.paperPlane,
                    size: Sizes.size20,
                  ),
                ),
                Gaps.h8,
              ],
            ),
            body: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("reviews")
                  .where("createrUid", isEqualTo: data.uid)
                  .snapshots(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) => Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: Sizes.size5,
                      horizontal: Sizes.size8,
                    ),
                    child: MainPostWidget(
                      snap: snapshot.data!.docs[index].data(),
                      uidData: data.uid,
                      uid: data.uid,
                      avatar: data.hasAvatar,
                    ),
                  ),
                );
              },
            ),
          ),
        );
  }
}
