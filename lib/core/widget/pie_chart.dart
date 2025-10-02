import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../data/produits.dart'; // ✅ pour accéder à la liste `produits`

class ProduitPieChart extends StatelessWidget {
  final Map<String, double> data;

  const ProduitPieChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        sections: data.entries.map((entry) {
          // Trouver le produit avec la même abréviation
          final produit = produits.firstWhere(
                (p) => p.abrev == entry.key,
            orElse: () => produits[0], // fallback si non trouvé
          );

          return PieChartSectionData(
            value: entry.value,
            // 👇 On ajoute l’abréviation entre parenthèses
            title: "${entry.value.toInt()} (${produit.abrev})",
            color: produit.color,
            radius: 100,
            titleStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          );
        }).toList(),
        centerSpaceRadius: 40,
        sectionsSpace: 4,
      ),
    );
  }
}
