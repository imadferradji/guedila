import 'package:flutter/material.dart';
import 'package:qanaty/core/theme/app_style.dart';

class VirmentWidgetC extends StatelessWidget {
  final String date;
  final int Ncommande;
  final String NomC;
  final String montant;
  final String etat;

  const VirmentWidgetC({
    super.key,
    required this.NomC,
    required this.Ncommande,
    required this.montant,
    required this.date,
    required this.etat,
  });

  void _showValidationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => ValidationVirmentDialog(
        date: date,
        nCommande: Ncommande,
        client: NomC,
        montant: montant,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1600,
      height: 80,
      decoration: BoxDecoration(
        color: Appstyle.grisSC,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Appstyle.gris.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(children: [
              Text(
                "Date",
                style: Appstyle.textS.copyWith(color: Appstyle.grisC),
              ),
              Text(
                date,
                style: Appstyle.textM_B.copyWith(color: Appstyle.noir),
                textAlign: TextAlign.center,
              ),
            ]),
            Column(children: [
              Text(
                "N commande",
                style: Appstyle.textS.copyWith(color: Appstyle.grisC),
              ),
              Text(
                Ncommande.toString(),
                style: Appstyle.textL_B.copyWith(color: Appstyle.blueF),
                textAlign: TextAlign.center,
              ),
            ]),
            Column(children: [
              Text(
                "Client",
                style: Appstyle.textS.copyWith(color: Appstyle.grisC),
              ),
              Text(
                NomC,
                style: Appstyle.textL_B.copyWith(color: Appstyle.blueF),
                textAlign: TextAlign.center,
              ),
            ]),
            Column(children: [
              Text(
                "Montant",
                style: Appstyle.textS.copyWith(color: Appstyle.grisC),
              ),
              Text(
                montant,
                style: Appstyle.textM_B.copyWith(color: Appstyle.noir),
                textAlign: TextAlign.center,
              ),
            ]),
            Column(children: [
              Text(
                "Status",
                style: Appstyle.textS.copyWith(color: Appstyle.grisC),
              ),
              Text(
                etat,
                style: Appstyle.textM_B.copyWith(color: Appstyle.noir),
                textAlign: TextAlign.center,
              ),
            ]),
            Column(children: [
              Text(
                "Recu",
                style: Appstyle.textS.copyWith(color: Appstyle.grisC),
              ),
              IconButton(
                icon: Image.asset("icons/recu.png"),
                onPressed: () {  },
              )
            ]),
            GestureDetector(
              onTap: () => _showValidationDialog(context),
              child: Container(
                width: 120,
                height: 40,
                decoration: BoxDecoration(
                  color: Appstyle.rose,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    "Valide",
                    style: Appstyle.textM_B.copyWith(color: Appstyle.blanc),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Validation Dialog Widget
class ValidationVirmentDialog extends StatelessWidget {
  final String date;
  final int nCommande;
  final String client;
  final String montant;

  const ValidationVirmentDialog({
    super.key,
    required this.date,
    required this.nCommande,
    required this.client,
    required this.montant,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child:
      Container(
        width: 600,
        height: 500,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(28.0),color: Colors.white),
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Title
              const Text(
                'Validation Virment',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              // Description
              RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    height: 1.5,
                  ),
                  children: [
                    TextSpan(text: 'Vous etes sure de valider le virement suivant:'),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              // Command details table
              _buildVirmentDetailsTable(),
              const SizedBox(height: 170),
              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 12),
                  Container(
                    width: 180,
                    height: 40,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),color: Appstyle.rose),
                    child:
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFF482D2),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(true);
                        showDialog(
                          context: context,
                          builder: (context) =>  VirementConfirmDialog(),
                        );
                      },
                      child: Text('Valider',style: TextStyle(color: Colors.white,fontFamily: "oswald",fontSize: 20),),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVirmentDetailsTable() {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(1.5),
        1: FlexColumnWidth(2),
      },
      border: TableBorder.all(color: Colors.white, width: 0),
      children: [
        _buildTableRow(['Date', date, 'Montant', montant]),
        _buildTableRow(['N² Virment', nCommande.toString(), 'Client', client,]),
      ],
    );
  }


  TableRow _buildTableRow(List<String> cells) {
    return TableRow(
      children: cells.map((cell) => _buildTableCell(cell)).toList(),
    );
  }

  Widget _buildTableCell(String text, {bool isHeader = false}) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}

// Success Confirmation Dialog
class VirementConfirmDialog extends StatelessWidget {
  const VirementConfirmDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(28.0)),
        width: 600,
        height: 500,
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title
            const Text(
              'Virment confirmé',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 60),

            // Success message
            const Text(
              'Le Viremnt être bien Confirme !!',
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            Image.asset("icons/nike_icon.png",color: Appstyle.blueC,),
            SizedBox(height: 40,),
            // Terminer button
            SizedBox(
              width: 200,
              height: 40,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFF482D2),
                ),
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  'Terminer',
                  style: TextStyle(color: Colors.white,fontFamily: "oswald",fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
