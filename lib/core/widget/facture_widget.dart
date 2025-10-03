import 'package:flutter/material.dart';
import 'package:qanaty/core/theme/app_style.dart';

class FactureWidget extends StatelessWidget {
  final String quantite; // Exemple : "0.33Cl"
  final String montant;   // Exemple : "181 Palette"
  final String produit;   // Exemple : "181 Palette"
  final String date;   // Exemple : "181 Palette"
  final String pallete;   // Exemple : "181 Palette"
  final String livre;   // Exemple : "181 Palette"
  final String etat;   // Exemple : "181 Palette"

  const FactureWidget({
    super.key,
    required this.quantite,
    required this.produit,
    required this.livre,
    required this.pallete,
    required this.montant,
    required this.date,
    required this.etat,
  });
  Color getEtatColor(String etat) {
    switch (etat) {
      case "Permis":
        return Appstyle.gris;
      case "Validé":
        return Appstyle.vert;
      case "Livrée":
        return Appstyle.blueC;
      case "En attente":
        return Appstyle.gold;
      default:
        return Appstyle.gris; // couleur par défaut
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1600,
      height: 80,
      decoration: BoxDecoration(
        color: Appstyle.grisSC,
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
        padding: const EdgeInsets.fromLTRB(20,10,20,10),
        child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
          children: [
                Column(children: [
                  Text(
                    "Date", // "0.33Cl"
                    style: Appstyle.textS.copyWith(color: Appstyle.grisC),
                  ),
                  Text(
                    date, // "0.33Cl"
                    style: Appstyle.textM_B.copyWith(color: Appstyle.noir),
                    textAlign: TextAlign.center,
                  ),

                ],),
                Column(children: [
                  Text(
                    "Quantité", // "0.33Cl"
                    style: Appstyle.textS.copyWith(color: Appstyle.grisC),
                  ),  Text(
                    quantite, // "181 Palette"
                    style: Appstyle.textL_B.copyWith(color: Appstyle.blueF),
                    textAlign: TextAlign.center,
                  ),

                ],),
                Column(children: [
                  Text(
                    "Produit", // "0.33Cl"
                    style: Appstyle.textS.copyWith(color: Appstyle.grisC),
                  ),
                  Text(
                    produit, // "181 Palette"
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
                Column(children: [
                  Text(
                    "Palette", // "0.33Cl"
                    style: Appstyle.textS.copyWith(color: Appstyle.grisC),
                  ),Text(
                    pallete, // "181 Palette"
                    style: Appstyle.textM_B.copyWith(color: Appstyle.noir),
                    textAlign: TextAlign.center,
                  ),
                ],),
                Column(children: [
                  Text(
                    "Livrée le", // "0.33Cl"
                    style: Appstyle.textS.copyWith(color: Appstyle.grisC),
                  ), Text(
                    livre, // "181 Palette"
                    style: Appstyle.textM_B.copyWith(color: Appstyle.noir),
                    textAlign: TextAlign.center,
                  ),
                ],),
            Container(
              width: 120,
              height: 40,
              decoration: BoxDecoration(
                color: getEtatColor(etat),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  etat,
                  style: Appstyle.textM_B.copyWith(color: Appstyle.blanc),
                ),
              ),
            ),



          ],
            ),

      ),
    );
  }
}
