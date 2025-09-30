import 'package:flutter/material.dart';
import 'package:qanaty/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: false,
      title: 'Portail Client',
      theme: ThemeData(
        primarySwatch: Colors.blue

      ),
    );
  }
}

