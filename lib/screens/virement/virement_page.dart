
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
import '../../core/widget/virement_widget.dart';
import '../../data/models/produi.dart';

class VirementPage extends StatefulWidget {
  final String username="Oussama Bensbaa";
  final List<Produit> produits = [
    Produit(
      nom: "Bouteille 1.5 L",
      image: "assets/icons/eau_15l_icon.png",
      bouteillesParPalette: 100,
      prix: 22800,
    ),
    Produit(
      nom: "Bouteille 1 L",
      image: "assets/icons/eau_1l_icon.png",
      bouteillesParPalette: 120,
      prix: 18000,
    ),
    Produit(
      nom: "Bouteille 2 L",
      image: "assets/icons/eau_2l_icon.png",
      bouteillesParPalette: 80,
      prix: 25000,
    ),
    Produit(
      nom: "Bouteille 0.33 Cl",
      image: "assets/icons/eau_33l_icon.png",
      bouteillesParPalette: 80,
      prix: 25000,
    ),
    Produit(
      nom: "Bouteille 0.33 L Sport",
      image: "assets/icons/eau_33l_sport_icon.png",
      bouteillesParPalette: 80,
      prix: 25000,
    ),
    Produit(
      nom: "Bouteille 0.5 L Sport",
      image: "assets/icons/eau_05l_sport_icon.png",
      bouteillesParPalette: 80,
      prix: 25000,
    ),
  ];
  VirementPage({Key? key}) : super(key: key);
  @override
  State<VirementPage> createState() => _VirementPage();
}

class _VirementPage extends State<VirementPage> {

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appstyle.bluebg,
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
                                children: [
                                  Text("Vierment", style:Appstyle.textXL_B.copyWith(color: Appstyle.noir)),
                                ],
                              ),
                              SizedBox(height: 70),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(width: 1,),
                                  PeriodSelector(),
                                  MainButton(text: "Virement", color: Appstyle.rose, onPressed: (){}),
                                ],
                              ),
                              SizedBox(height: 80),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Mes vierment", style: Appstyle.textL_B,),
                                  SizedBox(
                                    width: 412,
                                    child:  SearchField(controller: _controller,),
                                  )

                                ],
                              ),SizedBox(height: 60),
                              Container(
                                width: double.infinity,
                                height: adjustedHeight*0.5,
                                child: Wrap(
                                  spacing: paddingH*1.5, // espace horizontal entre widgets
                                  runSpacing: 26, // espace vertical si ça revient à la ligne
                                  children: <Widget>[
                                    Container(
                                      width: Responsive.virementWidth(adjustedWidth),
                                      height: Responsive.virementHeight(adjustedHeight),
                                      child: VirementWidget(numero: "120320120",montant: "15234234.00 Da",date: "24/02/2025",etat: "valide",),
                                    ),
                                    Container(
                                      width: Responsive.virementWidth(adjustedWidth),
                                      height: Responsive.virementHeight(adjustedHeight),
                                      child: VirementWidget(numero: "120320120",montant: "15234234.00 Da",date: "24/02/2025",etat: "valide",),
                                    ),
                                    Container(
                                      width: Responsive.virementWidth(adjustedWidth),
                                      height: Responsive.virementHeight(adjustedHeight),
                                      child: VirementWidget(numero: "120320120",montant: "15234234.00 Da",date: "24/02/2025",etat: "valide",),
                                    ),
                                    Container(
                                      width: Responsive.virementWidth(adjustedWidth),
                                      height: Responsive.virementHeight(adjustedHeight),
                                      child: VirementWidget(numero: "120320120",montant: "15234234.00 Da",date: "24/02/2025",etat: "valide",),
                                    ),
                                    Container(
                                      width: Responsive.virementWidth(adjustedWidth),
                                      height: Responsive.virementHeight(adjustedHeight),
                                      child: VirementWidget(numero: "120320120",montant: "15234234.00 Da",date: "24/02/2025",etat: "valide",),
                                    ),
                                    Container(
                                      width: Responsive.virementWidth(adjustedWidth),
                                      height: Responsive.virementHeight(adjustedHeight),
                                      child: VirementWidget(numero: "120320120",montant: "15234234.00 Da",date: "24/02/2025",etat: "valide",),
                                    ),
                                  ],
                                )
                              ),
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