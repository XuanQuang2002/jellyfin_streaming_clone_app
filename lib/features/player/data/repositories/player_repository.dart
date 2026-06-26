import 'package:dio/dio.dart';

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
      final response = await _dio.get<Map<String, dynamic>>(
        '/Items/$itemId',
        queryParameters: {'UserId': userId, 'Fields': 'Chapters,RunTimeTicks'},
      );
      return PlayerItemDetail.fromJson(response.data!);
    } on DioException catch (e) {
      throw e.error is AppException
          ? e.error as AppException
          : const UnknownException();
    }
  }
}
