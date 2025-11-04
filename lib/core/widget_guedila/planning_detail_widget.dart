import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../theme/app_style.dart';
import '../widget/main_button.dart';

class DetailPlanningDialog extends StatelessWidget {
  final String date;
  final String produit;
  final int quantite;
  final String etat;
  final List<int> slots;
  const DetailPlanningDialog({
    super.key,
    required this.date,
    required this.produit,
    required this.quantite,
    required this.slots,
    required this.etat,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: 600,
        height: 380,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28.0),
          color: Colors.white,
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 🔹 Titre
            Text(
              'Détails du planning',
              style: Appstyle.textL_B.copyWith(color: Appstyle.noir),
            ),
            const SizedBox(height: 26),

            // 🔹 Tableau des infos
            Table(
              columnWidths: const {
                0: FlexColumnWidth(1.5),
                1: FlexColumnWidth(2),
                2: FlexColumnWidth(1.5),
                3: FlexColumnWidth(2),
              },
              border: TableBorder.all(color: Colors.white, width: 0),
              children: [
                _buildTableRow(['Date', date, 'Produit', produit]),
                _buildTableRow(['Quantité', quantite.toString(), 'État', etat]),
              ],
            ),

// 🔹 Répartition des slots
            const SizedBox(height: 20),
            Text("Répartition par slots",
                style: Appstyle.textM_B.copyWith(color: Appstyle.noir)),
            const SizedBox(height: 10),

            Table(
              border: TableBorder.all(color: Colors.grey.shade300, width: 1),
              children: [
                TableRow(
                  decoration: const BoxDecoration(color: Color(0xFFEFEFEF)),
                  children: List.generate(8, (i) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Slot ${i + 1}",
                        textAlign: TextAlign.center,
                        style: Appstyle.textS_B.copyWith(color: Appstyle.gris)),
                  )),
                ),
                TableRow(
                  children: List.generate(8, (i) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "${slots[i]}",
                      textAlign: TextAlign.center,
                      style: Appstyle.textS_B.copyWith(color: Appstyle.noir),
                    ),
                  )),
                ),
              ],
            ),

            const SizedBox(height: 20),


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
    );
  }

  TableRow _buildTableRow(List<String> cells) {
    return TableRow(
      children: List.generate(
        cells.length,
            (index) => _buildTableCell(
          text: cells[index],
          isHeader: index == 0 || index == 2,
        ),
      ),
    );
  }

  Widget _buildTableCell({
    required String text,
    bool isHeader = false,
  }) {
    Color color = isHeader
        ? Appstyle.gris
        : (text == "Actif"
        ? Appstyle.vert
        : text == "Désactivé"
        ? Appstyle.rose
        : Appstyle.noir);

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
