
import 'package:flutter/material.dart';
import 'package:qanaty/core/utilis/responsive.dart';
import 'package:qanaty/core/widget/acount_widget.dart';
import 'package:qanaty/core/widget/main_button.dart';
import 'package:qanaty/core/widget/periode_selector.dart';
import 'package:qanaty/core/widget/side_bar_widget.dart';

import '../../core/theme/app_style.dart';
import '../../core/widget/facture_widget.dart';
import '../../core/widget/produit_vendu_widget.dart';
import '../../core/widget/search_field.dart';
import '../../core/widget/solde_widget.dart';
import '../../data/models/produit.dart';

class CommandePage extends StatefulWidget {
  final String username="Oussama Bensbaa";
  final List<Produit> produits = [
    Produit(
      nom: "Bouteille 1.5 L",
      image: "assets/icons/eau_15l_icon.png",
      bouteillesParPalette: 100,
      prix: 22800,
      abrev: "1.5L", color: Appstyle.pie_creme,

    ), Produit(
      nom: "Bouteille 0.5 L",
      image: "assets/icons/eau_15l_icon.png",
      bouteillesParPalette: 100,
      prix: 22800,
      abrev: "0.5L", color: Appstyle.pie_orange,

    ),
    Produit(
      nom: "Bouteille 1 L",
      image: "assets/icons/eau_1l_icon.png",
      bouteillesParPalette: 120,
      prix: 18000,
      abrev: "1L", color: Appstyle.pie_blueC,
    ),
    Produit(
      nom: "Bouteille 2 L",
      image: "assets/icons/eau_2l_icon.png",
      bouteillesParPalette: 80,
      prix: 25000,
      abrev: "2L", color: Appstyle.pie_blueF,
    ),
    Produit(
      nom: "Bouteille 0.33 Cl",
      image: "assets/icons/eau_33l_icon.png",
      bouteillesParPalette: 80,
      prix: 25000,
      abrev: "0.33L", color: Appstyle.pie_move,
    ),
    Produit(
      nom: "Bouteille 0.33 L Sport",
      image: "assets/icons/eau_33l_sport_icon.png",
      bouteillesParPalette: 80,
      prix: 25000,
      abrev: "0.33L S", color: Appstyle.pie_grena,
    ),
    Produit(
      nom: "Bouteille 0.5 L Sport",
      image: "assets/icons/eau_05l_sport_icon.png",
      bouteillesParPalette: 80,
      prix: 25000,
      abrev: "0.5L S", color: Appstyle.pie_vert,
    ),
  ];
  CommandePage({Key? key}) : super(key: key);
  @override
  State<CommandePage> createState() => _CommandePage();
}

