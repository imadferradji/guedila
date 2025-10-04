import 'package:flutter/material.dart';
import 'package:qanaty/core/utilis/responsive.dart';
import 'package:qanaty/core/widget/acount_widget.dart';
import 'package:qanaty/core/widget/side_bar_widget.dart';
import '../../core/theme/app_style.dart';
import '../../core/widget/etat_widget.dart';
import '../../core/widget/facture_widget.dart';
import '../../core/widget/facture_widget_plus_imprimer.dart';
import '../../core/widget/search_field.dart';


class DocumentPage extends StatefulWidget {
  final String username="Oussama Bensbaa";
  DocumentPage({Key? key}) : super(key: key);
  @override
  State<DocumentPage> createState() => _DocumentPage();
}

class _DocumentPage extends State<DocumentPage> {

  final TextEditingController _controller = TextEditingController();
  TextEditingController dateFromController = TextEditingController();
  TextEditingController dateToController = TextEditingController();

  bool facSide=false;
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
  void dispose() {
    _controller.dispose();
    dateFromController.dispose();
    dateToController.dispose();
    super.dispose();
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
                                  Text("Document", style:Appstyle.textXL_B.copyWith(color: Appstyle.noir)),
                                ],
                              ),
                              SizedBox(height: 20,),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  EtatWidget(
                                    initialSelectedIndex: facSide ? 1 : 0,
                                    onChanged: (index) {
                                      setState(() {
                                        facSide = index == 1; // si "Facture" sélectionné -> facSide = true
                                      });
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(height: 90,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text( "Mes facuters", style: Appstyle.textL_B,),
                                  facSide
                                      ? SizedBox(
                                    width: 412,
                                    child: SearchField(controller: _controller),
                                  )
                                      : Row(
                                    children: [
                                      SizedBox(
                                        width: 180,
                                        child: TextField(
                                          controller: dateFromController,
                                          readOnly: true,
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

                                      SizedBox(width: 20),

                                      SizedBox(
                                        width: 180,
                                        child: TextField(
                                          controller: dateToController,
                                          readOnly: true,
                                          decoration: InputDecoration(
                                            labelText: "Date au",
                                            prefixIcon: Icon(Icons.calendar_today, color: Appstyle.blueC),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(12),
                                              borderSide: BorderSide(
                                                color: Appstyle.blueC,
                                                width: 1.5,
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(12),
                                              borderSide: BorderSide(
                                                color: Appstyle.blueC,
                                                width: 2,
                                              ),
                                            ),
                                          ),
                                          onTap: () => selectDate(context, dateToController),
                                        ),
                                      ),
                                    ],
                                  ),


                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                ],
                              )
                              ,SizedBox(height: 40,),
                              Container(
                                width: double.infinity,
                                height: adjustedHeight*0.5,
                                child: SingleChildScrollView(
                                  child: !facSide?Column(
                                    children: [
                                      FactureWidget(quantite: "14 plt", produit: "0.5 L", livre: "Sep 16, 2020", pallete: "Oui", montant: "150000.00", date: "Sep 13, 2020", etat: 'Validé'),
                                      SizedBox(height: 10,),
                                      FactureWidget(quantite: "12 plt", produit: "0.5 L", livre: "Sep 16, 2020", pallete: "Oui", montant: "150000.00", date: "Sep 13, 2020", etat: 'Validé'),
                                      SizedBox(height: 10,),
                                      FactureWidget(quantite: "12 plt", produit: "0.5 L", livre: "Sep 16, 2020", pallete: "Oui", montant: "150000.00", date: "Sep 13, 2020", etat: 'Validé'),
                                      SizedBox(height: 10,),
                                      FactureWidget(quantite: "12 plt", produit: "0.5 L", livre: "Sep 16, 2020", pallete: "Oui", montant: "150000.00", date: "Sep 13, 2020", etat: 'Validé'),
                                      SizedBox(height: 10,),
                                      FactureWidget(quantite: "12 plt", produit: "0.5 L", livre: "Sep 16, 2020", pallete: "Oui", montant: "150000.00", date: "Sep 13, 2020", etat: 'Validé'),
                                      SizedBox(height: 10,),
                                      FactureWidget(quantite: "12 plt", produit: "0.5 L", livre: "Sep 16, 2020", pallete: "Oui", montant: "150000.00", date: "Sep 13, 2020", etat: 'Validé', ),
                                      SizedBox(height: 10,),
                                      FactureWidget(quantite: "12 plt", produit: "0.5 L", livre: "Sep 16, 2020", pallete: "Oui", montant: "150000.00", date: "Sep 13, 2020", etat: 'Validé' ),
                                      SizedBox(height: 10,),
                                      FactureWidget(quantite: "12 plt", produit: "0.5 L", livre: "Sep 16, 2020", pallete: "Oui", montant: "150000.00", date: "Sep 13, 2020", etat: 'Validé' ),
                                      SizedBox(height: 10,),
                                      FactureWidget(quantite: "12 plt", produit: "0.5 L", livre: "Sep 16, 2020", pallete: "Oui", montant: "150000.00", date: "Sep 13, 2020", etat: 'Validé'),
                                      SizedBox(height: 10,),
                                      FactureWidget(quantite: "12 plt", produit: "0.5 L", livre: "Sep 16, 2020", pallete: "Oui", montant: "150000.00", date: "Sep 13, 2020", etat: 'Validé' ),
                                      SizedBox(height: 10,),
                                      FactureWidget(quantite: "12 plt", produit: "0.5 L", livre: "Sep 16, 2020", pallete: "Oui", montant: "150000.00", date: "Sep 13, 2020", etat: 'Validé' ),
                                      SizedBox(height: 10,),
                                      FactureWidget(quantite: "12 plt", produit: "0.5 L", livre: "Sep 16, 2020", pallete: "Oui", montant: "150000.00", date: "Sep 13, 2020", etat: 'Validé' ),
                                      SizedBox(height: 10,),
                                      FactureWidget(quantite: "12 plt", produit: "0.5 L", livre: "Sep 16, 2020", pallete: "Oui", montant: "150000.00", date: "Sep 13, 2020", etat: 'Validé'),

                                    ],
                                  ):
                                  Column(children: [
                                      FactureImprimerWidget(quantite: "12 plt", produit: "0.5 L", livre: "Sep 16, 2020", pallete: "Oui", montant: "150000.00", date: "Sep 13, 2020", onPressed: (){},),
                                      SizedBox(height: 10,),
                                      FactureImprimerWidget(quantite: "12 plt", produit: "0.5 L", livre: "Sep 16, 2020", pallete: "Oui", montant: "150000.00", date: "Sep 13, 2020", onPressed: (){},),
                                      SizedBox(height: 10,),
                                      FactureImprimerWidget(quantite: "12 plt", produit: "0.5 L", livre: "Sep 16, 2020", pallete: "Oui", montant: "150000.00", date: "Sep 13, 2020", onPressed: (){},),
                                      SizedBox(height: 10,),
                                      FactureImprimerWidget(quantite: "12 plt", produit: "0.5 L", livre: "Sep 16, 2020", pallete: "Oui", montant: "150000.00", date: "Sep 13, 2020", onPressed: (){},),
                                      SizedBox(height: 10,),
                                      FactureImprimerWidget(quantite: "12 plt", produit: "0.5 L", livre: "Sep 16, 2020", pallete: "Oui", montant: "150000.00", date: "Sep 13, 2020", onPressed: (){},),
                                      SizedBox(height: 10,),
                                      FactureImprimerWidget(quantite: "12 plt", produit: "0.5 L", livre: "Sep 16, 2020", pallete: "Oui", montant: "150000.00", date: "Sep 13, 2020", onPressed: (){},),
                                      SizedBox(height: 10,),
                                      FactureImprimerWidget(quantite: "12 plt", produit: "0.5 L", livre: "Sep 16, 2020", pallete: "Oui", montant: "150000.00", date: "Sep 13, 2020", onPressed: (){},),
                                      SizedBox(height: 10,),
                                      FactureImprimerWidget(quantite: "12 plt", produit: "0.5 L", livre: "Sep 16, 2020", pallete: "Oui", montant: "150000.00", date: "Sep 13, 2020", onPressed: (){},),
                                      SizedBox(height: 10,),
                                      FactureImprimerWidget(quantite: "12 plt", produit: "0.5 L", livre: "Sep 16, 2020", pallete: "Oui", montant: "150000.00", date: "Sep 13, 2020", onPressed: (){},),
                                      SizedBox(height: 10,),
                                      FactureImprimerWidget(quantite: "12 plt", produit: "0.5 L", livre: "Sep 16, 2020", pallete: "Oui", montant: "150000.00", date: "Sep 13, 2020", onPressed: (){},),
                                      SizedBox(height: 10,),
                                      FactureImprimerWidget(quantite: "12 plt", produit: "0.5 L", livre: "Sep 16, 2020", pallete: "Oui", montant: "150000.00", date: "Sep 13, 2020", onPressed: (){},),
                                      SizedBox(height: 10,),
                                      FactureImprimerWidget(quantite: "12 plt", produit: "0.5 L", livre: "Sep 16, 2020", pallete: "Oui", montant: "150000.00", date: "Sep 13, 2020", onPressed: (){},),
                                      SizedBox(height: 10,),
                                      FactureImprimerWidget(quantite: "12 plt", produit: "0.5 L", livre: "Sep 16, 2020", pallete: "Oui", montant: "150000.00", date: "Sep 13, 2020", onPressed: (){},),

                                    ],),
                                ),
                              ),
                              SizedBox(height: 30,),
                              facSide
                                  ? Container() :
                              Row(
                                children: [
                                  SizedBox(
                                    height:40,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Appstyle.blueC,
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
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(child: Text("Montant total: 1968000.00 Da",style: Appstyle.textM_B.copyWith(color: Appstyle.blanc),)),
                                      ),),
                                  ),



                                  SizedBox(width: 50,),
                                  SizedBox(
                                    height:40,
                                    child: Container(

                                      decoration: BoxDecoration(
                                        color: Appstyle.blueC,
                                        borderRadius: BorderRadius.circular(16),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Appstyle.gris.withOpacity(0.3),
                                            spreadRadius: 1,
                                            blurRadius: 2,
                                            offset: const Offset(0, 1),
                                          ),
                                        ],
                                      ),  child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(child: Text("Nomber Pallet de total: 1980",style: Appstyle.textM_B.copyWith(color: Appstyle.blanc),)),
                                      ),),
                                  ),
                                  SizedBox(width: 50,),
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