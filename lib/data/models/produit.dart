import 'dart:ui';

class Produit {
  final String nom;
  final String abrev;
  final String image;
  final int bouteillesParPalette;
  final double prix;
  final Color color;

  Produit({
    required this.nom,
    required this.abrev,
    required this.image,
    required this.bouteillesParPalette,
    required this.prix,
    required this.color,
  });
}
