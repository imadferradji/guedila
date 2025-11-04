import 'dart:ui';

class Planning {
  final String date;
  final String produit;
  final String quantite;
  final String etat;
  final List<int> slots; // ➕ Ajout du champ slots

  Planning({
    required this.date,
    required this.produit,
    required this.quantite,
    required this.etat,
    required this.slots, // ➕ Ajout dans le constructeur
  });
}
