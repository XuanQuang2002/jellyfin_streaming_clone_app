import 'package:dio/dio.dart';
import 'package:jellyfin_streaming_clone_app/core/network/jellyfin_constants.dart';

import '../../../../core/network/app_exception.dart';
import '../models/player_model.dart';

class PlayerRepository {
  PlayerRepository(this._dio);

  final Dio _dio;

  /// Fetches item detail including chapter info.
  /// Calls: GET /Items/{ItemId}?UserId={UserId}&Fields=Chapters
  Future<PlayerItemDetail> getItemDetail({
    required String itemId,
    required String userId,
  }) async {
    try {
      final path = JellyfinConstants.itemInfo.replaceAll('{ItemId}', itemId);
      final response = await _dio.get<Map<String, dynamic>>(
        path,
        queryParameters: {'UserId': userId, 'Fields': 'Chapters,RunTimeTicks'},
      );
      return PlayerItemDetail.fromJson(response.data!);
    } on DioException catch (e) {
      throw e.error is AppException
          ? e.error as AppException
          : const UnknownException();
    }
  }

  /// Registers the start of a playback session.
  /// Calls: POST /Sessions/Playing  (body: PlaybackStartInfo)
  Future<void> reportPlaybackStart({
    required String itemId,
    required String userId,
    int positionTicks = 0,
  }) async {
    try {
      await _dio.post(
        JellyfinConstants.sessionPlaying,
        data: {
          'ItemId': itemId,
          'PositionTicks': positionTicks,
          'IsPaused': false,
          'IsMuted': false,
          'CanSeek': true,
          'PlayMethod': 'DirectStream',
        },
      );
    } on DioException catch (e) {
      throw e.error is AppException
          ? e.error as AppException
          : const UnknownException();
    }
  }

  /// Reports periodic playback progress (drives the resume point on the server).
  /// Calls: POST /Sessions/Playing/Progress  (body: PlaybackProgressInfo)
  Future<void> reportPlaybackProgress({
    required String itemId,
    required String userId,
    required bool isPaused,
    required int positionTicks,
  }) async {
    try {
      await _dio.post(
        JellyfinConstants.sessionProgress,
        data: {
          'ItemId': itemId,
          'PositionTicks': positionTicks,
          'IsPaused': isPaused,
          'IsMuted': false,
          'CanSeek': true,
          'PlayMethod': 'DirectStream',
        },
      );
    } on DioException catch (e) {
      throw e.error is AppException
          ? e.error as AppException
          : const UnknownException();
    }
  }

  /// Commits the final position when playback stops. This is what reliably
  /// persists the resume point on the server.
  /// Calls: POST /Sessions/Playing/Stopped  (body: PlaybackStopInfo)
  Future<void> reportPlaybackStopped({
    required String itemId,
    required String userId,
    required int positionTicks,
  }) async {
    try {
      await _dio.post(
        JellyfinConstants.sessionStopped,
        data: {'ItemId': itemId, 'PositionTicks': positionTicks},
      );
    } on DioException catch (e) {
      throw e.error is AppException
          ? e.error as AppException
          : const UnknownException();
    }
  }
}
