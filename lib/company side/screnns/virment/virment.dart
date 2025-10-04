import 'package:flutter/material.dart';
import 'package:qanaty/core/utilis/responsive.dart';
import 'package:qanaty/core/widget/acount_widget.dart';
import '../../../company side/Widgets/side_bar.dart';
import '../../../core/theme/app_style.dart';
import '../../../core/widget/search_field.dart';
import '../../Widgets/VirementConfirm.dart';

class VirmentPageC extends StatefulWidget {
  final String username="Oussama Bensbaa";
  final double solde=100000.00;


  VirmentPageC({Key? key}) : super(key: key);
  @override
  State<VirmentPageC> createState() => _CommandePageC();
}

class _CommandePageC extends State<VirmentPageC> {

  final TextEditingController _controller = TextEditingController();
  TextEditingController dateFromController = TextEditingController();
  TextEditingController dateToController = TextEditingController();
  Future<void> selectDate(BuildContext context, TextEditingController controller) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      controller.text = "${picked.day}/${picked.month}/${picked.year}";
    }
  }

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
                            child: SideBarWidgetC()
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
                                ],
                              ),

                              SizedBox(height: paddingV,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 180,
                                    child: TextField(
                                      controller: dateFromController,
                                      readOnly: false,
                                      decoration: InputDecoration(
                                        labelText: "Date du",
                                        prefixIcon: Icon(Icons.calendar_today, color: Appstyle.blueC),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                          borderSide: BorderSide(
                                            color: Appstyle.blueC, // couleur de la bordure normale
                                            width: 1.5,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                          borderSide: BorderSide(
                                            color: Appstyle.blueC, // couleur quand le champ est sélectionné
                                            width: 2,
                                          ),
                                        ),
                                      ),
                                      onTap: () => selectDate(context, dateFromController),
                                    ),
                                  ),
                                  SizedBox(width: 300,child: SearchField(controller: _controller,))
                                ],
                              ),
                              SizedBox(height: paddingV,),
                              Container(
                                width: double.infinity,
                                height: adjustedHeight*0.7,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      VirmentWidgetC ( montant: "150000.00", date: "Sep 13, 2020", etat: "Livrée", NomC: "elchapo", Ncommande: 125367,),
                                      SizedBox(height: 15,),
                                      VirmentWidgetC (montant: "150000.00", date: "Sep 13, 2020", etat: "En attente", NomC: "elchapo", Ncommande: 125367, ),
                                      SizedBox(height: 15,),
                                      VirmentWidgetC (montant: "150000.00", date: "Sep 13, 2020", etat: "En attente", NomC: "elchapo", Ncommande: 125367,),
                                      SizedBox(height: 15,),
                                      VirmentWidgetC (montant: "150000.00", date: "Sep 13, 2020", etat: "Permis", NomC: "elchapo", Ncommande: 125367,),
                                      SizedBox(height: 15,),
                                      VirmentWidgetC (montant: "150000.00", date: "Sep 13, 2020", etat: "Permis", NomC: "elchapo", Ncommande: 125367,),
                                      SizedBox(height: 15,),
                                      VirmentWidgetC (montant: "150000.00", date: "Sep 13, 2020", etat: "Livrée", NomC: "elchapo", Ncommande: 125367,),
                                      SizedBox(height: 15,),
                                      VirmentWidgetC (montant: "150000.00", date: "Sep 13, 2020", etat: "Validé", NomC: "elchapo", Ncommande: 125367,),
                                      SizedBox(height: 15,),
                                      VirmentWidgetC ( montant: "150000.00", date: "Sep 13, 2020", etat: "Livrée", NomC: "elchapo", Ncommande: 125367,),
                                      SizedBox(height: 15,),
                                      VirmentWidgetC (montant: "150000.00", date: "Sep 13, 2020", etat: "Livrée", NomC: "elchapo", Ncommande: 125367,),
                                      SizedBox(height: 15,),
                                      VirmentWidgetC (montant: "150000.00", date: "Sep 13, 2020", etat: "Validé", NomC: "elchapo", Ncommande: 125367,),
                                      SizedBox(height: 15,),
                                      VirmentWidgetC (montant: "150000.00", date: "Sep 13, 2020", etat: "Permis", NomC: "elchapo", Ncommande: 125367,),
                                      SizedBox(height: 15,),
                                      VirmentWidgetC (montant: "150000.00", date: "Sep 13, 2020", etat: "En attente", NomC: "elchapo", Ncommande: 125367,),
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