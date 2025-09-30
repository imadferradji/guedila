import 'package:flutter/material.dart';
import 'package:qanaty/core/theme/app_style.dart';

class PeriodSelector extends StatefulWidget {
  const PeriodSelector({super.key});

  @override
  State<PeriodSelector> createState() => _PeriodSelectorState();
}

class _PeriodSelectorState extends State<PeriodSelector> {
  int selectedIndex = 2; // Par défaut : Par Mois

  final List<String> items = ["Aujourd'hui", "Par Semaine", "Par Mois"];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(items.length, (index) {
          final isSelected = index == selectedIndex;
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: isSelected ? Appstyle.blueF : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                items[index],
                style:Appstyle.textM.copyWith(color: isSelected?Appstyle.blanc:Appstyle.gris)

              ),
            ),
          );
        }),
      ),
    );
  }
}
