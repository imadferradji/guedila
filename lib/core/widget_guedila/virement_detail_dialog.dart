import 'package:flutter/material.dart';
import '../theme/app_style.dart';
import '../widget/main_button.dart';
import 'commande_annule_confr_dialog.dart';
import 'commande_widget_C.dart'; // si tu as ce widget dans un autre fichier

class DetailVirementDialog extends StatelessWidget {
  final String date;
  final int nCommande;
  final String client;
  final String montant;
  final String etat;

  const DetailVirementDialog({
    super.key,
    required this.date,
    required this.nCommande,
    required this.client,
    required this.montant,
    required this.etat,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: 600,
        height: 500,
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
                'Details virement',
                style: Appstyle.textL_B.copyWith(color: Appstyle.noir),
              ),
              const SizedBox(height:26),

              // 🔹 Détails de la commande
              _buildVirmentDetailsTable(),

              const SizedBox(height: 220),

              // 🔹 Bouton Suivant
              MainButton(text: "Terminer", color: Appstyle.rose, onPressed: () => Navigator.of(context).pop(),noIcon: true,)
              ,

            ],
          ),
        ),
      ),
    );
  }

  // 🔹 Tableau des détails de commande
  Widget _buildVirmentDetailsTable() {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(1.5),
        1: FlexColumnWidth(2),
      },
      border: TableBorder.all(color: Colors.white, width: 0),
      children: [
        _buildTableRow(['Date', date, 'Client', client]),
        _buildTableRow(
          ['N° Virement', nCommande.toString(), 'Montant', montant],
          isLastRow: true,
        ),
      ],
    );
  }

  // -------------------------------------------------------------
  // 🔸 LIGNES DU TABLEAU
  // -------------------------------------------------------------
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

  // -------------------------------------------------------------
  // 🔸 CELLULES DU TABLEAU
  // -------------------------------------------------------------
  Widget _buildTableCell({
    required String text,
    required int index,
    bool isHeader = false,
    bool isLastRow = false,
  }) {
    Color color;
    if (isLastRow && index == 3) {
      // 🔹 dernière ligne + dernière cellule → Montant en bleu
      color = Appstyle.blueF;
    } else if (isHeader) {
      color = Appstyle.gris;
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
