import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marketlyze_1/constants/gaps.dart';
import 'package:marketlyze_1/constants/sizes.dart';
import 'package:marketlyze_1/features/text/inside_chat_room/view_model/inside_chat_room_view_model.dart';
import 'package:marketlyze_1/features/user/view_model/users_view_model.dart';

class InsideChatRoom extends ConsumerStatefulWidget {
  const InsideChatRoom({
    super.key,
    required this.snap,
  });
  final dynamic snap;

  @override
  ConsumerState<InsideChatRoom> createState() => _InsideChatRoomState();
}

class _InsideChatRoomState extends ConsumerState<InsideChatRoom> {
  final TextEditingController _textController = TextEditingController();

  bool _textVaild = false;
  String _text = "";

  @override
  void initState() {
    super.initState();
    _textController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    final text = _textController.text;
    setState(() {
      _text = text;
      _textVaild = text.isNotEmpty && text.trim().isNotEmpty;
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _onSubmitTap(uid, username) {
    if (_textVaild) {
      ref.read(insideChatRoomProvider.notifier).sendText(
          text: _text,
          chatRoomId: widget.snap["chatRoomId"],
          uid: uid,
          username: username);
      //print(_text);
    }
    _textController.text = "";
  }

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
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
          data: (data) => GestureDetector(
            onTap: _onScaffoldTap,
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                    "${widget.snap["chatRoomName"]} ${widget.snap["chatRoomUserId"].length}"),
                leading: IconButton(
                  onPressed: Navigator.of(context).pop,
                  icon: const FaIcon(
                    FontAwesomeIcons.angleLeft,
                    size: Sizes.size20,
                  ),
                ),
              ),
              body: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("chatroom")
                    .doc(widget.snap["chatRoomId"])
                    .collection("text")
                    .orderBy("time", descending: false)
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
                  return ListView.separated(
                    separatorBuilder: (context, index) => Gaps.v10,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return index == 0
                          ? Center(
                              child: Text(
                                "${snapshot.data!.docs[0]["time"].toDate().year}/${snapshot.data!.docs[0]["time"].toDate().month}/${snapshot.data!.docs[0]["time"].toDate().day}",
                              ),
                            )
                          : Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: Sizes.size10,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: snapshot.data!.docs[index]
                                            ["userId"] ==
                                        data.uid
                                    ? MainAxisAlignment.end
                                    : MainAxisAlignment.start,
                                children: [
                                  if (snapshot.data!.docs[index]["userId"] ==
                                      data.uid)
                                    Row(
                                      children: [
                                        Text(
                                          "${snapshot.data!.docs[index]["time"].toDate().hour}:${snapshot.data!.docs[index]["time"].toDate().minute}",
                                          style: const TextStyle(
                                            fontSize: Sizes.size11,
                                          ),
                                        ),
                                        Gaps.h3,
                                      ],
                                    ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (snapshot.data!.docs[index]
                                              ["userId"] !=
                                          data.uid)
                                        Text(
                                            "${snapshot.data!.docs[index]["username"]}"),
                                      Container(
                                        constraints: BoxConstraints(
                                          maxWidth: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.6,
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          vertical: Sizes.size10,
                                          horizontal: Sizes.size12,
                                        ),
                                        decoration: BoxDecoration(
                                          color: snapshot.data!.docs[index]
                                                      ["userId"] ==
                                                  data.uid
                                              ? const Color.fromARGB(
                                                  255, 190, 234, 255)
                                              : Colors.grey.shade200,
                                          borderRadius: BorderRadius.only(
                                            topLeft: const Radius.circular(
                                              Sizes.size10,
                                            ),
                                            topRight: const Radius.circular(
                                              Sizes.size10,
                                            ),
                                            bottomLeft:
                                                snapshot.data!.docs[index]
                                                            ["userId"] ==
                                                        data.uid
                                                    ? const Radius.circular(
                                                        Sizes.size10,
                                                      )
                                                    : const Radius.circular(
                                                        Sizes.size3,
                                                      ),
                                            bottomRight:
                                                snapshot.data!.docs[index]
                                                            ["userId"] ==
                                                        data.uid
                                                    ? const Radius.circular(
                                                        Sizes.size3,
                                                      )
                                                    : const Radius.circular(
                                                        Sizes.size10,
                                                      ),
                                          ),
                                        ),
                                        child: Text(
                                          "${snapshot.data!.docs[index]["text"]}",
                                          textAlign: TextAlign.start,
                                          style: const TextStyle(
                                            fontSize: Sizes.size16,
                                          ),
                                          overflow: TextOverflow.clip,
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (snapshot.data!.docs[index]["userId"] !=
                                      data.uid)
                                    Row(
                                      children: [
                                        Gaps.h3,
                                        Text(
                                          "${snapshot.data!.docs[index]["time"].toDate().hour}:${snapshot.data!.docs[index]["time"].toDate().minute}",
                                          style: const TextStyle(
                                            fontSize: Sizes.size11,
                                          ),
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                            );
                    },
                  );
                },
              ),
              bottomSheet: Container(
                color: Colors.grey.shade200,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(
                  right: Sizes.size10,
                  left: Sizes.size10,
                  top: Sizes.size5,
                  bottom: Sizes.size5,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.82,
                      child: TextField(
                        keyboardType: TextInputType.text,
                        minLines: 1,
                        maxLines: 4,
                        controller: _textController,
                        autocorrect: false,
                        cursorColor: Theme.of(context).primaryColor,
                        decoration: const InputDecoration(
                          hintText: "send message",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            vertical: Sizes.size10,
                            horizontal: Sizes.size14,
                          ),
                        ),
                      ),
                    ),
                    Gaps.h10,
                    GestureDetector(
                      onTap: () => _onSubmitTap(data.uid, data.username),
                      child: FaIcon(
                        FontAwesomeIcons.circleArrowUp,
                        color: _textVaild == true
                            ? Theme.of(context).primaryColor
                            : Colors.grey.shade400,
                        size: Sizes.size26,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
  }
}
