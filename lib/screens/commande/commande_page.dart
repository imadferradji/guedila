import 'package:flutter/material.dart';
import 'package:qanaty/core/theme/app_style.dart';
import 'package:qanaty/core/widget/facture_widget.dart';
import 'package:qanaty/core/widget/facture_widget_plus_imprimer.dart';
import 'package:qanaty/core/widget/produit_vendu_widget.dart';
import 'package:qanaty/core/widget/side_bar_widget.dart';
import 'package:qanaty/core/widget/solde_widget.dart';
import 'package:qanaty/core/widget/virement_widget.dart';

import '../../core/widget/acount_widget.dart';
import '../../core/widget/commander_produit_dialog.dart';
import '../../core/widget/main_button.dart';
import '../../core/widget/periode_selector.dart';
import '../../core/widget/search_field.dart';

class CommandePage extends StatefulWidget {
  const CommandePage({super.key});

  @override
  State<CommandePage> createState() => _CommandePage();
}

class _CommandePage extends State<CommandePage> {
  final TextEditingController _controller = TextEditingController();
  String _text = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appstyle.bluebg,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1, // sidebar
                child: SideBarWidget(),
              ),
              const SizedBox(width: 20),
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        AccountWidget(name: "Imad Ferradji", imageUrl: "assets/success.png",),
                        SizedBox(width: 30,),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 20,),
                        Text("Commande", style: Appstyle.textXL_B,),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SoldeWidget(solde: "750000.00", dernier_modif: "12/05/2025"),
                        SizedBox(width: 30,),
                      ],
                    ),
                    SizedBox(height: 40,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        PeriodSelector(),
                        SizedBox(width: 295,),
                        MainButton(
                          text: "Ajouter",
                          color: Appstyle.rose,
                          onPressed: () {
                            debugPrint("Bouton rose pressé !");
                          },
                        ),
                        SizedBox(width: 30,),
                      ],
                    ),
                    SizedBox(height: 40,),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              child: Row(
                                children: [
                                  SizedBox(width: 20,),
                                  Text("Mes Commande" ,style: Appstyle.textL_B,),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 400,
                              child:
                              SearchField(controller: _controller),

                            ),
                          ],
                        ),
                    ),
                    SizedBox(height: 40,),
                    Column(
                      children: [
                        FactureWidget(quantite: "12 plt", produit: "0.5 L", livre: "Sep 16, 2020", pallete: "Oui", montant: "150000.00", date: "Sep 13, 2020", etat: "En attente"),
                        SizedBox(height: 20,),
                        FactureWidget(quantite: "12 plt", produit: "0.5 L", livre: "Sep 16, 2020", pallete: "Oui", montant: "150000.00", date: "Sep 13, 2020", etat: "En attente"),
                        SizedBox(height: 20,),
                        FactureWidget(quantite: "12 plt", produit: "0.5 L", livre: "Sep 16, 2020", pallete: "Oui", montant: "150000.00", date: "Sep 13, 2020", etat: "En attente"),
                        SizedBox(height: 20,),
                      ]
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
