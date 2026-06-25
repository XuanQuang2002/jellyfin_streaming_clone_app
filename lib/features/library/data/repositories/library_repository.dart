import 'package:dio/dio.dart';

import '../../../../core/network/app_exception.dart';
import '../../../../core/network/jellyfin_constants.dart';
import '../models/library_models.dart';

class LibraryRepository {
  LibraryRepository(this._dio);

  final Dio _dio;

  static const _pageSize = 30;

  // ─── User Views (Libraries) ────────────────────────────────────────────────

  Future<UserViewsResponse> getUserViews(String userId) async {
    final path = JellyfinConstants.userViews.replaceAll('{userId}', userId);
    try {
      final response = await _dio.get<Map<String, dynamic>>(path);
      return UserViewsResponse.fromJson(response.data!);
    } on DioException catch (e) {
      throw e.error is AppException
          ? e.error as AppException
          : const UnknownException();
    }
  }

  // ─── Library Items ─────────────────────────────────────────────────────────

  Future<MediaItemsResponse> getLibraryItems({
    required String userId,
    required String parentId,
    int startIndex = 0,
    int limit = _pageSize,
  }) async {
    final path = JellyfinConstants.userItems.replaceAll('{userId}', userId);
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        path,
        queryParameters: {
          'ParentId': parentId,
          'Recursive': true,
          'SortBy': 'SortName',
          'SortOrder': 'Ascending',
          'Fields': 'PrimaryImageAspectRatio,BasicSyncInfo,Overview',
          'ImageTypeLimit': 1,
          'EnableImageTypes': 'Primary,Backdrop,Thumb',
          'StartIndex': startIndex,
          'Limit': limit,
        },
      );
      return MediaItemsResponse.fromJson(response.data!);
    } on DioException catch (e) {
      throw e.error is AppException
          ? e.error as AppException
          : const UnknownException();
    }
  }
}
