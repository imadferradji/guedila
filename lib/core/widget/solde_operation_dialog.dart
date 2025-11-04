import 'package:flutter/material.dart';
import 'package:qanaty/core/theme/app_style.dart';

class SoldeOperationDialog extends StatelessWidget {
  const SoldeOperationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    // 🔹 Exemple de données (à remplacer par ton API plus tard)
    final operations = [
      {
        "type": "Commande",
        "etat": "Livrée",
        "montant": "-150000.00 DA",
        "date": "13/09/2025",
      },
      {
        "type": "Virement",
        "etat": "Reçu",
        "montant": "+200000.00 DA",
        "date": "10/09/2025",
      },
      {
        "type": "Commande",
        "etat": "En attente",
        "montant": "-95000.00 DA",
        "date": "08/09/2025",
      },
    ];

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Appstyle.blanc,
      child: Container(
        width: 600,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Appstyle.blanc,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 🔹 Titre
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Historique des opérations",
                    style:
                    Appstyle.textL_B.copyWith(color: Appstyle.blueF)),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.grey),
                  onPressed: () => Navigator.pop(context),
                )
              ],
            ),
            const Divider(),

            // 🔹 En-têtes
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _headerCell("Type", 100),
                  _headerCell("État", 100),
                  _headerCell("Montant", 150),
                  _headerCell("Date", 100),
                ],
              ),
            ),
            const Divider(),

            // 🔹 Liste d’opérations
            SizedBox(
              height: 300,
              child: ListView.builder(
                itemCount: operations.length,
                itemBuilder: (context, index) {
                  final op = operations[index];
                  final isPositive = op["montant"].toString().startsWith("+");

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _dataCell(op["type"]!, 100),
                        _dataCell(op["etat"]!, 100),
                        _dataCell(
                          op["montant"]!,
                          150,
                          color: isPositive
                              ? Colors.green
                              : Colors.redAccent,
                        ),
                        _dataCell(op["date"]!, 100),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _headerCell(String text, double width) {
    return SizedBox(
      width: width,
      child: Text(
        text,
        style: Appstyle.textM_B.copyWith(color: Appstyle.grisC),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _dataCell(String text, double width, {Color? color}) {
    return SizedBox(
      width: width,
      child: Text(
        text,
        style: Appstyle.textM_B
            .copyWith(color: color ?? Appstyle.noir),
        textAlign: TextAlign.center,
      ),
    );
  }
}
