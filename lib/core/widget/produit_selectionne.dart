import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:qanaty/core/theme/app_style.dart';

class ProduitSelectionne extends StatelessWidget {
  final String quantite;
  final String montant;
  final String produit;
  final VoidCallback? onDelete; // ✅ callback pour supprimer

  const ProduitSelectionne({
    super.key,
    required this.quantite,
    required this.produit,
    required this.montant,
    this.onDelete, // ✅ optionnel
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 450,
      height: 80,
      decoration: BoxDecoration(
        color: Appstyle.grisSC,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // --- Infos Produit ---
            Row(
              children: [
                Column(
                  children: [
                    Text("Quantité", style: Appstyle.textS.copyWith(color: Appstyle.grisC)),
                    Text(quantite, style: Appstyle.textS_B.copyWith(color: Appstyle.noir)),
                  ],
                ),
                const SizedBox(width: 20),
                Column(
                  children: [
                    Text("Produit", style: Appstyle.textS.copyWith(color: Appstyle.grisC)),
                    Text(produit, style: Appstyle.textS_B.copyWith(color: Appstyle.noir)),
                  ],
                ),
                const SizedBox(width: 20),
                Column(
                  children: [
                    Text("Montant", style: Appstyle.textS.copyWith(color: Appstyle.grisC)),
                    Text(montant, style: Appstyle.textS_B.copyWith(color: Appstyle.blueF)),
                  ],
                ),
              ],
            ),

            // --- Bouton Supprimer ---
            if (onDelete != null)
              IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: onDelete,
              ),
          ],
        ),
      ),
    );
  }
}
