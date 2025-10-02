import 'package:flutter/material.dart';
import 'package:qanaty/router.dart';
import 'package:qanaty/screens/auth/login_page.dart';
import 'package:qanaty/screens/commande/commande_page.dart';
import 'package:qanaty/screens/document/document_page.dart';
import 'package:qanaty/screens/virement/virement_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: false,
      title: 'Portail Client',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      builder: (context, child) {
        // On insère le container responsive comme wrapper global
        return Scaffold(
          body: Center(
            child: DocumentPage(), // 👈 notre widget
          ),
        );
      },
    );
  }
}

class ResponsiveContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double screenWidth = size.width;
    double screenHeight = size.height;

    // Responsive par défaut
    double containerWidth = screenWidth * 0.5;
    double containerHeight = screenHeight * 0.5;

    // Si l’écran est petit (<1200x800) → taille fixe
    if (screenWidth < 1200 || screenHeight < 800) {
      containerWidth = 600;
      containerHeight = 400;
    }

    return Container(
      width: containerWidth,
      height: containerHeight,
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Center(
        child: Text(
          "Container Responsive",
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
      ),
    );
  }
}