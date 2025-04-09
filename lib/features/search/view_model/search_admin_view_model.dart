import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marketlyze_1/features/authentication/repository/authentication_repository.dart';
import 'package:marketlyze_1/features/search/model/search_admin_model.dart';
import 'package:marketlyze_1/features/search/repository/search_admin_repository.dart';
import 'package:marketlyze_1/features/user/view_model/users_view_model.dart';
import 'package:multiple_images_picker/multiple_images_picker.dart';

class SearchAdminViewModel extends AsyncNotifier<SearchAdminModel> {
  late final SearchAdminRepository _searchAdminRepository;

  @override
  FutureOr<SearchAdminModel> build() async {
    _searchAdminRepository = ref.read(searchAdminRepo);

    final authenticationRepository = ref.read(authRepo);
    if (authenticationRepository.isLoggedIn) {
      final profile = await _searchAdminRepository
          .findProfile(authenticationRepository.user!.uid);
      if (profile != null) {
        return SearchAdminModel.fromJson(profile);
      }
    }
    return SearchAdminModel.empty();
  }

  Future<void> createSearch({
    required List<Asset> thumbnail,
    required List<Asset> banner,
    required Map<String, dynamic> data,
    required int selectedIndex,
  }) async {
    state = const AsyncLoading();
    final userProfile = ref.read(usersProvider).value;
    if (userProfile == null) {
      return;
    }
    final thmbnailImage = await _searchAdminRepository.uploadThumbnail(
      thumbnail,
      data["productName"],
      selectedIndex,
    );
    final bannerImage = await _searchAdminRepository.uploadBanner(
      banner,
      data["productName"],
      selectedIndex,
    );
    final searchId = await _searchAdminRepository.createSearch(
      SearchAdminModel(
        title: data["title"],
        content: data["content"],
        uid: userProfile.uid,
        business: data["business"],
        productName: data["productName"],
        selectedIndex: selectedIndex,
        imageUrlForThumbnail: thmbnailImage,
        imageUrlForBanner: bannerImage,
      ),
      selectedIndex,
    );
    await _searchAdminRepository.updateSearchId(searchId, selectedIndex);
  }
}

final searchAdminProvider =
    AsyncNotifierProvider<SearchAdminViewModel, SearchAdminModel>(
  () => SearchAdminViewModel(),
);
