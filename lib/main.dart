import 'package:flutter/material.dart';
import 'widgets/purchase.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Test Purchase Widget',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Commande"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Purchase(
          nomproduit: "Bouteille d'eau 0.50 Litre",
          palette: "100 fardos (6 bouteilles)",
          prix: 22800,
        ),
      ),
    );
  }
}
