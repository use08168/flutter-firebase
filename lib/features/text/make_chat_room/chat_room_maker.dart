import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marketlyze_1/constants/gaps.dart';
import 'package:marketlyze_1/constants/sizes.dart';
import 'package:marketlyze_1/features/text/make_chat_room/view_model/build_chat_room_view_model.dart';
import 'package:marketlyze_1/features/user/view_model/users_view_model.dart';
import 'package:marketlyze_1/features/widget/button_wiget/custom_button_widget.dart';

class ChatRoomMaker extends ConsumerStatefulWidget {
  const ChatRoomMaker({super.key});

  @override
  ConsumerState<ChatRoomMaker> createState() => _ChatRoomMakerState();
}

class _ChatRoomMakerState extends ConsumerState<ChatRoomMaker> {
  List<String> selectUserId = [];
  List<String> selectUsername = [];

  void _isSelected(dynamic data) {
    final uid = data["uid"];
    final username = data["username"];
    setState(() {
      // 사용자 UID가 이미 선택되어 있는지 확인
      final isSelected = selectUserId.contains(uid);
      if (isSelected) {
        // 이미 선택된 경우, 사용자 UID를 리스트에서 제거
        selectUserId.remove(uid);
        selectUsername.remove(username);
      } else {
        // 선택되지 않은 경우, 사용자 UID를 리스트에 추가
        selectUserId.add(uid);
        selectUsername.add(username);
      }
    });

    //print(selectUserId); // 선택한 사용자의 UID 목록 출력
    //print(selectUsername);
  }

  void _makeChatRoom(String createrUid, String createrName) {
    ref.read(buildChatRoomProvider.notifier).createChatroom(
          chatRoomName: "test",
          userId: selectUserId,
          username: selectUsername,
          createrUid: createrUid,
          createrName: createrName,
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
                title: const Text("Create new message"),
                leading: IconButton(
                  onPressed: Navigator.of(context).pop,
                  icon: const FaIcon(
                    FontAwesomeIcons.angleLeft,
                    size: Sizes.size20,
                  ),
                ),
              ),
              body: Column(
                children: [
                  Gaps.v10,
                  SizedBox(
                    height: Sizes.size52,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        // 수정: Row로 감싸기
                        children: List.generate(
                          selectUserId.length,
                          (index) {
                            return Container(
                              height: Sizes.size48,
                              margin: const EdgeInsets.only(
                                left: Sizes.size10,
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: Sizes.size20,
                                vertical: Sizes.size10,
                              ),
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(
                                    Sizes.size20,
                                  ),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blueGrey.shade100,
                                    blurRadius: 5,
                                    spreadRadius: 0.1,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  selectUsername[index],
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: Sizes.size18,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Gaps.v10,
                  Expanded(
                    child: StreamBuilder(
                      stream: data.follower.isNotEmpty
                          ? FirebaseFirestore.instance
                              .collection("users")
                              .where("uid", whereIn: data.follower)
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
                        return data.follower.isEmpty
                            ? const Center(
                                child: Text("No follower"),
                              )
                            : ListView.separated(
                                separatorBuilder: (context, index) => Gaps.v10,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: Sizes.size10,
                                ),
                                itemCount: data.follower.isNotEmpty
                                    ? data.follower.length
                                    : 0,
                                itemBuilder: (context, index) {
                                  final userUID =
                                      snapshot.data!.docs[index]["uid"];
                                  final isSelected =
                                      selectUserId.contains(userUID);
                                  return ListTile(
                                    onTap: () =>
                                        _isSelected(snapshot.data!.docs[index]),
                                    tileColor: Colors.grey.shade100,
                                    contentPadding: const EdgeInsets.only(
                                      left: Sizes.size10,
                                      right: Sizes.size24,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        color: isSelected == true
                                            ? Theme.of(context).primaryColor
                                            : Colors.grey.shade200,
                                        width: isSelected == true
                                            ? Sizes.size2
                                            : Sizes.size1,
                                      ),
                                      borderRadius:
                                          BorderRadius.circular(Sizes.size10),
                                    ),
                                    leading: CircleAvatar(
                                      radius: 30,
                                      foregroundColor:
                                          Theme.of(context).primaryColor,
                                      foregroundImage: snapshot.data!
                                                  .docs[index]["hasAvatar"] ==
                                              true
                                          ? NetworkImage(
                                              "https://firebasestorage.googleapis.com/v0/b/marketlyze.appspot.com/o/avatars%2F${snapshot.data!.docs[index]["uid"]}?alt=media&lol=${DateTime.now().toString()}",
                                            )
                                          : null,
                                    ),
                                    title: Text(
                                      "${snapshot.data!.docs[index]["username"]}",
                                      style: const TextStyle(
                                        fontSize: Sizes.size18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    ),
                                    subtitle: Text(
                                      "${snapshot.data!.docs[index]["realname"]}",
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                    trailing: FaIcon(
                                      FontAwesomeIcons.circleCheck,
                                      size: Sizes.size20,
                                      color: isSelected == true
                                          ? Colors.blue
                                          : Colors.grey.shade300,
                                    ),
                                  );
                                },
                              );
                      },
                    ),
                  ),
                  CustomButtonWidget(
                    goFunction: (BuildContext context) =>
                        _makeChatRoom(data.uid, data.username),
                    text:
                        selectUserId.isEmpty ? "choose your member" : "create",
                    verticalPadding: Sizes.size10,
                    horizontalMargin: Sizes.size10,
                    insideHeight: Sizes.size44,
                    radius: Sizes.size10,
                    borderColor: selectUserId.isEmpty
                        ? Colors.white
                        : Theme.of(context).primaryColor,
                    textColor: selectUserId.isEmpty
                        ? Colors.grey.shade800
                        : Colors.black,
                  ),
                  Gaps.v24,
                ],
              ),
            );
          },
        );
  }
}
