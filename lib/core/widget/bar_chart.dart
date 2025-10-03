import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../data/produits.dart';

class ProduitBarChart extends StatelessWidget {
  final List<String> months; // ex: ["Sept", "Oct", "Nov"]
  final Map<String, Map<String, double>> data;
  final double scaleFactor;

  const ProduitBarChart({
    super.key,
    required this.months,
    required this.data,
    this.scaleFactor = 1.0, // default scale
  });

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        groupsSpace: 30,
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: true, reservedSize: 40),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                if (value.toInt() < months.length) {
                  return Text(months[value.toInt()]);
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        barGroups: months.asMap().entries.map((monthEntry) {
          final monthIndex = monthEntry.key;
          final monthName = monthEntry.value;
          final monthData = data[monthName] ?? {};

          final rods = produits.map((produit) {
            final value = monthData[produit.abrev] ?? 0;
            return BarChartRodData(
              toY: value * scaleFactor,
              color: produit.color,
              width: 12,
              borderRadius: BorderRadius.circular(4),
            );
          }).toList();

          return BarChartGroupData(
            x: monthIndex,
            barRods: rods,
            barsSpace: 4,
          );
        }).toList(),
      ),
    );
  }
}
