import 'package:flutter/material.dart';
import 'package:qanaty/core/theme/app_style.dart';

import 'commande_detail_dialog.dart';

class FactureWidget extends StatelessWidget {
  final String nCommande;
  final String nClient;
  final String quantite; // Exemple : "0.33Cl"
  final String montant;   // Exemple : "181 Palette"
  final String produit;   // Exemple : "181 Palette"
  final String date;   // Exemple : "181 Palette"
  final String pallete;   // Exemple : "181 Palette"
  final String livre;   // Exemple : "181 Palette"
  final String etat;   // Exemple : "181 Palette"
  final String slot;   // Exemple : "181 Palette"

  const FactureWidget({
    super.key,
    required this.nClient,
    required this.nCommande,
    required this.quantite,
    required this.produit,
    required this.livre,
    required this.pallete,
    required this.montant,
    required this.date,
    required this.etat,
    required this.slot,
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
  void _showDetailDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => DetailFactureDialog(
        etat:etat,
        date: date,
        nCommande: nCommande,
        client: nClient,
        produit: produit,
        quantite: quantite,
        palette: pallete=="Oui"?true:false,
        montant: montant,
        livre: livre, slot: slot,
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:() => _showDetailDialog(context),
      child: Container(
        width: 1600,
        height: 80,
        decoration: BoxDecoration(
          color: Appstyle.blanc,
          borderRadius: BorderRadius.circular(16),

        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20,10,20,10),
          child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Etat
                 Expanded(
                   flex: 2,
                   child: Column(children: [
                                   Text(
                    "Etat", // "0.33Cl"
                    style: Appstyle.textS.copyWith(color: Appstyle.grisC),
                                   ),
                                   Text(
                    etat, // "181 Palette"
                    style: Appstyle.textM_B.copyWith(color: Appstyle.noir),
                    textAlign: TextAlign.center,
                                   ),
                                 ],),
                 ),

              // Date
                  Expanded(
                    flex: 3,
                    child: Column(children: [
                      Text(
                        "Date",
                        style: Appstyle.textS.copyWith(color: Appstyle.grisC),
                      ),
                      Text(
                        date,
                        style: Appstyle.textM_B.copyWith(color: Appstyle.noir),
                        textAlign: TextAlign.center,
                      ),

                    ],),
                  ),
                  // N commande
                   Expanded(
                     flex: 3,
                     child: Column(children: [
                                     Text(
                                       "Commande", // "0.33Cl"
                                       style: Appstyle.textS.copyWith(color: Appstyle.grisC),
                                     ),Text(
                                       nCommande, // "181 Palette"
                                       style: Appstyle.textM_B.copyWith(color: Appstyle.noir),
                                       textAlign: TextAlign.center,
                                     ),
                                   ],),
                   ),

                  //Produit
                   Expanded(
                     flex: 2,
                     child: Column(children: [
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
                   ),

                 //Qunatité

                   Expanded(
                     flex: 2,
                     child: Column(children: [
                                     Text(
                                       "Quantité", // "0.33Cl"
                                       style: Appstyle.textS.copyWith(color: Appstyle.grisC),
                                     ),  Text(
                                       quantite, // "181 Palette"
                                       style: Appstyle.textL_B.copyWith(color: Appstyle.blueF),
                                       textAlign: TextAlign.center,
                                     ),

                                   ],),
                   ),

                  //Pallete
                 Expanded(
                   flex: 2,
                   child: Column(children: [
                                   Text(
                    "Palette", // "0.33Cl"
                    style: Appstyle.textS.copyWith(color: Appstyle.grisC),
                                   ),Text(
                    pallete, // "181 Palette"
                    style: Appstyle.textM_B.copyWith(color: Appstyle.noir),
                    textAlign: TextAlign.center,
                                   ),
                                 ],),
                 ),

                  //Montant
                  Expanded(
                    flex: 3,
                    child: Column(children: [
                                    Text(
                    "Montant", // "0.33Cl"
                    style: Appstyle.textS.copyWith(color: Appstyle.grisC),
                                    ),
                                    Text(
                    montant, // "181 Palette"
                    style: Appstyle.textM_B.copyWith(color: Appstyle.blueF),
                    textAlign: TextAlign.center,
                                    ),
                                  ],),
                  ),

                  //Montant
                  Expanded(
                    flex: 3,
                    child: Column(children: [
                                    Text(
                    "Slot", // "0.33Cl"
                    style: Appstyle.textS.copyWith(color: Appstyle.grisC),
                                    ),
                                    Text(
                    slot, // "181 Palette"
                    style: Appstyle.textM_B.copyWith(color: Appstyle.noir),
                    textAlign: TextAlign.center,
                                    ),
                                  ],),
                  ),
                // Date livraison
                  Expanded(
                    flex: 3,
                    child: Column(
                                    children: [
                    Text(
                      "Livrée le",
                      style: Appstyle.textS.copyWith(color: Appstyle.grisC),
                    ),
                    livre.isEmpty
                        ? const SizedBox(width: 120)
                        : Text(
                      livre,
                      style: Appstyle.textM_B.copyWith(color: Appstyle.noir),
                      textAlign: TextAlign.center,
                    ),
                                    ],
                                  ),
                  )


            ],
              ),

        ),
      ),
    );
  }
}
