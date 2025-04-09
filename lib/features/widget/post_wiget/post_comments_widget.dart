import 'package:flutter/material.dart';
import 'package:marketlyze_1/constants/sizes.dart';

class PostCommentsWidget extends StatefulWidget {
  final dynamic snap;
  const PostCommentsWidget({
    super.key,
    required this.snap,
  });

  @override
  State<PostCommentsWidget> createState() => _PostCommentsWidgetState();
}

class _PostCommentsWidgetState extends State<PostCommentsWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.size10,
          horizontal: Sizes.size10,
        ),
        child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return Container(
              color: Colors.amber,
              margin: const EdgeInsets.symmetric(
                vertical: Sizes.size5,
                horizontal: Sizes.size10,
              ),
              child: Text("$index. hi"),
            );
          },
        ),
      ),
    );
  }
}
