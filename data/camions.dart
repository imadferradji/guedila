// Mock data as fallback
List<Map<String, dynamic>> camions = [
  {
    'id': 1,
    'matricule': '12345-A-56', // Changed from 'Matricule'
    'matricule_remorque': '67890-B-78', // Changed from 'Remorque'
    'type': 'Camion plateau',
    'tonnage': '25.5',
    'etat': 'Actif',
  },
  // Add more mock data...
];

// Data model class
class Camion {
  final int id;
  final String Matricule;
  final String Remorque;
  final String type;
  final String tonnage;
  final String etat;

  Camion({
    required this.id,
    required this.Matricule,
    required this.Remorque,
    required this.type,
    required this.tonnage,
    required this.etat,
  });

  factory Camion.fromJson(Map<String, dynamic> json) {
    return Camion(
      id: json['id'] ?? 0,
      Matricule: json['Matricule'] ?? json['matricule'] ?? '',
      Remorque: json['Remorque'] ?? json['matricule_remorque'] ?? '',
      type: json['type'] ?? '',
      tonnage: json['tonnage']?.toString() ?? '',
      etat: json['etat'] ?? json['statut'] ?? 'Actif',
    );
  }
}