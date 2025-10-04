import 'package:flutter/material.dart';
import 'core/widget/camion_dialog.dart';
import 'core/widget/chauffer_dialog.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestion Flotte',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: GestionFlottePage(),
    );
  }
}

class GestionFlottePage extends StatefulWidget {
  @override
  _GestionFlottePageState createState() => _GestionFlottePageState();
}

class _GestionFlottePageState extends State<GestionFlottePage> {
  int _currentIndex = 0;
  List<Map<String, String>> chauffeurs = [];
  List<Map<String, String>> camions = [];

  void _openChauffeurDialog() {
    showNewDriverDialog(context, () {
      if (fullNameController.text.isNotEmpty) {
        setState(() {
          chauffeurs.add({
            'name': fullNameController.text,
            'license': licenseNumberController.text,
            'birthDate': birthDateController.text,
            'phone': phoneNumberController.text,
          });
          _clearChauffeurControllers();
        });
      }
    });
  }

  void _openCamionDialog() {
    showNewCamionDialog(context, () {
      if (matriculeController.text.isNotEmpty) {
        setState(() {
          camions.add({
            'matricule': matriculeController.text,
            'tonnage': '${tonnageController.text} tonnes',
            'type': selectedTypeCamion ?? 'Non spécifié',
            'marque': marqueController.text,
            'modele': modeleController.text,
            'statut': selectedStatut ?? 'Non spécifié',
          });
          _clearCamionControllers();
        });
      }
    });
  }

  void _clearChauffeurControllers() {
    fullNameController.clear();
    licenseNumberController.clear();
    birthDateController.clear();
    phoneNumberController.clear();
    driverImagePath = null;
  }

  void _clearCamionControllers() {
    matriculeController.clear();
    tonnageController.clear();
    marqueController.clear();
    modeleController.clear();
    anneeController.clear();
    couleurController.clear();
    dateMiseCirculationController.clear();
    selectedTypeCamion = null;
    selectedStatut = null;
    camionImagePath = null;
  }

  // Variables pour camion dialog (déclarées ici pour la démo)
  String? selectedTypeCamion;
  String? selectedStatut;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_currentIndex == 0 ? 'Gestion Chauffeurs' : 'Gestion Camions'),
        backgroundColor: _currentIndex == 0 ? Colors.blue : Colors.green,
        foregroundColor: Colors.white,
      ),
      body: _currentIndex == 0 ? _buildChauffeursPage() : _buildCamionsPage(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Chauffeurs',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_shipping),
            label: 'Camions',
            backgroundColor: Colors.green,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _currentIndex == 0 ? _openChauffeurDialog : _openCamionDialog,
        backgroundColor: _currentIndex == 0 ? Colors.blue : Colors.green,
        foregroundColor: Colors.white,
        child: Icon(_currentIndex == 0 ? Icons.person_add : Icons.add),
        tooltip: _currentIndex == 0 ? 'Ajouter Chauffeur' : 'Ajouter Camion',
      ),
    );
  }

  Widget _buildChauffeursPage() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Gestion des Chauffeurs',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue.shade800),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '${chauffeurs.length} chauffeur(s) enregistré(s)',
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: chauffeurs.isEmpty
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.person_outline, size: 80, color: Colors.grey.shade300),
                  SizedBox(height: 20),
                  Text('Aucun chauffeur', style: TextStyle(fontSize: 18, color: Colors.grey.shade500)),
                  SizedBox(height: 10),
                  Text('Ajoutez votre premier chauffeur', style: TextStyle(fontSize: 14, color: Colors.grey.shade400)),
                ],
              ),
            )
                : ListView.builder(
              itemCount: chauffeurs.length,
              itemBuilder: (context, index) {
                final chauffeur = chauffeurs[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 4),
                  child: ListTile(
                    leading: CircleAvatar(backgroundColor: Colors.blue.shade100, child: Icon(Icons.person, color: Colors.blue.shade800)),
                    title: Text(chauffeur['name']!, style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('Permis: ${chauffeur['license']} • Tél: ${chauffeur['phone']}'),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteChauffeur(index),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCamionsPage() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Gestion de la Flotte',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green.shade800),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '${camions.length} camion(s) enregistré(s)',
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: camions.isEmpty
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.local_shipping, size: 80, color: Colors.grey.shade300),
                  SizedBox(height: 20),
                  Text('Aucun camion', style: TextStyle(fontSize: 18, color: Colors.grey.shade500)),
                  SizedBox(height: 10),
                  Text('Ajoutez votre premier camion', style: TextStyle(fontSize: 14, color: Colors.grey.shade400)),
                ],
              ),
            )
                : ListView.builder(
              itemCount: camions.length,
              itemBuilder: (context, index) {
                final camion = camions[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 4),
                  child: ListTile(
                    leading: CircleAvatar(backgroundColor: Colors.green.shade100, child: Icon(Icons.local_shipping, color: Colors.green.shade800)),
                    title: Text('${camion['matricule']}', style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('${camion['type']} • ${camion['tonnage']}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: _getStatusColor(camion['statut']!),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            camion['statut']!,
                            style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteCamion(index),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String statut) {
    switch (statut) {
      case 'En service':
        return Colors.green;
      case 'En maintenance':
        return Colors.orange;
      case 'En réparation':
        return Colors.red;
      case 'Hors service':
        return Colors.grey;
      default:
        return Colors.blue;
    }
  }

  void _deleteChauffeur(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Supprimer Chauffeur'),
        content: Text('Supprimer ${chauffeurs[index]['name']} ?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('Annuler')),
          TextButton(
            onPressed: () {
              setState(() => chauffeurs.removeAt(index));
              Navigator.pop(context);
            },
            child: Text('Supprimer', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _deleteCamion(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Supprimer Camion'),
        content: Text('Supprimer le camion ${camions[index]['matricule']} ?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('Annuler')),
          TextButton(
            onPressed: () {
              setState(() => camions.removeAt(index));
              Navigator.pop(context);
            },
            child: Text('Supprimer', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _clearChauffeurControllers();
    _clearCamionControllers();
    super.dispose();
  }
}