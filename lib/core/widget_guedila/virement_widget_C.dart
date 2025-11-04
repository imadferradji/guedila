import 'package:flutter/material.dart';
import 'package:qanaty/core/theme/app_style.dart';
import 'package:qanaty/core/widget/main_button.dart';
import 'package:qanaty/core/widget_guedila/virement_detail_dialog.dart';
import 'package:qanaty/core/widget_guedila/virement_valide_dialog.dart';


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
  } void _showDetailDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => DetailVirementDialog(
        date: date,
        montant: montant, etat: etat, nCommande: Ncommande, client: NomC,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>_showDetailDialog(context),
      child: Container(
        width: 1600,
        height: 80,
        decoration: BoxDecoration(
          color: Appstyle.blanc,
          borderRadius: BorderRadius.circular(16),

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
                  "N Virement",
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

              if (etat == "En attente")
                MainButton(
                  text: "Validé",
                  color: Appstyle.rose,
                  onPressed: () {
                    _showValidationDialog(context);
                  },
                  noIcon: true,
                )
              else
                 Container(
                  height: 2,
                  width: 95,
                ),



            ],
          ),
        ),
      ),
    );
  }
}

// Validation Dialog Widget

