import 'package:flutter/material.dart';
import 'package:qanaty/core/utilis/responsive.dart';
import 'package:qanaty/core/widget/acount_widget.dart';
import 'package:qanaty/core/widget/main_button.dart';
import 'package:qanaty/core/widget/periode_selector.dart';
import 'package:qanaty/core/widget/side_bar_widget.dart';

import '../../core/theme/app_style.dart';
import '../../core/widget/etat_widget.dart';
import '../../core/widget/facture_widget.dart';
import '../../core/widget/facture_widget_plus_imprimer.dart';
import '../../core/widget/search_field.dart';
import '../../core/widget/solde_widget.dart';
import '../../data/models/produit.dart';

class ProfilePage extends StatefulWidget {
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
  ProfilePage({Key? key}) : super(key: key);
  @override
  State<ProfilePage> createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {

  final TextEditingController _controller = TextEditingController();
  final bool facSide=false;
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

          var _restrictionTime = "9:00";
          bool _isTimeRestrictionEnabled = true;
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text("Profil", style:Appstyle.textXL_B.copyWith(color: Appstyle.noir)),
                                ],
                              ),
                              SizedBox(height: 20,),
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      SizedBox(
                                        width: 250,
                                        height: 740,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(16),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black12,
                                                blurRadius: 6,
                                                offset: Offset(0, 3),
                                              ),
                                            ],
                                          ),
                                          child:
                                              Column(mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  SizedBox(height: 30,),
                                                  SizedBox(
                                                    height: 40,
                                                       child: Row(
                                                          children: [
                                                            SizedBox(width: 40,),
                                                            Image.asset("assets/icons/profile_icon.png"),
                                                            SizedBox(width: 20,),
                                                            Text("Compte",style: Appstyle.textL_B,),
                                                          ],
                                                    )
                                                  ),
                                                  SizedBox(height: 15,),
                                                  SizedBox(
                                                      height: 40,
                                                        child: Row(
                                                          children: [
                                                            SizedBox(width: 30,),
                                                            Image.asset("assets/icons/notifications_icon.png"),
                                                            SizedBox(width: 20,),
                                                            Text("Notification",style: Appstyle.textL_B,),
                                                          ],
                                                      )
                                                  ),
                                                  SizedBox(height: 15,),
                                                  SizedBox(
                                                      height: 40,
                                                      child: Row(
                                                        children: [
                                                          SizedBox(width: 30,),
                                                          Image.asset("assets/icons/virement_icon.png"),
                                                          SizedBox(width: 20,),
                                                          Text("Virement",style: Appstyle.textL_B,),
                                                        ],
                                                      )
                                                  ),
                                                  SizedBox(height: 15,),
                                                  SizedBox(
                                                      height: 40,
                                                      child: Row(
                                                        children: [
                                                          SizedBox(width: 40,),
                                                          Image.asset("assets/icons/document_icon.png"),
                                                          SizedBox(width: 20,),
                                                          Text("Confidentiality",style: Appstyle.textL_B,),
                                                        ],
                                                      )
                                                  ),
                                                ],
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 20,),
                                  Column(
                                    children: [
                                      SizedBox(
                                        width: 600,
                                        height: 740,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(16),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black12,
                                                blurRadius: 6,
                                                offset: Offset(0, 3),
                                              ),
                                            ],
                                          ),
                                          child: Column(
                                            children: [
                                              SizedBox(height: 20,),
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    height: 50,
                                                    child: Text("  Notification",style: Appstyle.textXL_B,),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 20,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  // Left Column with title + subtitle
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "   Issue Activity",
                                                        style: Appstyle.textL_B,),
                                                      SizedBox(height: 4),
                                                      Text(
                                                        "   Send me email notifications for issue activity",
                                                        style: Appstyle.textM,
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    children:[
                                                      Image.asset(
                                                        "assets/icons/on.png",
                                                        width: 40,
                                                        height: 24,
                                                      ),
                                                      SizedBox(width: 70,),
                                                    ],
                                                  ),

                                                ],
                                              ),
                                              SizedBox(height: 20,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  // Left Column with title + subtitle
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "   Tracking Activity",
                                                        style: Appstyle.textL_B,),
                                                      SizedBox(height: 4),
                                                      Text(
                                                        "   Send me notifications when someone’ve tracked time in tasks",
                                                        style: Appstyle.textM,
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    children:[
                                                      Image.asset(
                                                        "assets/icons/off.png",
                                                        width: 40,
                                                        height: 24,
                                                      ),
                                                      SizedBox(width: 70,),
                                                    ],
                                                  ),

                                                ],
                                              ),
                                              SizedBox(height: 20,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  // Left Column with title + subtitle
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "   New Comments",
                                                        style: Appstyle.textL_B,),
                                                      SizedBox(height: 4),
                                                      Text(
                                                        "   Send me notifications when someone’ve tracked time in tasks",
                                                        style: Appstyle.textM,
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    children:[
                                                      Image.asset(
                                                        "assets/icons/off.png",
                                                        width: 40,
                                                        height: 24,
                                                      ),
                                                      SizedBox(width: 70,),
                                                    ],
                                                  ),

                                                ],
                                              ),
                                              SizedBox(height: 20,),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      '   Don\'t send me notifications after 9:00 PM',
                                                      style: Appstyle.textM_B,
                                                    ),
                                                  ),
                                                  Switch(
                                                    value: _isTimeRestrictionEnabled,
                                                    onChanged: (bool value) {
                                                      setState(() {
                                                        _isTimeRestrictionEnabled = value;
                                                      });
                                                    },
                                                    activeColor: Colors.blue,
                                                  ),
                                                  SizedBox(width: 10,),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                ],
                              ),
                            ]


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
