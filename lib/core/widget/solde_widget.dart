import 'package:flutter/material.dart';
import 'package:qanaty/core/theme/app_style.dart';

class SoldeWidget extends StatelessWidget {
  final String solde; // Exemple : "0.33Cl"
  final String dernier_modif;   // Exemple : "181 Palette"

  const SoldeWidget({
    super.key,
    required this.solde,
    required this.dernier_modif,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      height: 120,
      decoration: BoxDecoration(
        color: Appstyle.blanc,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Appstyle.gris.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10,5,6,5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              solde, // "0.33Cl"
              style: Appstyle.textL_B.copyWith(color: Appstyle.blueF),
              textAlign: TextAlign.center,
            ),
            // Cercle avec texte au centre
            // Texte du bas
            Text(
              "Solde", // "181 Palette"
              style: Appstyle.textM_B.copyWith(color: Appstyle.noir),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              dernier_modif, // "181 Palette"
              style: Appstyle.textS_B.copyWith(color: Appstyle.noir),
              textAlign: TextAlign.center,
            ), Text(
             "Dernier modification", // "181 Palette"
              style: Appstyle.textS_B.copyWith(color: Appstyle.noir),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
