import 'package:flutter/material.dart';
import 'package:qanaty/core/theme/app_style.dart';

import 'commande_detail_dialog.dart';

class FactureImprimerWidget extends StatelessWidget {
  final String etat;
  final String nCommande;
  final String nClient;
  final String quantite;
  final String montant;
  final String produit;
  final String date;
  final String pallete;
  final String livre;
  final String slot;
  final VoidCallback onPressed; // callback pour le bouton

  const FactureImprimerWidget({
    super.key,
    required this.etat,
    required this.nCommande,
    required this.nClient,
    required this.quantite,
    required this.produit,
    required this.livre,
    required this.pallete,
    required this.montant,
    required this.date,
    required this.slot,
    required this.onPressed,
  });
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
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text("Date", style: Appstyle.textS.copyWith(color: Appstyle.grisC)),
                  Text(date, style: Appstyle.textM_B.copyWith(color: Appstyle.noir)),
                ],
              ),
              Column(
                children: [
                  Text("Quantité", style: Appstyle.textS.copyWith(color: Appstyle.grisC)),
                  Text(quantite, style: Appstyle.textL_B.copyWith(color: Appstyle.blueF)),
                ],
              ),
              Column(
                children: [
                  Text("Produit", style: Appstyle.textS.copyWith(color: Appstyle.grisC)),
                  Text(produit, style: Appstyle.textM_B.copyWith(color: Appstyle.noir)),
                ],
              ),
              Column(
                children: [
                  Text("Montant", style: Appstyle.textS.copyWith(color: Appstyle.grisC)),
                  Text(montant, style: Appstyle.textM_B.copyWith(color: Appstyle.noir)),
                ],
              ),
              Column(
                children: [
                  Text("Palette", style: Appstyle.textS.copyWith(color: Appstyle.grisC)),
                  Text(pallete, style: Appstyle.textM_B.copyWith(color: Appstyle.noir)),
                ],
              ),
              Column(
                children: [
                  Text("Livrée le", style: Appstyle.textS.copyWith(color: Appstyle.grisC)),
                  Text(livre, style: Appstyle.textM_B.copyWith(color: Appstyle.noir)),
                ],
              ),

              // 🔥 Remplacement du Container par un bouton cliquable
              ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Appstyle.rose, // couleur rose
                  minimumSize: const Size(120, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 6, // effet shadow similaire
                  shadowColor: Appstyle.gris.withOpacity(0.3),
                ),
                child: Text(
                  "Imprimer", // le texte dynamique
                  style: Appstyle.textM_B.copyWith(color: Appstyle.blanc),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