class _CommandePage extends State<CommandePage> {

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appstyle.blueSC,
      body: LayoutBuilder(
        builder:(context, constraints) {
          final screenWidth = constraints.maxWidth;
          final screenHeight = constraints.maxHeight;
          const minWidth = 1200.0;
          const minHeight = 900.0;

          final adjustedWidth = screenWidth < minWidth ? minWidth : screenWidth;
          final adjustedHeight = screenHeight < minHeight ? minHeight : screenHeight;
          final paddingV=  adjustedHeight*0.03;
          final paddingH=  adjustedWidth*0.03;

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  minWidth: minWidth,
                  minHeight: minHeight,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    width: adjustedWidth,
                    height: adjustedHeight,
                    child: Row(

                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // SIde bar
                        Container(
                            width:Responsive.sidebarWidth(adjustedWidth),
                            height:Responsive.sidebarHeight(adjustedHeight),
                            child: SideBarWidget()
                        )
                        ,
                        SizedBox(width: paddingH,),
                        Expanded(
                          child: Column(
                            children: [
                              Row (
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Spacer(),
                                  IconButton(
                                    icon: Image.asset(
                                      "assets/icons/notifications_icon.png",
                                      width: Responsive.notificationSize(adjustedWidth),
                                      height: Responsive.notificationSize(adjustedWidth),
                                      fit: BoxFit.contain,
                                    ),
                                    onPressed: () {
                                    },
                                  ),
                                  AccountWidget(name: "Oussama Bensbaa", imageUrl: "assets/images/support.png"),
                                  SizedBox(width: 16,),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Commande", style:Appstyle.textXL_B.copyWith(color: Appstyle.noir)),
                                  SoldeWidget(solde: "130204050.00 DA",dernier_modif :"24/02/2025"),
                                ],
                              ),
                              SizedBox(height: paddingV,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(width: 1,),
                                  PeriodSelector(),
                                  MainButton(text: "Nouveau", color: Appstyle.rose, onPressed: (){}),
                                ],
                              ),
                              SizedBox(height: paddingV,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Mes commande", style: Appstyle.textL_B,),
                                    SizedBox(
                                      width: 412,
                                      child:  SearchField(controller: _controller,),
                                    )

                                  ],
                              ),SizedBox(height: paddingV,),
                            Container(
                              width: double.infinity,
                              height: adjustedHeight*0.5,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    FactureWidget(quantite: "12 plt", produit: "0.5 L", livre: "Sep 16, 2020", pallete: "Oui", montant: "150000.00", date: "Sep 13, 2020", etat: "En attente"),
                                    SizedBox(height: 10,),
                                    FactureWidget(quantite: "12 plt", produit: "0.5 L", livre: "Sep 16, 2020", pallete: "Oui", montant: "150000.00", date: "Sep 13, 2020", etat: "En attente"),
                                    SizedBox(height: 10,),
                                    FactureWidget(quantite: "12 plt", produit: "0.5 L", livre: "Sep 16, 2020", pallete: "Oui", montant: "150000.00", date: "Sep 13, 2020", etat: "En attente"),
                                    SizedBox(height: 10,),
                                    FactureWidget(quantite: "12 plt", produit: "0.5 L", livre: "Sep 16, 2020", pallete: "Oui", montant: "150000.00", date: "Sep 13, 2020", etat: "En attente"),
                                    SizedBox(height: 10,),
                                    FactureWidget(quantite: "12 plt", produit: "0.5 L", livre: "Sep 16, 2020", pallete: "Oui", montant: "150000.00", date: "Sep 13, 2020", etat: "En attente"),
                                    SizedBox(height: 10,),
                                    FactureWidget(quantite: "12 plt", produit: "0.5 L", livre: "Sep 16, 2020", pallete: "Oui", montant: "150000.00", date: "Sep 13, 2020", etat: "En attente"),
                                    SizedBox(height: 10,),
                                    FactureWidget(quantite: "12 plt", produit: "0.5 L", livre: "Sep 16, 2020", pallete: "Oui", montant: "150000.00", date: "Sep 13, 2020", etat: "En attente"),
                                    SizedBox(height: 10,),
                                    FactureWidget(quantite: "12 plt", produit: "0.5 L", livre: "Sep 16, 2020", pallete: "Oui", montant: "150000.00", date: "Sep 13, 2020", etat: "En attente"),
                                    SizedBox(height: 10,),
                                    FactureWidget(quantite: "12 plt", produit: "0.5 L", livre: "Sep 16, 2020", pallete: "Oui", montant: "150000.00", date: "Sep 13, 2020", etat: "En attente"),
                                    SizedBox(height: 10,),
                                    FactureWidget(quantite: "12 plt", produit: "0.5 L", livre: "Sep 16, 2020", pallete: "Oui", montant: "150000.00", date: "Sep 13, 2020", etat: "En attente"),
                                    SizedBox(height: 10,),
                                    FactureWidget(quantite: "12 plt", produit: "0.5 L", livre: "Sep 16, 2020", pallete: "Oui", montant: "150000.00", date: "Sep 13, 2020", etat: "En attente"),
                                    SizedBox(height: 10,),
                                    FactureWidget(quantite: "12 plt", produit: "0.5 L", livre: "Sep 16, 2020", pallete: "Oui", montant: "150000.00", date: "Sep 13, 2020", etat: "En attente"),
                                    SizedBox(height: 10,),
                                    FactureWidget(quantite: "12 plt", produit: "0.5 L", livre: "Sep 16, 2020", pallete: "Oui", montant: "150000.00", date: "Sep 13, 2020", etat: "En attente"),

                                  ],
                                  ),
                              ),
                            )


                            ],


                          ),
                        )
                      ],

                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}