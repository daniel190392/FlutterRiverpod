import 'package:go_router/go_router.dart';
import 'package:example_riverpod/presentation/screens/screens.dart';

final appRouter = GoRouter(
  initialLocation: '/authentication',
  routes: [
    GoRoute(
      path: '/authentication',
      name: AuthenticationScreen.name,
      builder: (context, state) => const AuthenticationScreen(),
    ),
    GoRoute(
      path: '/aparments',
      name: AparmentsScreen.name,
      builder: (context, state) => const AparmentsScreen(),
    )
  ],
);
