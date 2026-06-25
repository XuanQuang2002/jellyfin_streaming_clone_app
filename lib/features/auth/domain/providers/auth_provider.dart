import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/dio_client.dart';
import '../../data/models/auth_models.dart';
import '../../data/repositories/auth_repository.dart';

// ─── Repository Provider ──────────────────────────────────────────────────────

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(ref.watch(dioProvider));
});

// ─── Auth Notifier ────────────────────────────────────────────────────────────

class AuthNotifier extends AsyncNotifier<AuthState> {
  AuthRepository get _repo => ref.read(authRepositoryProvider);

  @override
  Future<AuthState> build() async {
    // Try to restore a saved session on startup
    final restored = await _repo.restoreSession();
    if (restored != null) return restored;
    return const AuthState.unauthenticated();
  }

  // ─── Login ──────────────────────────────────────────────────────────────

  Future<void> login({
    required String serverUrl,
    required String username,
    required String password,
  }) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final response = await _repo.authenticate(
        serverUrl: serverUrl,
        username: username,
        password: password,
      );

      return AuthState.authenticated(
        serverUrl: serverUrl.trimRight().replaceAll(RegExp(r'/+$'), ''),
        accessToken: response.accessToken,
        userId: response.user.id,
        username: response.user.name,
        deviceId: response.user.serverId ?? 'unknown',
      );
    });
  }

  // ─── Logout ─────────────────────────────────────────────────────────────

  Future<void> logout() async {
    state = const AsyncLoading();
    await _repo.logout();
    state = const AsyncData(AuthState.unauthenticated());
  }
}

// ─── Providers ────────────────────────────────────────────────────────────────

final authProvider = AsyncNotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);

/// Convenience: true when the user is fully authenticated.
final isAuthenticatedProvider = Provider<bool>((ref) {
  return ref.watch(authProvider).value is AuthStateAuthenticated;
});

/// Convenience: the authenticated state (null when not authenticated).
final authenticatedStateProvider = Provider<AuthStateAuthenticated?>((ref) {
  final state = ref.watch(authProvider).value;
  return state is AuthStateAuthenticated ? state : null;
});
