import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/auth/data/models/auth_models.dart';
import '../../features/auth/domain/providers/auth_provider.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/library/presentation/screens/home_screen.dart';
import '../../features/library/presentation/screens/library_screen.dart';
import '../../features/library/presentation/screens/media_detail_screen.dart';
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
        builder: (context, state) => const HomeScreen(),
        routes: [
          GoRoute(
            path: 'library/:libraryId',
            name: 'library',
            builder: (context, state) {
              final id = state.pathParameters['libraryId']!;
              final name = (state.extra as String?) ?? 'Library';
              return LibraryScreen(libraryId: id, libraryName: name);
            },
          ),
          GoRoute(
            path: 'detail/:itemId',
            name: 'detail',
            builder: (context, state) {
              final id = state.pathParameters['itemId']!;
              return MediaDetailScreen(itemId: id);
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

      if (isLoading) return null;
      if (!isAuthenticated && !isOnLogin) return AppRoutes.login;
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

class _AuthStateListenable extends ChangeNotifier {
  _AuthStateListenable(Ref ref) {
    ref.listen(authProvider, (_, _) => notifyListeners());
  }
}
