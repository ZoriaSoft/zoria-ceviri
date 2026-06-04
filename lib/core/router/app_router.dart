import 'package:go_router/go_router.dart';

import '../../features/history/presentation/screens/history_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/result/presentation/screens/result_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';
import '../../shared/widgets/root_shell.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      ShellRoute(
        builder: (context, state, child) => RootShell(child: child),
        routes: [
          GoRoute(
            path: '/',
            name: 'home',
            builder: (c, s) => const HomeScreen(),
            routes: [
              GoRoute(
                path: 'result',
                name: 'result',
                builder: (c, s) => const ResultScreen(),
              ),
            ],
          ),
          GoRoute(
            path: '/history',
            name: 'history',
            builder: (c, s) => const HistoryScreen(),
          ),
          GoRoute(
            path: '/settings',
            name: 'settings',
            builder: (c, s) => const SettingsScreen(),
          ),
        ],
      ),
    ],
  );
}
