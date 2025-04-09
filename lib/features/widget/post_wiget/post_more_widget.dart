import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marketlyze_1/constants/gaps.dart';
import 'package:marketlyze_1/constants/sizes.dart';

class PostMoreWidget extends StatefulWidget {
  final dynamic snap;
  const PostMoreWidget({
    super.key,
    required this.snap,
  });

  @override
  State<PostMoreWidget> createState() => _PostMoreWidgetState();
}

class _PostMoreWidgetState extends State<PostMoreWidget> {
  var string1 = [
    "Taste",
    "1-2",
    "1-3",
    "1-4",
    "1-5",
    "1-6",
    "1-7",
    "1-8",
    "1-9",
    "1-10",
    "1-11",
    //"1-12"
  ];

  var string2 = [
    "Delivery",
    "2-2",
    "2-3",
    "2-4",
    "2-5",
    "2-6",
    "2-7",
    "2-8",
    "2-9",
    "2-10",
    "2-11",
    //"2-12"
  ];

  var string3 = [
    "Quality",
    "3-2",
    "3-3",
    "3-4",
    "3-5",
    "3-6",
    "3-7",
    "3-8",
    "3-9",
    "3-10",
    "3-11",
    //"3-12"
  ];

  var string4 = [
    "Quantity",
    "4-2",
    "4-3",
    "4-4",
    "4-5",
    "4-6",
    "4-7",
    "4-8",
    "4-9",
    "4-10",
    "4-11",
    //"4-12"
  ];

  var string5 = [
    "Price",
    "5-2",
    "5-3",
    "5-4",
    "5-5",
    "5-6",
    "5-7",
    "5-8",
    "5-9",
    "5-10",
    "5-11",
    //"5-12"
  ];

  int countStar = 1;

  // void _pressedX() {
  //   Navigator.of(context).pop();
  // }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: Sizes.size20,
            horizontal: Sizes.size48,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ---------- title ---------- //

