import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qanaty/screens/auth/login_page.dart';
import 'package:qanaty/screens/auth/sign_up.dart';
import 'package:qanaty/screens/commande/commande_page.dart';
import 'package:qanaty/screens/dashboard/dashboard_page.dart';
import 'package:qanaty/screens/document/document_page.dart';
import 'package:qanaty/screens/profile/profile_page.dart';
import 'package:qanaty/screens/virement/virement_page.dart';

// Import des pages

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/', // Écran par défaut au démarrage
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) => const SignUpPage(),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => const DashboardPage(),
      ),
      GoRoute(
        path: '/commande',
        builder: (context, state) => const CommandePage(),
      ),
      GoRoute(
        path: '/document',
        builder: (context, state) => const DocumentPage(),
      ),
      GoRoute(
        path: '/virement',
        builder: (context, state) => const VirementPage(),
      ),

      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfilePage(),
      ),
    ],
  );
}
