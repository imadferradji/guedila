import 'package:flutter/material.dart';
import 'package:qanaty/company%20side/Widgets/status_widget.dart';
import 'package:qanaty/core/utilis/responsive.dart';
import 'package:qanaty/core/widget/acount_widget.dart';
import 'package:qanaty/core/widget/main_button.dart';
import 'package:qanaty/core/widget/periode_selector.dart';
import '../../../core/theme/app_style.dart';
import '../../../core/widget/bar_chart.dart';
import '../../../core/widget/pie_chart.dart';
import '../../../core/widget/produit_vendu_widget.dart';
import '../../../data/produits.dart';
import '../../Widgets/best_seler_widget.dart';
import '../../Widgets/client_widget.dart';
import '../../Widgets/side_bar.dart';
class Dashboardcomany extends StatefulWidget {
  final String username="Oussama Bensbaa";
  Dashboardcomany({Key? key}) : super(key: key);

  @override
  State<Dashboardcomany> createState() => _Dashboardcomany();
}

class _Dashboardcomany extends State<Dashboardcomany> {
  @override
  final pieData = {
    "0.33L": 181.00,
    "0.5L": 129.00,
    "1L": 94.00,
    "1.5L": 71.00,
    "2L": 155.00,
    "0.33L S": 155.00,
    "0.5L S": 155.00,
  };
  final barLabels = ["Sept", "Oct", "Nov"];



  final barData = {
    "Sept": {
      "0.33L": 181.0,
      "0.5L": 129.0,
      "1L": 94.0,
      "1.5L": 71.0,
      "2L": 155.0,
      "0.33L S": 140.0,
      "0.5L S": 160.0,
    },
    "Oct": {
      "0.33L": 200.0,
      "0.5L": 150.0,
      "1L": 100.0,
      "1.5L": 90.0,
      "2L": 180.0,
      "0.33L S": 130.0,
      "0.5L S": 140.0,
    },
    "Nov": {
      "0.33L": 190.0,
      "0.5L": 120.0,
      "1L": 110.0,
      "1.5L": 80.0,
      "2L": 160.0,
      "0.33L S": 125.0,
      "0.5L S": 135.0,
    },
  };



  final barValues = [120.00, 200.00, 150.00];

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
                            child: SideBarWidgetC()
                        ),

                        SizedBox(width: paddingH),

                        // MAinDASH

                        Expanded(
                          child: Column(
                            children: [
                              // Notification & Compte
                              Row (
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(height: 1,) ,
                                  Row(
                                    children: [
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
                                      SizedBox(width: 10,) ,
                                      AccountWidget(name: "Oussama Bensbaa", imageUrl: "assets/images/support.png"),
                                    ],
                                  )
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
                              Row(
                                children: [
                                    Expanded(
                                      flex: 1,
                                      child:
                                      Column(crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Commande",style:  Appstyle.textL_B),
                                          SizedBox(height: 5,),
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(20.0)),
                                            height: 300,
                                            child: Column(
                                              children: [
                                                StatusWidget(
                                                  enAttente: 80,
                                                  validee: 120,
                                                  permis: 60,
                                                  livree: 45,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  SizedBox(width: 20,),
                                  Expanded(
                                    flex: 3,
                                    child:
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Client",style:  Appstyle.textL_B),
                                        SizedBox(height: 5,),
                                        Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(20.0)),
                                          height: 300,
                                          child: Column(
                                            children: [
                                              ClientWidget(clients : [
                                                Client(name: 'Client 1', number: 80),
                                                Client(name: 'Client 2', number: 120),
                                                Client(name: 'Client 3', number: 60),
                                                Client(name: 'Client 4', number: 45),
                                              ])
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 20,),
                                  Expanded(
                                    flex: 2,
                                    child:
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Best seller",style:  Appstyle.textL_B),
                                        SizedBox(height: 5,),
                                        Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(20.0)),
                                          height: 300,
                                          child: Column(
                                            children: [
                                              BottleSizeWidget(
                                                size33CL: 80,
                                                size50CL: 120,
                                                size1L: 60,
                                                size15L: 45,
                                                size2L: 30,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 20,),
                                ],
                              ),

                              SizedBox(height: paddingV,),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text("Produits",style: Appstyle.textL_B,),
                              ),
                              SizedBox(height: 10,),
                              Wrap(
                                spacing: paddingH * 0.65,
                                runSpacing: 16,
                                children: produits.map((produit) {
                                  final double? quantite = pieData[produit.abrev];
                                  return Container(
                                    width: Responsive.produitVenduWidth(adjustedWidth),
                                    height: Responsive.produitVenduHeight(adjustedHeight),
                                    child: ProduitVenduWidget(
                                      produit: produit.abrev,
                                      value: quantite != null ? "${quantite.toInt()} Palette" : "0 Palette",
                                      color: produit.color,
                                    ),
                                  );
                                }).toList(),
                              ),

                              SizedBox(height: paddingV,),
                              // Graph

                              Row(
                                children: [
                                  Expanded(
                                    flex:5,
                                    child: AspectRatio(
                                      aspectRatio: 6 / 3, // largeur / hauteur
                                      child: ProduitBarChart(months: barLabels, data: barData,scaleFactor: 1,),
                                    ),
                                  ),
                                  Expanded(
                                    flex:4,
                                    child: AspectRatio(
                                      aspectRatio: 5 / 3,
                                      child: ProduitPieChart(data: pieData),
                                    ),
                                  ),
                                ],
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
