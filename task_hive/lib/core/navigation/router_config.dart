import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:task_hive/core/navigation/dummy_pages/dummy_page_1.dart';

import '../../features/auth/presentation/screens/forget_pass_screen.dart';
import '../../features/auth/presentation/screens/sign_up_screen.dart';
import '../../features/auth/presentation/screens/signin_screen.dart';
import '../../features/home/presentation/screens/projects_screen.dart';
import '../../features/onboarding/presentation/screens/onboard_screen_1.dart';
import '../../features/onboarding/presentation/screens/onboard_screen_2.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/project_details/presentation/screens/task_create_screen.dart';
import '../../features/project_details/presentation/screens/TaskDetailsScreen.dart';
import '../../features/project_details/presentation/screens/dashboard_screen.dart';
import '../../features/onboarding/presentation/screens/onboard_screen_3.dart';
import 'error_page.dart';
import 'nav_bar.dart';
import 'routes.dart';

class MyRouterConfig {
  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();

  static void refresh() {
    router.go(MyRoutes.profile);
  }

  static final router = GoRouter(
    navigatorKey: rootNavigatorKey,
    observers: [MyRouterObserver()],
    errorBuilder: (context, state) {
      return const ErrorPage();
    },
    redirect: (context, state) {
      print('dbg state location: ${state.fullPath}');
      final isLoggedIn = Supabase.instance.client.auth.currentSession != null;
      final isOnboarding = state.uri.toString().contains(MyRoutes.onboard1) ||
          state.uri.toString().contains(MyRoutes.onboard2) ||
          state.uri.toString().contains(MyRoutes.onboard3);
      print('dbg isLoggedIn: $isLoggedIn');
      print('dbg isOnboarding: $isOnboarding');
      if (isLoggedIn && isOnboarding) {
        return MyRoutes.home;
      }
      if (isLoggedIn && !isOnboarding) {
        return (state.fullPath == null || state.fullPath!.isEmpty)
            ? MyRoutes.home
            : state.fullPath!;
      }
      if (!isLoggedIn && !isOnboarding) {
        return MyRoutes.signInRoute;
      }

      return null;
    },
    initialLocation: MyRoutes.initialRoute,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithNestedNavigation(
            navigationShell: navigationShell,
          );
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: MyRoutes.home,
                builder: (context, state) {
                  return const ProjectsScreen();
                },
                routes: [
                  GoRoute(
                    path: MyRoutes.projectDetails,
                    builder: (context, state) {
                      return const ProjectDetailsScreen();
                    },
                    routes: [
                      GoRoute(
                        path: MyRoutes.createTask,
                        builder: (context, state) {
                          return const CreateTaskScreen();
                        },
                        routes: [
                          GoRoute(
                            path: MyRoutes.taskDetails,
                            builder: (context, state) =>
                                const TaskDetailsPage(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: MyRoutes.dummyPage1,
                builder: (context, state) {
                  return const DummyPage1();
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: MyRoutes.profile,
                builder: (context, state) {
                  return const ProfileScreen();
                },
              ),
            ],
          ),
        ],
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
        path: MyRoutes.signInRoute,
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: "/${MyRoutes.signUpRoute}",
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: MyRoutes.forgotPassword,
        builder: (context, state) => const ForgetPasswordScreen(),
      ),
    ],
  );
}

class MyRouterObserver extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    _updateBackButtonBehavior(route);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    _updateBackButtonBehavior(previousRoute);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    _updateBackButtonBehavior(newRoute);
  }

  Future<void> _updateBackButtonBehavior(Route? route) async {
    // TODO: Implement platform-specific back-button handling (e.g. call SystemNavigator.pop on root)
  }
}
