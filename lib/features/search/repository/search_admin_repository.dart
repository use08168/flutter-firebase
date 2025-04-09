import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marketlyze_1/features/search/model/search_admin_model.dart';
import 'package:multiple_images_picker/multiple_images_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class SearchAdminRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<Map<String, dynamic>?> findProfile(String uid) async {
    final doc = await _db.collection("users").doc(uid).get();
    return doc.data();
  }

// ---------- firebase에 thumbnail 이미지 저장하는 함수 ---------- //

  Future<List<String>> uploadThumbnail(
    List<Asset> images,
    String productName,
    int selectedIndex,
  ) async {
    final List<String> imageUrls = [];
    for (final asset in images) {
      final file = await convertAssetToFileForThumbnail(asset);
      final fileRef = _storage.ref().child(
          "/thumbnail/$selectedIndex/$productName/${DateTime.now().millisecondsSinceEpoch.toString()}");
      final task = await fileRef.putFile(file);
      if (task.metadata != null) {
        final imageUrl = await task.ref.getDownloadURL();
        imageUrls.add(imageUrl);
      }
    }
    return imageUrls;
  }

  Future<File> convertAssetToFileForThumbnail(Asset asset) async {
    final byteData = await asset.getByteData();
    final buffer = byteData.buffer.asUint8List();
    final tempDir = await getTemporaryDirectory();
    final filePath =
        join(tempDir.path, '${DateTime.now().millisecondsSinceEpoch}.png');
    final file = File(filePath);
    await file.writeAsBytes(buffer);
    return file;
  }

// ---------- firebase에 banner 이미지 저장하는 함수 ---------- //

  Future<List<String>> uploadBanner(
    List<Asset> images,
    String productName,
    int selectedIndex,
  ) async {
    final List<String> imageUrls = [];
    for (final asset in images) {
      final file = await convertAssetToFileForBanner(asset);
      final fileRef = _storage.ref().child(
          "/banner/$selectedIndex/$productName/${DateTime.now().millisecondsSinceEpoch.toString()}");
      final task = await fileRef.putFile(file);
      if (task.metadata != null) {
        final imageUrl = await task.ref.getDownloadURL();
        imageUrls.add(imageUrl);
      }
    }
    return imageUrls;
  }

  Future<File> convertAssetToFileForBanner(Asset asset) async {
    final byteData = await asset.getByteData();
    final buffer = byteData.buffer.asUint8List();
    final tempDir = await getTemporaryDirectory();
    final filePath =
        join(tempDir.path, '${DateTime.now().millisecondsSinceEpoch}.png');
    final file = File(filePath);
    await file.writeAsBytes(buffer);
    return file;
  }

  Future<String> createSearch(
      SearchAdminModel search, int selectedIndex) async {
    final documentReference =
        await _db.collection("$selectedIndex").add(search.toJson());
    final searchId = documentReference.id;
    return searchId;
  }

  // ---------- firebase에 rsearchId 업데이트 하는 함수 ---------- //

  Future<void> updateSearchId(String searchId, int selectedIndex) async {
    await _db
        .collection("$selectedIndex")
        .doc(searchId)
        .update({"searchId": searchId});
  }
}

final searchAdminRepo = Provider((ref) => SearchAdminRepository());
