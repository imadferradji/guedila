import 'package:flutter/material.dart';
import '../theme/app_style.dart';
import '../widget/main_button.dart';

class DetailProduitDialog extends StatelessWidget {
  final String id;
  final String nom;
  final String taille;
  final String prix;
  final String categorie;
  final String nombrefardos;
  final String nombrepalette;
  final String createur;
  final String date;
  final bool etat;

  const DetailProduitDialog({
    super.key,
    required this.categorie,
    required this.nom,
    required this.id,
    required this.taille,
    required this.prix,
    required this.nombrefardos,
    required this.nombrepalette,
    required this.createur,
    required this.date,
    required this.etat,
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
                'Détails du produit',
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
        _buildTableRow(['ID', id, 'Etat', etat ? 'Actif' : 'Désactif']),
        _buildTableRow(['Nom', nom, 'Taille', taille]),
        _buildTableRow(['Prix', prix, 'Catégoroie', categorie]),
        _buildTableRow(['Fardos',nombrefardos , 'Palette',nombrepalette ]),
        _buildTableRow(['Date création', date,"Crée par",createur],),
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
      color = etat ? Appstyle.vert : Appstyle.rose;
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
