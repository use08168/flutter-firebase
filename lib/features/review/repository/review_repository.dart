import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marketlyze_1/features/review/model/review_profile_model.dart';
import 'package:multiple_images_picker/multiple_images_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class ReviewRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<Map<String, dynamic>?> findProfile(String uid) async {
    final doc = await _db.collection("users").doc(uid).get();
    return doc.data();
  }

  // ---------- firebase에 이미지 저장하는 함수 ---------- //

  Future<List<String>> uploadReviewImages(
      List<Asset> images, String uid) async {
    final List<String> imageUrls = [];
    for (final asset in images) {
      final file = await convertAssetToFile(asset);
      final fileRef = _storage.ref().child(
          "/image/$uid/${DateTime.now().millisecondsSinceEpoch.toString()}");
      final task = await fileRef.putFile(file);
      if (task.metadata != null) {
        final imageUrl = await task.ref.getDownloadURL();
        imageUrls.add(imageUrl);
      }
    }
    return imageUrls;
  }

  Future<File> convertAssetToFile(Asset asset) async {
    final byteData = await asset.getByteData();
    final buffer = byteData.buffer.asUint8List();
    final tempDir = await getTemporaryDirectory();
    final filePath =
        join(tempDir.path, '${DateTime.now().millisecondsSinceEpoch}.png');
    final file = File(filePath);
    await file.writeAsBytes(buffer);
    return file;
  }

  Future<String> createReview(ReviewProfileModel review) async {
    final documentReference =
        await _db.collection("reviews").add(review.toJson());
    final reviewId = documentReference.id;
    return reviewId;
  }

// ---------- firebase에 reviewId 업데이트 하는 함수 ---------- //

  Future<void> updateReviewId(String reviewId) async {
    await _db
        .collection("reviews")
        .doc(reviewId)
        .update({"reviewId": reviewId});
  }

// ---------- firebase user에 자신이 만든 reviewId저장 --------- //

  Future<void> updateReviewIdForUser(String reviewId, String uid) async {
    final review = [reviewId];
    await _db
        .collection("users")
        .doc(uid)
        .update({"reviewIds": FieldValue.arrayUnion(review)});
  }

  Future<void> updateUidInLike(String reviewId, List<String> likes) async {
    await _db
        .collection("reviews")
        .doc(reviewId)
        .update({"likes": FieldValue.arrayUnion(likes)});
  }

  Future<void> removeUidInLike(String reviewId, List<String> likes) async {
    await _db
        .collection("reviews")
        .doc(reviewId)
        .update({"likes": FieldValue.arrayRemove(likes)});
  }

// ---------- userProfile에 likePost를 입력하는 repo ---------- //

  Future<void> updateReviewidInUser(String reviewId, String uid) async {
    final review = [reviewId];

    await _db
        .collection("users")
        .doc(uid)
        .update({"likePost": FieldValue.arrayUnion(review)});
  }

// ---------- userProfile에 likePost를 제거하는 repo ---------- //

  Future<void> removeReviewidInUser(String reviewId, String uid) async {
    final review = [reviewId];

    await _db
        .collection("users")
        .doc(uid)
        .update({"likePost": FieldValue.arrayRemove(review)});
  }
}

final reviewRepo = Provider((ref) => ReviewRepository());
