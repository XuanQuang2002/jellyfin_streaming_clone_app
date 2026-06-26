import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/app_exception.dart';
import '../../../../core/network/dio_client.dart';
import '../../../auth/domain/providers/auth_provider.dart';
import '../../data/models/player_model.dart';
import '../../data/repositories/player_repository.dart';

// ─── Repository ───────────────────────────────────────────────────────────────

final playerRepositoryProvider = Provider<PlayerRepository>((ref) {
  return PlayerRepository(ref.watch(dioProvider));
});

// ─── Item Detail with Chapters ────────────────────────────────────────────────

final playerItemDetailProvider = FutureProvider.autoDispose
    .family<PlayerItemDetail, String>((ref, itemId) async {
      final auth = ref.watch(authenticatedStateProvider);
      if (auth == null) throw const UnknownException();
      final repo = ref.watch(playerRepositoryProvider);
      return repo.getItemDetail(itemId: itemId, userId: auth.userId);
    });
