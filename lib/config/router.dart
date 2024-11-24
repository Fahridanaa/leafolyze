import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leafolyze/core/screens/diagnosis/camera_screen.dart';
import 'package:leafolyze/core/screens/history/history_screen.dart';
import 'package:leafolyze/core/screens/home/article_detail_screen.dart';
import 'package:leafolyze/core/screens/home/article_list_screen.dart';
import 'package:leafolyze/core/screens/home/home_screen.dart';
import 'package:leafolyze/core/screens/marketplace/marketplace_detail_screen.dart';
import 'package:leafolyze/core/screens/marketplace/marketplace_screen.dart';
import 'package:leafolyze/core/screens/marketplace/product_list_screen.dart';
import 'package:leafolyze/core/screens/onboarding/landing_screen.dart';
import 'package:leafolyze/core/screens/onboarding/splash_screen.dart';
import 'package:leafolyze/core/screens/auth/login_screen.dart';
import 'package:leafolyze/core/screens/auth/register_screen.dart';
import 'package:leafolyze/core/home.dart';
import 'package:leafolyze/core/screens/profile/about_screen.dart';
import 'package:leafolyze/core/screens/profile/faq_screen.dart';
import 'package:leafolyze/core/screens/profile/personal_information_screen.dart';
import 'package:leafolyze/core/screens/profile/profile_screen.dart';
import 'package:leafolyze/core/screens/profile/reset_password_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>();

final goRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/landing',
      builder: (context, state) => const LandingScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return Home(child: child);
      },
      routes: [
        GoRoute(
          path: '/home',
          builder: (context, state) => const HomeScreen(),
          routes: [
            GoRoute(
              path: 'article',
              parentNavigatorKey: _rootNavigatorKey,
              builder: (context, state) => const ArticleListScreen(),
              routes: [
                GoRoute(
                  path: ':id',
                  parentNavigatorKey: _rootNavigatorKey,
                  builder: (context, state) => ArticleDetailScreen(
                    id: int.parse(state.pathParameters['id']!),
                  ),
                ),
              ],
            ),
          ],
        ),
        GoRoute(
          path: '/diagnose',
          builder: (context, state) => const CameraScreen(),
        ),
        GoRoute(
          path: '/marketplace',
          builder: (context, state) => const MarketplaceScreen(),
          routes: [
            GoRoute(
              path: ':diseaseId',
              parentNavigatorKey: _rootNavigatorKey,
              builder: (context, state) {
                final diseaseId = state.pathParameters['diseaseId'];
                if (diseaseId == null) {
                  return const Center(child: Text('Disease ID is missing.'));
                }
                return ProductListScreen(diseaseId: int.parse(diseaseId));
              },
              routes: [
                GoRoute(
                    path: 'detail',
                    parentNavigatorKey: _rootNavigatorKey,
                    builder: (context, state) => MarketplaceDetailScreen(
                          id: state.pathParameters['id']!,
                        )),
              ],
            ),
          ],
        ),
        GoRoute(
          path: '/history',
          builder: (context, state) => const HistoryScreen(),
        ),
        GoRoute(
            path: '/profile',
            builder: (context, state) => const ProfileScreen(),
            routes: [
              GoRoute(
                path: 'faq',
                parentNavigatorKey: _rootNavigatorKey,
                builder: (context, state) => FaqScreen(),
              ),
              GoRoute(
                path: 'about',
                parentNavigatorKey: _rootNavigatorKey,
                builder: (context, state) => AboutScreen(),
              ),
              GoRoute(
                path: 'personal-information',
                parentNavigatorKey: _rootNavigatorKey,
                builder: (context, state) => PersonalInformationScreen(),
              ),
              GoRoute(
                path: 'password-security',
                parentNavigatorKey: _rootNavigatorKey,
                builder: (context, state) => ResetPasswordScreen(),
              ),
            ]),
      ],
    ),
  ],
);
