import 'package:flutter/material.dart';
import 'package:qanaty/core/theme/app_style.dart';

class PaletteSelectionne extends StatelessWidget {
  final String quantite; // Exemple : "0.33Cl"
  final String montant;   // Exemple : "181 Palette"

  const PaletteSelectionne({
    super.key,
    required this.quantite,
    required this.montant,

  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 80,
      decoration: BoxDecoration(
        color: Appstyle.grisSC,
        borderRadius: BorderRadius.circular(16),

      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20,10,20,10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(children: [
              Text(
                "Quantité", // "0.33Cl"
                style: Appstyle.textS.copyWith(color: Appstyle.grisC),
              ),  Text(
                quantite, // "181 Palette"
                style: Appstyle.textM_B.copyWith(color: Appstyle.blueF),
                textAlign: TextAlign.center,
              ),

            ],),
            Column(children: [
              Text(
                "Produit", // "0.33Cl"
                style: Appstyle.textS.copyWith(color: Appstyle.grisC),
              ),
              Text(
                "Palette", // "181 Palette"
                style: Appstyle.textM_B.copyWith(color: Appstyle.noir),
                textAlign: TextAlign.center,
              ),
            ],),
            Column(children: [
              Text(
                "Montant", // "0.33Cl"
                style: Appstyle.textS.copyWith(color: Appstyle.grisC),
              ),
              Text(
                montant, // "181 Palette"
                style: Appstyle.textM_B.copyWith(color: Appstyle.noir),
                textAlign: TextAlign.center,
              ),
            ],),
          ],
        ),

      ),
    );
  }
}
