class Facture {
  final String id;
  final String quantite;
  final String produit;
  final String dateLivraison;
  final String pallete;
  final String montant;
  final String dateCommande;
  final String etat;

  Facture({
    required this.id,
    required this.quantite,
    required this.produit,
    required this.dateLivraison,
    required this.pallete,
    required this.montant,
    required this.dateCommande,
    required this.etat,
  });

  factory Facture.fromJson(Map<String, dynamic> json) {
    return Facture(
      id: json['id']?.toString() ?? 'N/A',
      quantite: json['quantite']?.toString() ?? '0',
      produit: json['produit']?.toString() ?? 'Produit non spécifié',
      dateLivraison: json['dateLivraison']?.toString() ?? 'Non livré',
      pallete: json['pallete']?.toString() ?? 'Non',
      montant: json['montant']?.toString() ?? '0.00',
      dateCommande: json['dateCommande']?.toString() ?? 'Date inconnue',
      etat: json['etat']?.toString() ?? 'En attente',
    );
  }
}