              Text(
                "${widget.snap?["creater"] ?? ""}'s title.",
                style: const TextStyle(
                  fontSize: Sizes.size20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Gaps.v10,
              Text(widget.snap?["title"] ?? ""),
              Gaps.v20,

              // ---------- content ---------- //

              Text(
                "${widget.snap?["creater"] ?? ""}'s content.",
                style: const TextStyle(
                  fontSize: Sizes.size20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Gaps.v10,
              Text(widget.snap?["content"] ?? ""),
              Gaps.v20,

              // ---------- points ---------- //

              Text(
                "${widget.snap?["creater"] ?? ""}'s points.",
                style: const TextStyle(
                  fontSize: Sizes.size20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Gaps.v20,

              // ---------- 1번 리스트 ---------- //

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.circle,
                        size: Sizes.size6,
                      ),
                      Gaps.h10,
                      Text(
                        string1[widget.snap?["selectedIndex"]],
                        style: const TextStyle(
                          fontSize: Sizes.size18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  Gaps.h10,
                  Row(
                    children: [
                      FaIcon(
                        widget.snap?["ratingTo1"] >= 1
                            ? FontAwesomeIcons.solidStar
                            : FontAwesomeIcons.star,
                        color: widget.snap?["ratingTo1"] >= 1
                            ? Colors.amber
                            : Colors.grey,
                      ),
                      FaIcon(
                        widget.snap?["ratingTo1"] >= 2
                            ? FontAwesomeIcons.solidStar
                            : FontAwesomeIcons.star,
                        color: widget.snap?["ratingTo1"] >= 2
                            ? Colors.amber
                            : Colors.grey,
                      ),
                      FaIcon(
                        widget.snap?["ratingTo1"] >= 3
                            ? FontAwesomeIcons.solidStar
                            : FontAwesomeIcons.star,
                        color: widget.snap?["ratingTo1"] >= 3
                            ? Colors.amber
                            : Colors.grey,
                      ),
                      FaIcon(
                        widget.snap?["ratingTo1"] >= 4
                            ? FontAwesomeIcons.solidStar
                            : FontAwesomeIcons.star,
                        color: widget.snap?["ratingTo1"] >= 4
                            ? Colors.amber
                            : Colors.grey,
                      ),
                      FaIcon(
                        widget.snap?["ratingTo1"] >= 5
                            ? FontAwesomeIcons.solidStar
                            : FontAwesomeIcons.star,
                        color: widget.snap?["ratingTo1"] >= 5
                            ? Colors.amber
                            : Colors.grey,
                      ),
                    ],
                  ),
                ],
              ),
              Gaps.v10,

              // ---------- 2번 리스트 ---------- //

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.circle,
                        size: Sizes.size6,
                      ),
                      Gaps.h10,
                      Text(
                        string2[widget.snap?["selectedIndex"]],
                        style: const TextStyle(
                          fontSize: Sizes.size18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  Gaps.h10,
                  Row(
                    children: [
                      FaIcon(
                        widget.snap?["ratingTo2"] >= 1
                            ? FontAwesomeIcons.solidStar
                            : FontAwesomeIcons.star,
                        color: widget.snap?["ratingTo2"] >= 1
                            ? Colors.amber
                            : Colors.grey,
                      ),
                      FaIcon(
                        widget.snap?["ratingTo2"] >= 2
                            ? FontAwesomeIcons.solidStar
                            : FontAwesomeIcons.star,
                        color: widget.snap?["ratingTo2"] >= 2
                            ? Colors.amber
                            : Colors.grey,
                      ),
                      FaIcon(
                        widget.snap?["ratingTo2"] >= 3
                            ? FontAwesomeIcons.solidStar
                            : FontAwesomeIcons.star,
                        color: widget.snap?["ratingTo2"] >= 3
                            ? Colors.amber
                            : Colors.grey,
                      ),
                      FaIcon(
                        widget.snap?["ratingTo2"] >= 4
                            ? FontAwesomeIcons.solidStar
                            : FontAwesomeIcons.star,
                        color: widget.snap?["ratingTo2"] >= 4
                            ? Colors.amber
                            : Colors.grey,
                      ),
                      FaIcon(
                        widget.snap?["ratingTo2"] >= 5
                            ? FontAwesomeIcons.solidStar
                            : FontAwesomeIcons.star,
                        color: widget.snap?["ratingTo2"] >= 5
                            ? Colors.amber
                            : Colors.grey,
                      ),
                    ],
                  ),
                ],
              ),
              Gaps.v10,

              // ---------- 3번 리스트 ---------- //

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.circle,
                        size: Sizes.size6,
                      ),
                      Gaps.h10,
                      Text(
                        string3[widget.snap?["selectedIndex"]],
                        style: const TextStyle(
                          fontSize: Sizes.size18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  Gaps.h10,
                  Row(
                    children: [
                      FaIcon(
                        widget.snap?["ratingTo3"] >= 1
                            ? FontAwesomeIcons.solidStar
                            : FontAwesomeIcons.star,
                        color: widget.snap?["ratingTo3"] >= 1
                            ? Colors.amber
                            : Colors.grey,
                      ),
                      FaIcon(
                        widget.snap?["ratingTo3"] >= 2
                            ? FontAwesomeIcons.solidStar
                            : FontAwesomeIcons.star,
                        color: widget.snap?["ratingTo3"] >= 2
                            ? Colors.amber
                            : Colors.grey,
                      ),
                      FaIcon(
                        widget.snap?["ratingTo3"] >= 3
                            ? FontAwesomeIcons.solidStar
                            : FontAwesomeIcons.star,
                        color: widget.snap?["ratingTo3"] >= 3
                            ? Colors.amber
                            : Colors.grey,
                      ),
                      FaIcon(
                        widget.snap?["ratingTo3"] >= 4
                            ? FontAwesomeIcons.solidStar
                            : FontAwesomeIcons.star,
                        color: widget.snap?["ratingTo3"] >= 4
                            ? Colors.amber
                            : Colors.grey,
                      ),
                      FaIcon(
                        widget.snap?["ratingTo3"] >= 5
                            ? FontAwesomeIcons.solidStar
                            : FontAwesomeIcons.star,
                        color: widget.snap?["ratingTo3"] >= 5
                            ? Colors.amber
                            : Colors.grey,
                      ),
                    ],
                  ),
                ],
              ),
              Gaps.v10,

              // ---------- 4번 리스트 ---------- //

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.circle,
                        size: Sizes.size6,
                      ),
                      Gaps.h10,
                      Text(
                        string4[widget.snap?["selectedIndex"]],
                        style: const TextStyle(
                          fontSize: Sizes.size18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  Gaps.h10,
                  Row(
                    children: [
                      FaIcon(
                        widget.snap?["ratingTo4"] >= 1
                            ? FontAwesomeIcons.solidStar
                            : FontAwesomeIcons.star,
                        color: widget.snap?["ratingTo4"] >= 1
                            ? Colors.amber
                            : Colors.grey,
                      ),
                      FaIcon(
                        widget.snap?["ratingTo4"] >= 2
                            ? FontAwesomeIcons.solidStar
                            : FontAwesomeIcons.star,
                        color: widget.snap?["ratingTo4"] >= 2
                            ? Colors.amber
                            : Colors.grey,
                      ),
                      FaIcon(
                        widget.snap?["ratingTo4"] >= 3
                            ? FontAwesomeIcons.solidStar
                            : FontAwesomeIcons.star,
                        color: widget.snap?["ratingTo4"] >= 3
                            ? Colors.amber
                            : Colors.grey,
                      ),
                      FaIcon(
                        widget.snap?["ratingTo4"] >= 4
                            ? FontAwesomeIcons.solidStar
                            : FontAwesomeIcons.star,
                        color: widget.snap?["ratingTo4"] >= 4
                            ? Colors.amber
                            : Colors.grey,
                      ),
                      FaIcon(
                        widget.snap?["ratingTo4"] >= 5
                            ? FontAwesomeIcons.solidStar
                            : FontAwesomeIcons.star,
                        color: widget.snap?["ratingTo4"] >= 5
                            ? Colors.amber
                            : Colors.grey,
                      ),
                    ],
                  ),
                ],
              ),
              Gaps.v10,

              // ---------- 5번 리스트 ---------- //

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.circle,
                        size: Sizes.size6,
                      ),
                      Gaps.h10,
                      Text(
                        string5[widget.snap?["selectedIndex"]],
                        style: const TextStyle(
                          fontSize: Sizes.size18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  Gaps.h10,
                  Row(
                    children: [
                      FaIcon(
                        widget.snap?["ratingTo5"] >= 1
                            ? FontAwesomeIcons.solidStar
                            : FontAwesomeIcons.star,
                        color: widget.snap?["ratingTo5"] >= 1
                            ? Colors.amber
                            : Colors.grey,
                      ),
                      FaIcon(
                        widget.snap?["ratingTo5"] >= 2
                            ? FontAwesomeIcons.solidStar
                            : FontAwesomeIcons.star,
                        color: widget.snap?["ratingTo5"] >= 2
                            ? Colors.amber
                            : Colors.grey,
                      ),
                      FaIcon(
                        widget.snap?["ratingTo5"] >= 3
                            ? FontAwesomeIcons.solidStar
                            : FontAwesomeIcons.star,
                        color: widget.snap?["ratingTo5"] >= 3
                            ? Colors.amber
                            : Colors.grey,
                      ),
                      FaIcon(
                        widget.snap?["ratingTo5"] >= 4
                            ? FontAwesomeIcons.solidStar
                            : FontAwesomeIcons.star,
                        color: widget.snap?["ratingTo5"] >= 4
                            ? Colors.amber
                            : Colors.grey,
                      ),
                      FaIcon(
                        widget.snap?["ratingTo5"] >= 5
                            ? FontAwesomeIcons.solidStar
                            : FontAwesomeIcons.star,
                        color: widget.snap?["ratingTo5"] >= 5
                            ? Colors.amber
                            : Colors.grey,
                      ),
                    ],
                  ),
                ],
              ),
              Gaps.v10,
            ],
          ),
        ),
      ),
    );
  }
}
