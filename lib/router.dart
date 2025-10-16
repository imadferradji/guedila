// router.dart
import 'package:go_router/go_router.dart';
import 'package:qanaty/screens/SuccessScreen.dart';
import 'package:qanaty/screens/auth/login_page.dart';
import 'package:qanaty/screens/auth/sign_up.dart';
import 'package:qanaty/screens/commande/commande_page.dart';
import 'package:qanaty/screens/dashboard/dashboard_page.dart';
import 'package:qanaty/screens/document/document_page.dart';
import 'package:qanaty/screens/driver_truck/driver_truck.dart';
import 'package:qanaty/screens/login.dart'; // Your login page
import 'package:qanaty/screens/profile/profile_page.dart';
import 'package:qanaty/screens/virement/virement_page.dart';

import 'company side/screnns/commande/commande.dart';
import 'company side/screnns/comptes/comptes.dart';
import 'company side/screnns/dashboard/dashboard.dart';
import 'company side/screnns/document/document.dart';
import 'company side/screnns/profile/profile.dart';
import 'company side/screnns/virment/virment.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/success',
        builder: (context, state) => SuccessScreen(),
      ),

      GoRoute(
        path: '/',
        builder: (context, state) =>  Login(), // Your login page
      ),
      GoRoute(
        path: '/dashboard',
        builder: (context, state) {
          final userData = state.extra as Map<String, dynamic>? ?? {};
          return DashboardPage(userData: userData);
          },
      ),
      GoRoute(
        path: '/dashbordCompany',
        builder: (context, state) =>  Dashboardcomany(),
      ),
      GoRoute(
        path: '/documentCompany',
        builder: (context, state) =>  DocumentPageC(),
      ),
      GoRoute(
        path: '/profileC',
        builder: (context, state) =>  ProfilePageC(),
      ),
      GoRoute(
        path: "/Virmentcompany",
        builder: (context, state) =>  VirmentPageC(),
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) =>  SignUpPage(),
      ),
      GoRoute(
        path: '/comptes',
        builder: (context, state) =>  Comptes(),
      ),
      GoRoute(
        path: "/CommandeCompany",
        builder: (context, state) =>  CommandePageC(),
      ),
      GoRoute(
        path: '/commande',
        builder: (context, state) =>  CommandePage(),
      ),
      GoRoute(
        path: '/document',
        builder: (context, state) =>  DocumentPage(),
      ),
      GoRoute(
        path: '/virement',
        builder: (context, state) =>  VirementPage(),
      ),
      GoRoute(
        path: '/drivertruck',
        builder: (context, state) =>  DriverTruckPage(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) =>  ProfilePage(),
      ),
    ],
  );
}