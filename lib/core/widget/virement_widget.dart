import 'package:flutter/material.dart';
import 'package:qanaty/core/theme/app_style.dart';

class VirementWidget extends StatelessWidget {
  final String numero; // Exemple : "0.33Cl"
  final String montant;   // Exemple : "181 Palette"
  final String date;   // Exemple : "181 Palette"
  final String etat;   // Exemple : "181 Palette"

  const VirementWidget({
    super.key,
    required this.numero,
    required this.montant,
    required this.date,
    required this.etat,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      height: 170,
      decoration: BoxDecoration(
        color: Appstyle.blanc,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Appstyle.gris.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10,5,6,5),
        child: Row(
          children: [

            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Numéro :", // "0.33Cl"
                  style: Appstyle.textM_B.copyWith(color: Appstyle.grisC),
                ),
                // Cercle avec texte au centre
                const SizedBox(height: 12),
                // Texte du bas
                Text(
                  "Montant:", // "181 Palette"
                  style: Appstyle.textM_B.copyWith(color: Appstyle.grisC),
                ),
                const SizedBox(height: 12),
                Text(
                  "Date :", // "181 Palette"
                  style: Appstyle.textM_B.copyWith(color: Appstyle.grisC),
                ),
                const SizedBox(height: 12),
                Text(
                  "Etat :", // "181 Palette"
                  style: Appstyle.textM_B.copyWith(color: Appstyle.grisC),
                ),
              ],
            ),
        SizedBox(width: 20,),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  numero, // "0.33Cl"
                  style: Appstyle.textM_B.copyWith(color: Appstyle.noir),
                  textAlign: TextAlign.center,
                ),
                // Cercle avec texte au centre
                const SizedBox(height: 6),
                // Texte du bas
                Text(
                  montant, // "181 Palette"
                  style: Appstyle.textL_B.copyWith(color: Appstyle.blueF),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  date, // "181 Palette"
                  style: Appstyle.textM_B.copyWith(color: Appstyle.noir),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  etat, // "181 Palette"
                  style: etat=="En attente"?Appstyle.textM_B.copyWith(color: Appstyle.gold):Appstyle.textM_B.copyWith(color: Appstyle.vert),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
