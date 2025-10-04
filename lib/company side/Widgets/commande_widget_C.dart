import 'package:flutter/material.dart';
import 'package:qanaty/core/theme/app_style.dart';

class CommandeWidgetC extends StatelessWidget {
  final String date;
  final int Ncommande;
  final String NomC;
  final String produit;
  final String quantite;
  final bool pallete;
  final String montant;
  final String etat;

  const CommandeWidgetC({
    super.key,
    required this.NomC,
    required this.quantite,
    required this.produit,
    required this.Ncommande,
    required this.pallete,
    required this.montant,
    required this.date,
    required this.etat,
  });

  Color getEtatColor(String etat) {
    switch (pallete) {
      case true:
        return const Color(0xFFFF7671);
      case false:
        return const Color(0xFFF482D2);
      default:
        return Appstyle.gris;
    }
  }
  void _showAnnulationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AnnulationCommandeDialog(
        date: date,
        nCommande: Ncommande,
        client: NomC,
        produit: produit,
        quantite: quantite,
        palette: pallete,
        montant: montant,
      ),
    );
  }

  void _showValidationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => ValidationCommandeDialog(
        date: date,
        nCommande: Ncommande,
        client: NomC,
        produit: produit,
        quantite: quantite,
        palette: pallete,
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
                "Produit",
                style: Appstyle.textS.copyWith(color: Appstyle.grisC),
              ),
              Text(
                produit,
                style: Appstyle.textM_B.copyWith(color: Appstyle.noir),
                textAlign: TextAlign.center,
              ),
            ]),
            Column(children: [
              Text(
                "Quantité",
                style: Appstyle.textS.copyWith(color: Appstyle.grisC),
              ),
              Text(
                quantite,
                style: Appstyle.textL_B.copyWith(color: Appstyle.blueF),
                textAlign: TextAlign.center,
              ),
            ]),
            Column(children: [
              Text(
                "Palette",
                style: Appstyle.textS.copyWith(color: Appstyle.grisC),
              ),
              Text(
                pallete ? "Oui" : "Non",
                style: Appstyle.textM_B.copyWith(color: Appstyle.noir),
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
            GestureDetector(
              onTap: () => !pallete?_showValidationDialog(context):_showAnnulationDialog(context),
              child: Container(
                width: 120,
                height: 40,
                decoration: BoxDecoration(
                  color: getEtatColor(etat),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    !pallete ? "Valide" : "Annuler",
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
class ValidationCommandeDialog extends StatelessWidget {
  final String date;
  final int nCommande;
  final String client;
  final String produit;
  final String quantite;
  final bool palette;
  final String montant;

  const ValidationCommandeDialog({
    super.key,
    required this.date,
    required this.nCommande,
    required this.client,
    required this.produit,
    required this.quantite,
    required this.palette,
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
                'Validation commande',
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
                    TextSpan(text: 'Vous êtes sure de confirmer la '),
                    TextSpan(
                      text: 'commande suivante',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: ':'),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              // Command details table
              _buildCommandDetailsTable(),
              const SizedBox(height: 100),
              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 12),
                  SizedBox(
                    width: 200,
                    height: 40,
                    child:
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFF482D2),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(true);
                        showDialog(
                          context: context,
                          builder: (context) =>  CommandeConfirmeeDialog(),
                        );
                      },
                      child: Text('Confirmer',style: TextStyle(color: Colors.white,fontFamily: "oswald",fontSize: 20),),
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
        _buildTableRow(['N² Commande', nCommande.toString(), 'Quantité', quantite]),
        _buildTableRow(['Client', client, 'Palette', palette ? 'Oui' : 'Non']),
        _buildTableRow(['', '', 'Montant', montant]),
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
class CommandeConfirmeeDialog extends StatelessWidget {
  const CommandeConfirmeeDialog({super.key});

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
              'Commande confirmé',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 60),

            // Success message
            const Text(
              'Votre commande être bien Validée !!',
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
class AnnulationCommandeDialog extends StatelessWidget {
  final String date;
  final int nCommande;
  final String client;
  final String produit;
  final String quantite;
  final bool palette;
  final String montant;

  const AnnulationCommandeDialog({
    super.key,
    required this.date,
    required this.nCommande,
    required this.client,
    required this.produit,
    required this.quantite,
    required this.palette,
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
                'Annulation commande',
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
                    TextSpan(text: 'Vous etes sure de annuler la coomande suivante:'),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              // Command details table
              _buildCommandDetailsTable(),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 300,
                    height: 40,
                    decoration: BoxDecoration(color: Appstyle.grisC,borderRadius: BorderRadius.circular(20.0)),
                    child:
                    TextField(

                    ),
                  ),
                ],
              ),
              SizedBox(height: 30,),
              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 12),
                  SizedBox(
                      width: 200,
                      height: 40,
                      child:
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFF482D2),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop(true);
                          showDialog(
                            context: context,
                            builder: (context) =>  CommandeAnnuleeDialog(),
                          );
                          },
                        child: Text('Suivant',style: TextStyle(color: Colors.white,fontFamily: "oswald",fontSize: 20),),
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
        _buildTableRow(['N² Commande', nCommande.toString(), 'Quantité', quantite]),
        _buildTableRow(['Client', client, 'Palette', palette ? 'Oui' : 'Non']),
        _buildTableRow(['', '', 'Montant', montant]),
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
class CommandeAnnuleeDialog extends StatelessWidget {
  const CommandeAnnuleeDialog({super.key});

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
              'Annulation ',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 60),

            // Success message
            const Text(
              'Votre commande être bien Annulee !!',
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            Image.asset("icons/nike_icon.png",color: Colors.red,),
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