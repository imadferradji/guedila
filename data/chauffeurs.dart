// Mock data as fallback
List<Map<String, dynamic>> chauffeurs = [
  {
    'id': 1,
    'nom': 'Mohamed Benali',
    'date': '15/05/1985',
    'npermis': 'AB123456',
    'ntelephone': '05 12 34 56 78',
    'etat': 'Actif',
  },
  // Add more mock data...
];

// Data model class
class Chauffeur {
  final int id;
  final String nom;
  final String date;
  final String npermis;
  final String ntelephone;
  final String etat;

  Chauffeur({
    required this.id,
    required this.nom,
    required this.date,
    required this.npermis,
    required this.ntelephone,
    required this.etat,
  });

  factory Chauffeur.fromJson(Map<String, dynamic> json) {
    return Chauffeur(
      id: json['id'] ?? 0,
      nom: json['nom'] ?? json['name'] ?? '',
      date: json['date'] ?? json['date_naissance'] ?? '',
      npermis: json['npermis'] ?? json['numero_permis'] ?? '',
      ntelephone: json['ntelephone'] ?? json['telephone'] ?? '',
      etat: json['etat'] ?? json['statut'] ?? 'Actif',
    );
  }
}