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

  // ─── Favorites ─────────────────────────────────────────────────────────────

  Future<MediaItemsResponse> getUserViewsFavorites(String userId) async {
    final path = JellyfinConstants.userItems.replaceAll('{userId}', userId);
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        path,
        queryParameters: {
          'Recursive': true,
          'Filters': 'IsFavorite',
          'Fields': 'Path',
        },
      );
      return MediaItemsResponse.fromJson(response.data!);
    } on DioException catch (e) {
      throw e.error is AppException
          ? e.error as AppException
          : const UnknownException();
    }
  }

  // ─── Continue Watching (Resume) ────────────────────────────────────────────

  Future<MediaItemsResponse> getResumeItems({
    required String userId,
    int limit = 12,
  }) async {
    final path = JellyfinConstants.userItemsResume.replaceAll(
      '{userId}',
      userId,
    );
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        path,
        queryParameters: {
          'Recursive': true,
          'Fields': 'RunTimeTicks,UserData,BackdropImageTags,ImageTags',
          'MediaTypes': 'Video',
          'ImageTypeLimit': 1,
          'EnableImageTypes': 'Primary,Backdrop,Thumb',
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

  // ─── Next Up (TV Shows) ────────────────────────────────────────────────────

  Future<MediaItemsResponse> getNextUpItems({
    required String userId,
    int limit = 12,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        JellyfinConstants.showsNextUp,
        queryParameters: {
          'UserId': userId,
          'Fields': 'RunTimeTicks,UserData,BackdropImageTags,ImageTags',
          'ImageTypeLimit': 1,
          'EnableImageTypes': 'Primary,Backdrop,Thumb',
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
          'IncludeItemTypes': 'Movie,Series,BoxSet',
        },
      );
      return MediaItemsResponse.fromJson(response.data!);
    } on DioException catch (e) {
      throw e.error is AppException
          ? e.error as AppException
          : const UnknownException();
    }
  }

  // ─── Item Detail ───────────────────────────────────────────────────────────

  Future<MediaItem> getItemDetail({
    required String userId,
    required String itemId,
  }) async {
    final path = JellyfinConstants.itemInfo
        .replaceAll('{userId}', userId)
        .replaceAll('{itemId}', itemId);
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        path,
        queryParameters: {
          'Fields':
              'Overview,Genres,Taglines,RunTimeTicks,OfficialRating,'
              'BackdropImageTags,ImageTags,UserData',
        },
      );
      return MediaItem.fromJson(response.data!);
    } on DioException catch (e) {
      throw e.error is AppException
          ? e.error as AppException
          : const UnknownException();
    }
  }

  // ─── Seasons ───────────────────────────────────────────────────────────────

  Future<SeasonsResponse> getSeasons({
    required String userId,
    required String seriesId,
  }) async {
    final path = '/Shows/$seriesId/Seasons';
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        path,
        queryParameters: {'userId': userId, 'Fields': 'ImageTags,ChildCount'},
      );
      return SeasonsResponse.fromJson(response.data!);
    } on DioException catch (e) {
      throw e.error is AppException
          ? e.error as AppException
          : const UnknownException();
    }
  }

  // ─── Episodes ──────────────────────────────────────────────────────────────

  Future<EpisodesResponse> getEpisodes({
    required String userId,
    required String seriesId,
    required String seasonId,
  }) async {
    final path = '/Shows/$seriesId/Episodes';
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        path,
        queryParameters: {
          'userId': userId,
          'seasonId': seasonId,
          'Fields': 'Overview,RunTimeTicks,ImageTags,BackdropImageTags',
          'ImageTypeLimit': 1,
          'EnableImageTypes': 'Primary,Backdrop,Thumb',
        },
      );
      return EpisodesResponse.fromJson(response.data!);
    } on DioException catch (e) {
      throw e.error is AppException
          ? e.error as AppException
          : const UnknownException();
    }
  }
}
