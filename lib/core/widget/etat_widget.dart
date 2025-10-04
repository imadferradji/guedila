import 'package:flutter/material.dart';
import 'package:qanaty/core/theme/app_style.dart';

class EtatWidget extends StatefulWidget {
  final int initialSelectedIndex;

  const EtatWidget({super.key, this.initialSelectedIndex = 1, required Null Function(dynamic index) onChanged});

  @override
  State<EtatWidget> createState() => _EtatWidget();
}

class _EtatWidget extends State<EtatWidget> {
  late int selectedIndex;
  final List<String> items = ["Etat de Chargemnet", "Facture"];

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialSelectedIndex;
  }

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