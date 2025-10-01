import 'package:flutter/material.dart';
import 'package:qanaty/core/utilis/responsive.dart';
import 'package:qanaty/core/widget/acount_widget.dart';
import 'package:qanaty/core/widget/main_button.dart';
import 'package:qanaty/core/widget/periode_selector.dart';
import 'package:qanaty/core/widget/side_bar_widget.dart';

import '../../core/theme/app_style.dart';
import '../../core/widget/produit_vendu_widget.dart';
import '../../data/models/produi.dart';

class DashboardPage extends StatefulWidget {
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
   DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Appstyle.blueSC,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final screenWidth = constraints.maxWidth;
          final screenHeight = constraints.maxHeight;

          // ✅ Taille minimale imposée
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

                            // MAinDASH

                                Expanded(
                                  child: Column(
                                     children: [
                                        // Notification & Compte
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
                                              // action
                                            },
                                          ),
                                          AccountWidget(name: "Oussama Bensbaa", imageUrl: "assets/images/support.png")
                                        ],


                                      ),
                                       // Text

                                       Align(
                                           alignment: Alignment.topLeft,
                                           child: Text("Dashboard", style:Appstyle.textXL_B.copyWith(color: Appstyle.noir))),
                                       SizedBox(height: paddingV,),
                                      // Periode & NEW Periode

                                       Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                         children: [
                                           SizedBox(width: 1,),
                                           PeriodSelector(),
                                           MainButton(text: "Periode", color: Appstyle.rose, onPressed: (){})

                                         ],

                                       ),
                                       SizedBox(height: paddingV,),

                                       // Produit circle
                                       Wrap(
                                         spacing: paddingH*1.5, // espace horizontal entre widgets
                                         runSpacing: 16, // espace vertical si ça revient à la ligne

                                         children: [
                                           Container(
                                               width:Responsive.produitVenduWidth(adjustedWidth),
                                               height:Responsive.produitVenduHeight(adjustedHeight),

                                               child: ProduitVenduWidget(produit: "0.33Cl", value: "181 Palette")),
                                           Container(
                                               width:Responsive.produitVenduWidth(adjustedWidth),
                                               height:Responsive.produitVenduHeight(adjustedHeight),

                                               child: ProduitVenduWidget(produit: "0.50Cl", value: "129 Palette")),
                                           Container(
                                               width:Responsive.produitVenduWidth(adjustedWidth),
                                               height:Responsive.produitVenduHeight(adjustedHeight),

                                               child: ProduitVenduWidget(produit: "1l", value: "94 Palette")),
                                           Container(
                                               width:Responsive.produitVenduWidth(adjustedWidth),
                                               height:Responsive.produitVenduHeight(adjustedHeight),

                                               child: ProduitVenduWidget(produit: "1.5l", value: "71 Palette")),
                                           Container(
                                               width:Responsive.produitVenduWidth(adjustedWidth),
                                               height:Responsive.produitVenduHeight(adjustedHeight),

                                               child: ProduitVenduWidget(produit: "2l", value: "155 Palette")),

                                         ],

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
