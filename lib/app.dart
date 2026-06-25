import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';

class JellyfinApp extends ConsumerWidget {
  const JellyfinApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'Jellyfin',
      debugShowCheckedModeBanner: false,

      // Material theme (Android)
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,

      // Router
      routerConfig: router,

      // Wrap with CupertinoTheme so iOS widgets also get themed
      builder: (context, child) {
        return CupertinoTheme(data: AppTheme.cupertinoTheme, child: child!);
      },
    );
  }
}
