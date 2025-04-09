import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // ---------- userProfile에 bookmark를 입력하는 repo ---------- //

  Future<void> updateBookmarkInUser(String reviewId, String uid) async {
    final review = [reviewId];

    await _db
        .collection("users")
        .doc(uid)
        .update({"bookmark": FieldValue.arrayUnion(review)});
  }

// ---------- userProfile에 bookmark를 제거하는 repo ---------- //

  Future<void> removeBookmarkInUser(String reviewId, String uid) async {
    final review = [reviewId];

    await _db
        .collection("users")
        .doc(uid)
        .update({"bookmark": FieldValue.arrayRemove(review)});
  }

  // ---------- review에 bookmark를 입력하는 repo ---------- //

  Future<void> updateBookmarkInReview(String reviewId, String uid) async {
    final userid = [uid];

    await _db
        .collection("reviews")
        .doc(reviewId)
        .update({"bookmarker": FieldValue.arrayUnion(userid)});
  }

// ---------- review에 bookmark를 제거하는 repo ---------- //

  Future<void> removeBookmarkInReview(String reviewId, String uid) async {
    final userid = [uid];

    await _db
        .collection("reviews")
        .doc(reviewId)
        .update({"bookmarker": FieldValue.arrayRemove(userid)});
  }
}

final postRepo = Provider((ref) => PostRepository());
