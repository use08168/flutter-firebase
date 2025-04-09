import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marketlyze_1/features/authentication/repository/authentication_repository.dart';
import 'package:marketlyze_1/features/review/model/review_profile_model.dart';
import 'package:marketlyze_1/features/review/repository/review_repository.dart';
import 'package:marketlyze_1/features/user/view_model/users_view_model.dart';
import 'package:multiple_images_picker/multiple_images_picker.dart';

class ReviewViewModel extends AsyncNotifier<ReviewProfileModel> {
  late final ReviewRepository _reviewRepository;
  //late final PostRepository _postRepository;

  @override
  FutureOr<ReviewProfileModel> build() async {
    _reviewRepository = ref.read(reviewRepo);

    final authenticationRepository = ref.read(authRepo);
    if (authenticationRepository.isLoggedIn) {
      final profile = await _reviewRepository
          .findProfile(authenticationRepository.user!.uid);
      if (profile != null) {
        return ReviewProfileModel.fromJson(profile);
      }
    }
    return ReviewProfileModel.empty();
  }

  Future<void> createReview({
    required Map<String, double> ratingTo,
    required Map<String, dynamic> data,
    required List<Asset> images,
    required int selectedIndex,
  }) async {
    state = const AsyncLoading();
    final userProfile = ref.read(usersProvider).value;
    if (userProfile == null) {
      return;
    }
    final imageUrl =
        await _reviewRepository.uploadReviewImages(images, userProfile.uid);

    final reviewId = await _reviewRepository.createReview(
      ReviewProfileModel(
        title: data["title"],
        content: data["content"],
        createrUid: userProfile.uid,
        creater: userProfile.username,
        reviewId: "",
        likes: [],
        bookmarker: [],
        imageUrl: imageUrl,
        selectedIndex: selectedIndex,
        ratingTo1: ratingTo["ratingTo1"] ?? 1.0,
        ratingTo2: ratingTo["ratingTo2"] ?? 1.0,
        ratingTo3: ratingTo["ratingTo3"] ?? 1.0,
        ratingTo4: ratingTo["ratingTo4"] ?? 1.0,
        ratingTo5: ratingTo["ratingTo5"] ?? 1.0,
      ),
    );
    await _reviewRepository.updateReviewId(reviewId);
    await _reviewRepository.updateReviewIdForUser(reviewId, userProfile.uid);
  }

// ---------- firebase likes에 uid를 넣고 제거하는 함수 ---------- //

  Future<void> likePress(
      {String? reviewId, List<String>? liker, String? uid}) async {
    if (reviewId != null) {
      if (state.value != null) {
        state = AsyncValue.data(state.value!.copyWith(likes: liker));
        await _reviewRepository.updateUidInLike(reviewId, liker ?? []);
        await _reviewRepository.updateReviewidInUser(reviewId, uid ?? "");
      }
    }
  }

  Future<void> dislikePress(
      {String? reviewId, List<String>? liker, String? uid}) async {
    if (reviewId != null) {
      if (state.value != null) {
        state = AsyncValue.data(state.value!.copyWith(likes: liker));
        await _reviewRepository.removeUidInLike(reviewId, liker ?? []);
        await _reviewRepository.removeReviewidInUser(reviewId, uid ?? "");
      }
    }
  }

  // ---------- 작동 필요 없음 ---------- //

  // Future<void> pressBookmarkIfNot({String? reviewId, String? uid}) async {
  //   final booker = [uid];
  //   if (reviewId != null) {
  //     if (state.value != null) {
  //       state = AsyncValue.data(state.value!.copyWith(bookmarker: booker));
  //       //await _postRepository.updateBookmarkInReview(reviewId, booker ?? []);
  //       await _postRepository.updateBookmarkInReview(reviewId, uid ?? "");
  //       //await _postRepository.updateBookmarkInUser(reviewId, uid ?? "");
  //       await _postRepository.updateBookmarkInUser(reviewId, uid ?? "");
  //     }
  //   }
  // }

  // Future<void> pressBookmarkIfCancel({String? reviewId, String? uid}) async {
  //   final booker = [uid];
  //   if (reviewId != null) {
  //     if (state.value != null) {
  //       state = AsyncValue.data(state.value!.copyWith(bookmarker: booker));
  //       //await _postRepository.removeBookmarkInReview(reviewId, booker ?? []);
  //       await _postRepository.removeBookmarkInReview(reviewId, uid ?? "");
  //       //await _postRepository.removeBookmarkInUser(reviewId, uid ?? "");
  //       await _postRepository.removeBookmarkInUser(reviewId, uid ?? "");
  //     }
  //   }
  // }
}

final reviewProvider =
    AsyncNotifierProvider<ReviewViewModel, ReviewProfileModel>(
  () => ReviewViewModel(),
);
