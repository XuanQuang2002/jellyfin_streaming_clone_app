import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/auth/data/models/auth_models.dart';
import '../../features/auth/domain/providers/auth_provider.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../shared/widgets/placeholder_screen.dart';

// ─── Route Paths ──────────────────────────────────────────────────────────────

class AppRoutes {
  AppRoutes._();

  static const login = '/login';
  static const home = '/home';
  static const library = '/home/library/:libraryId';
  static const detail = '/home/detail/:itemId';
  static const player = '/home/player/:itemId';
}

// ─── Router Provider ──────────────────────────────────────────────────────────

final appRouterProvider = Provider<GoRouter>((ref) {
  // Rebuild the router whenever auth state changes
  final authState = ref.watch(authProvider);

  return GoRouter(
    initialLocation: AppRoutes.login,
    debugLogDiagnostics: true,
    refreshListenable: _AuthStateListenable(ref),
    routes: [
      // ── Auth ──────────────────────────────────────────────────────────
      GoRoute(
        path: AppRoutes.login,
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),

      // ── Main App ──────────────────────────────────────────────────────
      GoRoute(
        path: AppRoutes.home,
        name: 'home',
        builder: (context, state) => const PlaceholderScreen(title: 'Home'),
        routes: [
          GoRoute(
            path: 'library/:libraryId',
            name: 'library',
            builder: (context, state) {
              final id = state.pathParameters['libraryId']!;
              return PlaceholderScreen(title: 'Library: $id');
            },
          ),
          GoRoute(
            path: 'detail/:itemId',
            name: 'detail',
            builder: (context, state) {
              final id = state.pathParameters['itemId']!;
              return PlaceholderScreen(title: 'Detail: $id');
            },
          ),
          GoRoute(
            path: 'player/:itemId',
            name: 'player',
            builder: (context, state) {
              final id = state.pathParameters['itemId']!;
              return PlaceholderScreen(title: 'Player: $id');
            },
          ),
        ],
      ),
    ],

    // ── Auth Guard ────────────────────────────────────────────────────────
    redirect: (context, state) {
      final auth = authState.value;
      final isLoading = authState is AsyncLoading;
      final isAuthenticated = auth is AuthStateAuthenticated;
      final isOnLogin = state.matchedLocation == AppRoutes.login;

      // Still checking stored session — stay put
      if (isLoading) return null;

      // Not authenticated and not on login → go to login
      if (!isAuthenticated && !isOnLogin) return AppRoutes.login;

      // Authenticated but sitting on login → go to home
      if (isAuthenticated && isOnLogin) return AppRoutes.home;

      return null;
    },

    errorBuilder: (context, state) => Scaffold(
      backgroundColor: const Color(0xFF101010),
      body: Center(
        child: Text(
          'Page not found\n${state.error}',
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white70),
        ),
      ),
    ),
  );
});

// ─── Listenable Adapter ───────────────────────────────────────────────────────

/// Makes the GoRouter rebuild when the auth provider changes.
class _AuthStateListenable extends ChangeNotifier {
  _AuthStateListenable(Ref ref) {
    ref.listen(authProvider, (_, _) => notifyListeners());
  }
}
