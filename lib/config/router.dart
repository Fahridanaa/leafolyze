import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leafolyze/core/screens/diagnosis/camera_screen.dart';
import 'package:leafolyze/core/screens/home/article_list_screen.dart';
import 'package:leafolyze/core/screens/home/home_screen.dart';
import 'package:leafolyze/core/screens/marketplace/marketplace_screen.dart';
import 'package:leafolyze/core/screens/marketplace/product_list_screen.dart';
import 'package:leafolyze/core/screens/onboarding/splash_screen.dart';
import 'package:leafolyze/core/screens/onboarding/landing_screen.dart';
import 'package:leafolyze/core/screens/auth/login_screen.dart';
import 'package:leafolyze/core/screens/auth/register_screen.dart';
import 'package:leafolyze/core/home.dart';
import 'package:leafolyze/core/screens/profile/profile_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>();

final goRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    // Onboarding routes
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/landing',
      builder: (context, state) => const LandingScreen(),
    ),

    // Auth routes
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),

    // Main app shell route
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return Home(child: child);
      },
      routes: [
        // Home tab
        GoRoute(
          path: '/home',
          builder: (context, state) => const HomeScreen(),
          routes: [
            GoRoute(
              path: 'article',
              parentNavigatorKey: _rootNavigatorKey,
              builder: (context, state) => const ArticleListScreen(),
            ),
          ],
        ),
        GoRoute(
          path: '/diagnose',
          builder: (context, state) => const CameraScreen(),
        ),
        // Marketplace tab
        GoRoute(
          path: '/marketplace',
          builder: (context, state) => const MarketplaceScreen(),
          routes: [
            GoRoute(
              path: 'product',
              parentNavigatorKey: _rootNavigatorKey,
              builder: (context, state) => ProductListScreen(),
            ),
          ],
        ),
        // History tab
        GoRoute(
          path: '/history',
          builder: (context, state) =>
              const Center(child: Text("History Page")),
        ),
        // Profile tab
        GoRoute(
          path: '/profile',
          builder: (context, state) => const ProfileScreen(
            name: 'Muhammad Ridlo Febrio',
            email: '2241720098@gmail.com',
            profileImageUrl:
                'https://awsimages.detik.net.id/community/media/visual/2018/03/03/39f24229-6f26-4a17-aa92-44c3bd3dae9e_43.jpeg?w=600&q=90',
          ),
        ),
      ],
    ),
  ],
);
