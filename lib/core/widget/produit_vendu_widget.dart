import 'package:flutter/material.dart';
import 'package:qanaty/core/theme/app_style.dart';

class ProduitVenduWidget extends StatelessWidget {
  final String produit; // Exemple : "0.33Cl"
  final String value;   // Exemple : "181 Palette"

  const ProduitVenduWidget({
    super.key,
    required this.produit,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 140,
      decoration: BoxDecoration(
        color: Appstyle.blanc,
        borderRadius: BorderRadius.circular(16),

      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Cercle avec texte au centre
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Appstyle.blueF, // couleur harmonisée
                width: 3,
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              produit, // "0.33Cl"
              style: Appstyle.textS_B.copyWith(color: Appstyle.noir),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 12),
          // Texte du bas
          Text(
            value, // "181 Palette"
            style: Appstyle.textM_B.copyWith(color: Appstyle.noir),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
