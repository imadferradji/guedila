class Virement {
  final String numero;
  final double montant;
  final String date;
  final String etat; // ex: "En attente", "Confirmé", "Échoué"
  final String? imagePath; // chemin du reçu (optionnel)

  Virement({
    required this.numero,
    required this.montant,
    required this.date,
    required this.etat,
    this.imagePath,
  });
}
