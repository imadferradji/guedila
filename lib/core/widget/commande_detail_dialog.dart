import 'package:flutter/material.dart';
import '../theme/app_style.dart';
import 'main_button.dart';

class DetailFactureDialog extends StatelessWidget {
  final String date;
  final String livre;
  final String nCommande;
  final String client;
  final String produit;
  final String quantite;
  final bool palette;
  final String montant;
  final String etat;
  final String slot;

  const DetailFactureDialog({
    super.key,
    required this.date,
    required this.livre,
    required this.nCommande,
    required this.client,
    required this.produit,
    required this.quantite,
    required this.palette,
    required this.montant,
    required this.etat,
    required this.slot,
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
                'Details commande',
                style: Appstyle.textL_B.copyWith(color: Appstyle.noir),
              ),
              const SizedBox(height:26),


              // 🔹 Détails de la commande
              _buildCommandDetailsTable(),



              const SizedBox(height: 140),

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
  Widget _buildCommandDetailsTable() {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(1.5),
        1: FlexColumnWidth(2),
        2: FlexColumnWidth(1.5),
        3: FlexColumnWidth(2),
      },
      border: TableBorder.all(color: Colors.white, width: 0),
      children: [
        _buildTableRow(['Date', date, 'Produit', produit]),
        _buildTableRow(['N° Commande', nCommande.toString(), 'Quantité', quantite]),
        _buildTableRow(['Client', client, 'Palette', palette ? 'Oui' : 'Non']),
        _buildTableRow(['Etat', etat, 'Montant', montant], isLastRow: true), // ✅ dernière ligne
        _buildTableRow(['Livrée le', livre,"Slot",slot],), // ✅ dernière ligne
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
    // ✅ Détermination de la couleur du texte
    Color color;
    if (isLastRow && index == 3) {
      // dernière ligne + dernière cellule → Montant
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
