import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:marketlyze_1/constants/sizes.dart';

class MainOtherScreen extends StatefulWidget {
  //static const routeURL = "/MainOther";
  //static const routeName = "MainOther";
  const MainOtherScreen({super.key});

  @override
  State<MainOtherScreen> createState() => _MainOtherScreenState();
}

class _MainOtherScreenState extends State<MainOtherScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("main Other"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("chatroom")
            .where("zirNvED5YR5Hsb9F0w0e")
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
                vertical: Sizes.size10,
                horizontal: Sizes.size10,
              ),
              child: const Column(
                children: [
                  // Text(
                  //   "${snapshot.data!.docs[index]["imageUrl"].length}",
                  // ),
                  // Text(
                  //   "${snapshot.data!.docs[index]["likes"].length}",
                  // ),
                  // Text(
                  //   "${snapshot.data!.docs[index]["likes"]}",
                  // ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
