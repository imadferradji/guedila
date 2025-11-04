import 'package:go_router/go_router.dart';
import 'package:qanaty/all_screens/guedila_screens/commande.dart';
import 'package:qanaty/all_screens/guedila_screens/produit.dart';
import 'all_screens/client_screens/auth/sign_up.dart';
import 'all_screens/client_screens/commande/commande_page.dart';
import 'all_screens/client_screens/dashboard/dashboard_page.dart';
import 'all_screens/client_screens/document/document_page.dart';
import 'all_screens/client_screens/driver_truck/driver_truck.dart';
import 'all_screens/client_screens/profile/profile_page.dart';
import 'all_screens/client_screens/virement/virement_page.dart';
import 'all_screens/guedila_screens/comptes.dart';
import 'all_screens/guedila_screens/dashboard.dart';
import 'all_screens/guedila_screens/document.dart';
import 'all_screens/guedila_screens/driver_truck.dart';
import 'all_screens/guedila_screens/planning.dart';
import 'all_screens/guedila_screens/profile.dart';
import 'all_screens/guedila_screens/programmation.dart';
import 'all_screens/guedila_screens/tarif.dart';
import 'all_screens/guedila_screens/virment.dart';

// Import des pages

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/', // Écran par défaut au démarrage
    routes: [
      GoRoute(
        path: '/planningCompany',
        builder: (context, state) =>  PlanningCompany(),
      ),
      GoRoute(
        path: '/tarifCompany',
        builder: (context, state) =>  TarificationPageC(),
      ),
      GoRoute(
        path: '/programmationCompany',
        builder: (context, state) =>  ProgrammationPageC(),
      ),
      GoRoute(
        path: '/drivertruckCompany',
        builder: (context, state) =>  DriverTruckPageC(),
      ),
      GoRoute(
        path: '/produitCompany',
        builder: (context, state) =>  ProduitsC(),
      )
      ,
      GoRoute(
        path: '/commandeCompany',
        builder: (context, state) =>  CommandePageC(),
      ),
      GoRoute(
        path: '/comptesCompany',
        builder: (context, state) =>  Comptes(),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) =>  Dashboardcomany(),
      ),
      GoRoute(
        path: '/documentCompany',
        builder: (context, state) =>  DocumentPageC(),
      ),
      GoRoute(
        path: '/profileCompany',
        builder: (context, state) {
          final tab = int.tryParse(state.uri.queryParameters['tab'] ?? "0") ?? 0;
          return ProfilePageC(initialIndex: tab);
        },
      ),

      GoRoute(
        path: '/virmentCompany',
        builder: (context, state) =>  VirmentPageC(),
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) =>  SignUpPage(),
      ),
      GoRoute(
        path: '/dash',
        builder: (context, state) =>  DashboardPage(),
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
        builder: (context, state) {
          final tab = int.tryParse(state.uri.queryParameters['tab'] ?? "0") ?? 0;
          return ProfilePage(initialIndex: tab);
        },
      ),
    ],
  );
}
