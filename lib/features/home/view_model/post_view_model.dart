import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marketlyze_1/features/review/view_model/review_view_model.dart';

class LikeViewModel extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> pressLikeIfNoUid(
      {String? reviewId, List<String>? liker, String? uid}) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () async {
        await ref.read(reviewProvider.notifier).likePress(
              liker: liker,
              reviewId: reviewId,
              uid: uid,
            );
      },
    );
  }

  Future<void> pressLikeIfHaveUid(
      {String? reviewId, List<String>? liker, String? uid}) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () async {
        await ref.read(reviewProvider.notifier).dislikePress(
              liker: liker,
              reviewId: reviewId,
              uid: uid,
            );
      },
    );
  }

// ---------- 작동 필요 없음 ---------- //

  // Future<void> addBookmarkPress({String? reviewId, String? uid}) async {
  //   state = const AsyncValue.loading();
  //   state = await AsyncValue.guard(
  //     () async {
  //       await ref.read(reviewProvider.notifier).pressBookmarkIfNot(
  //             reviewId: reviewId,
  //             uid: uid,
  //           );
  //     },
  //   );
  // }

  // Future<void> removeBookmarkPress({String? reviewId, String? uid}) async {
  //   state = const AsyncValue.loading();
  //   state = await AsyncValue.guard(
  //     () async {
  //       await ref.read(reviewProvider.notifier).pressBookmarkIfCancel(
  //             reviewId: reviewId,
  //             uid: uid,
  //           );
  //     },
  //   );
  // }
}

final likeProvider = AsyncNotifierProvider<LikeViewModel, void>(
  () => LikeViewModel(),
);
