import 'package:go_router/go_router.dart';
import 'package:task_hive/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:task_hive/features/auth/presentation/screens/signin_screen.dart';
import 'package:task_hive/features/onboarding/presentation/screens/onboard_screen_1.dart';
import 'package:task_hive/features/onboarding/presentation/screens/onboard_screen_2.dart';
import 'package:task_hive/features/onboarding/presentation/screens/splash_screen.dart';

import '../../features/onboarding/presentation/screens/onboard_screen_3.dart';
import 'error_page.dart';
import 'routes.dart';

class MyRouterConfig {
  static final router = GoRouter(
    errorBuilder: (context, state) {
      return const ErrorPage();
    },
    initialLocation: MyRoutes.initialRoute,
    routes: [
      GoRoute(
        path: MyRoutes.initialRoute,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: "/${MyRoutes.onboard1}",
        builder: (context, state) => OnboardScreen1(),
        routes: [
          GoRoute(
            path: "/${MyRoutes.onboard2}",
            builder: (context, state) => OnboardScreen2(),
            routes: [
              GoRoute(
                path: "/${MyRoutes.onboard3}",
                builder: (context, state) => OnboardScreen3(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: "/${MyRoutes.signInRoute}",
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: "/${MyRoutes.signUpRoute}",
        builder: (context, state) => const SignUpScreen(),
      ),
    ],
  );
}
