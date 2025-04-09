import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:marketlyze_1/features/user/view_model/avatar_view_model.dart';

class ProfileCircleAvatarWidget extends ConsumerWidget {
  final double circleSize;
  final bool hasAvatar;
  final String uid;

  const ProfileCircleAvatarWidget({
    super.key,
    required this.circleSize,
    required this.hasAvatar,
    required this.uid,
  });

  Future<void> _onAvatarTap(WidgetRef ref) async {
    final xfile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 40,
      maxHeight: 150,
      maxWidth: 150,
    );
    if (xfile != null) {
      final file = File(xfile.path);
      ref.read(avatarProvider.notifier).uploadAvatar(file);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(avatarProvider).isLoading;
    return GestureDetector(
      onTap: isLoading ? null : () => _onAvatarTap(ref),
      child: isLoading
          ? Container(
              width: 60,
              height: 60,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: const CircularProgressIndicator(
                color: Colors.black,
              ),
            )
          : CircleAvatar(
              radius: circleSize,
              foregroundColor: Theme.of(context).primaryColor,
              foregroundImage: hasAvatar
                  ? NetworkImage(
                      "https://firebasestorage.googleapis.com/v0/b/marketlyze.appspot.com/o/avatars%2F$uid?alt=media&lol=${DateTime.now().toString()}",
                    )
                  : null,
            ),
    );
  }
}
