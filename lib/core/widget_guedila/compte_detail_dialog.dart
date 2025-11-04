import 'package:flutter/material.dart';
import '../theme/app_style.dart';
import '../widget/main_button.dart';

class DetailCompteDialog extends StatelessWidget {
  final String crepar;
  final String categorie;
  final String nom;
  final String email;
  final String type;
  final String motDePasse;
  final String dateCreation;
  final bool actif;

  const DetailCompteDialog({
    super.key,
    required this.categorie,
    required this.crepar,
    required this.nom,
    required this.email,
    required this.type,
    required this.motDePasse,
    required this.dateCreation,
    required this.actif,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: 600,
        height: 420,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28.0),
          color: Colors.white,
        ),
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 🔹 Titre
              Text(
                'Détails du compte',
                style: Appstyle.textL_B.copyWith(color: Appstyle.noir),
              ),
              const SizedBox(height: 26),

              // 🔹 Détails du compte
              _buildUserDetailsTable(),

              const SizedBox(height: 60),

              // 🔹 Bouton Fermer
              MainButton(
                text: "Fermer",
                color: Appstyle.rose,
                onPressed: () => Navigator.of(context).pop(),
                noIcon: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 🔹 Tableau des informations de l'utilisateur
  Widget _buildUserDetailsTable() {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(1.5),
        1: FlexColumnWidth(2),
        2: FlexColumnWidth(1.5),
        3: FlexColumnWidth(2),
      },
      border: TableBorder.all(color: Colors.white, width: 0),
      children: [
        _buildTableRow(['Nom', nom, 'Email', email]),
        _buildTableRow(['Type', type, 'Mot de passe', motDePasse]),
        _buildTableRow(['Catégorie',categorie , 'Crée par',crepar ]),
        _buildTableRow(['Date création', dateCreation, 'Actif', actif ? 'Oui' : 'Non'], isLastRow: true),
       ],
    );
  }

  // 🔹 Ligne du tableau
  TableRow _buildTableRow(List<String> cells, {bool isLastRow = false}) {
    return TableRow(
      children: List.generate(
        cells.length,
            (index) => _buildTableCell(
          text: cells[index],
          index: index,
          isHeader: index == 0 || index == 2,
          isLastRow: isLastRow,
        ),
      ),
    );
  }

  // 🔹 Cellule du tableau
  Widget _buildTableCell({
    required String text,
    required int index,
    bool isHeader = false,
    bool isLastRow = false,
  }) {
    Color color;
    if (isHeader) {
      color = Appstyle.gris;
    } else if (isLastRow && index == 3) {
      color = actif ? Appstyle.vert : Appstyle.rose;
    } else {
      color = Appstyle.noir;
    }

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Text(
        text,
        style: Appstyle.textS_B.copyWith(
          color: color,
          fontWeight: isHeader ? FontWeight.normal : FontWeight.bold,
        ),
      ),
    );
  }
}
