import 'package:flutter/material.dart';
import 'package:qanaty/core/utilis/responsive.dart';
import 'package:qanaty/core/widget/acount_widget.dart';
import 'package:qanaty/core/widget/camion_dialog.dart';
import 'package:qanaty/core/widget/chauffeur_camion%20_widget.dart';
import 'package:qanaty/core/widget/chauffeur_dialog.dart';
import 'package:qanaty/core/widget/chauffeur_widget.dart';
import 'package:qanaty/core/widget/main_button.dart';
import 'package:qanaty/core/widget/side_bar_widget.dart';
import 'package:qanaty/data/camions.dart';
import '../../core/theme/app_style.dart';
import '../../core/widget/camion_widget.dart';
import '../../core/widget/etat_facture_widget.dart';
import '../../core/widget/facture_widget.dart';
import '../../core/widget/facture_widget_plus_imprimer.dart';
import '../../core/widget/search_field.dart';
import '../../data/chauffeurs.dart';


class DriverTruckPage extends StatefulWidget {
  final String username="Oussama Bensbaa";
  DriverTruckPage({Key? key}) : super(key: key);
  @override
  State<DriverTruckPage> createState() => _DriverTruckPage();
}

class _DriverTruckPage extends State<DriverTruckPage> {

  final TextEditingController _controller = TextEditingController();
  TextEditingController dateFromController = TextEditingController();
  TextEditingController dateToController = TextEditingController();

  bool camioSide=false;
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

                              // Notification et Accoutn
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

                              // Titre
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text("Chauffeurs & Camions", style:Appstyle.textXL_B.copyWith(color: Appstyle.noir)),
                                ],
                              ),
                              SizedBox(height: 20,),
                                // Buttopn camion & chauffeur
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ChauffeurCamionWidget(
                                    initialSelectedIndex: camioSide ? 1 : 0,
                                    onChanged: (index) {
                                      setState(() {
                                        camioSide = index == 1; // si "Facture" sélectionné -> facSide = true
                                      });
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(height: 40,),
                                //  nouveau button
                              Align(
                                alignment: Alignment.topRight,
                                 child: MainButton(
                              text: camioSide ? "Nouveau camion" : "Nouveau chauffeur",
                                color: Appstyle.rose,
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    barrierDismissible: true,
                                    barrierColor: Appstyle.blueF.withOpacity(0.3),
                                    builder: (context) {
                                      return camioSide
                                          ? CamionDialog()   // ✅ si vrai → popup camion
                                          : DriverDialog();  // ✅ si faux → popup chauffeur
                                    },
                                  );
                                },
                              ),

                        ),
                              SizedBox(height: 20,),
                              // mini Titre & search field
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text( camioSide?"Mes camions":"Mes chauffeurs", style: Appstyle.textL_B,),

                                  SizedBox(
                                    width: 412,
                                    child: SearchField(controller: _controller),
                                  )


                                ],
                              ),

                              SizedBox(height: 40,),
                              Container(
                                width: double.infinity,
                                height: adjustedHeight*0.5,
                                child: SingleChildScrollView(
                                  child: camioSide?Column(
                                    children: [
                                      ...chauffeurs.expand((chauffeur) {
                                        return [
                                          ChauffeurWidget(
                                            Nom: chauffeur.nom,
                                            datenaissance: chauffeur.date,
                                            npermis: chauffeur.npermis,
                                            ntelephone: chauffeur.ntelephone,
                                            etat: chauffeur.etat,
                                          ),
                                          const SizedBox(height: 10), // espace entre les lignes
                                        ];
                                      }).toList(),
                                    ],
                                  )

                                      :
                                  Column(
                                    children: [
                                      // La clé ici est d'utiliser .map() pour transformer chaque Camion en CamionWidget
                                      ...camions.expand((camion) {
                                        return [
                                          CamionWidget(
                                            Matricule: camion.Matricule,
                                            MatriculeR: camion.Remorque, // Remorque est utilisé pour MatriculeR
                                            tonnage: camion.tonnage,
                                            etat: camion.etat,
                                            type: camion.type, // Assurez-vous d'avoir ajouté 'type' dans votre CamionWidget
                                          ),
                                          const SizedBox(height: 10), // espace entre les widgets
                                        ];
                                      }).toList(),
                                      // Convertir le résultat en List<Widget>
                                    ],
                                  )
                                ),
                              ),
                              SizedBox(height: 30,),


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