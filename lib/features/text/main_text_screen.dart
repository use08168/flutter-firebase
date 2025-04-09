import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marketlyze_1/constants/gaps.dart';
import 'package:marketlyze_1/constants/sizes.dart';
import 'package:marketlyze_1/features/text/inside_chat_room/inside_chat_room.dart';
import 'package:marketlyze_1/features/text/make_chat_room/chat_room_maker.dart';
import 'package:marketlyze_1/features/user/view_model/users_view_model.dart';

class MainTextScreen extends ConsumerStatefulWidget {
  const MainTextScreen({super.key});

  @override
  ConsumerState<MainTextScreen> createState() => _MainTextScreenState();
}

class _MainTextScreenState extends ConsumerState<MainTextScreen> {
  void _makeChatRoom() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const ChatRoomMaker(),
      ),
    );
  }

  void _goChatRoom(snap) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => InsideChatRoom(snap: snap),
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
          data: (data) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("Message"),
                leading: IconButton(
                  onPressed: Navigator.of(context).pop,
                  icon: const FaIcon(
                    FontAwesomeIcons.angleLeft,
                    size: Sizes.size20,
                  ),
                ),
                actions: [
                  IconButton(
                    onPressed: _makeChatRoom,
                    icon: const FaIcon(
                      FontAwesomeIcons.plus,
                      size: Sizes.size20,
                    ),
                  ),
                ],
              ),
              body: StreamBuilder(
                stream: data.chatRoomIds.isEmpty
                    ? null
                    : FirebaseFirestore.instance
                        .collection("chatroom")
                        .where("chatRoomId", whereIn: data.chatRoomIds)
                        .snapshots(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.black,
                      ),
                    );
                  }
                  return data.chatRoomIds.isEmpty
                      ? const Center(
                          child: Text("No chatroom"),
                        )
                      : ListView.separated(
                          separatorBuilder: (context, index) => Gaps.v10,
                          padding: const EdgeInsets.only(
                            left: Sizes.size10,
                            right: Sizes.size10,
                            top: Sizes.size10,
                          ),
                          itemCount: data.chatRoomIds.isNotEmpty
                              ? data.chatRoomIds.length
                              : 0,
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () =>
                                  _goChatRoom(snapshot.data!.docs[index]),
                              tileColor: Colors.grey.shade100,
                              contentPadding: const EdgeInsets.only(
                                left: Sizes.size10,
                                right: Sizes.size24,
                              ),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Colors.grey.shade200,
                                  width: Sizes.size1,
                                ),
                                borderRadius:
                                    BorderRadius.circular(Sizes.size10),
                              ),
                              title: Text(
                                "${snapshot.data!.docs[index]["chatRoomName"]}",
                                style: const TextStyle(
                                  fontSize: Sizes.size18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                              subtitle: Text(
                                "${snapshot.data!.docs[index]["chatRoomUsername"].join(', ')}",
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            );
                          },
                        );
                },
              ),
            );
          },
        );
  }
}
