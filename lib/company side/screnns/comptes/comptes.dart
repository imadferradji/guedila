import 'package:flutter/material.dart';
import 'package:qanaty/core/utilis/responsive.dart';
import 'package:qanaty/core/widget/acount_widget.dart';
import '../../../company side/Widgets/side_bar.dart';
import '../../../core/theme/app_style.dart';
import '../../../core/widget/search_field.dart';
import '../../Widgets/Delet_Account_Dialog.dart';
import '../../Widgets/New_Compte_Dialog.dart';
import '../../Widgets/VirementConfirm.dart';
import '../../Widgets/compte_widget.dart';
import '../../Widgets/modife_compte_dialog.dart';

class Comptes extends StatefulWidget {
  final String username="Oussama Bensbaa";
  final double solde=100000.00;


  Comptes({Key? key}) : super(key: key);
  @override
  State<Comptes> createState() => _Comptes();
}

class _Comptes extends State<Comptes> {
  List<Map<String, dynamic>> accounts = [
    {
      'id': '1',
      'name': 'Imad Ferradji',
      'type': 'Grossiste',
      'registerNumber': '63481534',
      'description': 'Grossiste principal',
    },
    {
      'id': '2',
      'name': 'Ahmed Benali',
      'type': 'Sous Grossiste',
      'registerNumber': '73481535',
      'description': 'Sous grossiste région nord',
    },
    {
      'id': '3',
      'name': 'Karim Djoudi',
      'type': 'Chauffeur',
      'registerNumber': '83481536',
      'description': 'Chauffeur livraison',
    },
  ];
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
                                  Text("Compte's", style:Appstyle.textXL_B.copyWith(color: Appstyle.noir)),
                                ],
                              ),

                              SizedBox(height: 90,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    width:40,height: 40,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.0),color: Appstyle.blueC),
                                    child:
                                    IconButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return ModifyAccountDialog(accounts: accounts);
                                            },
                                          );
                                        },
                                        icon: Image.asset("icons/pincel.png")),
                                  ),
                                  SizedBox(width: 10,),
                                  Container(
                                    width:40,height: 40,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.0),color: Colors.red),
                                    child:
                                    IconButton(
                                        onPressed: (){
                                          showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return ManageAccountsDialog(accounts: accounts);
                                          },
                                        ); },
                                        icon: Image.asset("icons/x.png")),
                                  ),
                                  SizedBox(width: 10,),
                                  Container(
                                    width:40,height: 40,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.0),color: Appstyle.rose),
                                    child:
                                    IconButton(
                                        onPressed: (){
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return NewAccountDialog();
                                              },
                                          );
                                          },
                                        icon: Image.asset("icons/add.png")),
                                  ),
                                  SizedBox(width: 10,),
                                  SizedBox(width: 300,child: SearchField(controller: _controller,))
                                ],
                              ),
                              SizedBox(height: 50,),
                              Container(
                                width: double.infinity,
                                height: adjustedHeight*0.66,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      CompteWidget (createur:"imad", Catrgorie : "A", date: "Sep 13, 2020", etat: "Actif", nomClient: "Oussama", codeClient: "125367",),
                                      SizedBox(height: 15,),
                                      CompteWidget (createur:"imad", Catrgorie : "A", date: "Sep 13, 2020", etat: "Actif", nomClient: "Oussama", codeClient: "125367",),
                                      SizedBox(height: 15,),
                                      CompteWidget (createur:"imad", Catrgorie : "A", date: "Sep 13, 2020", etat: "Actif", nomClient: "Oussama", codeClient: "125367",),
                                      SizedBox(height: 15,),
                                      CompteWidget (createur:"imad", Catrgorie : "A", date: "Sep 13, 2020", etat: "Actif", nomClient: "Oussama", codeClient: "125367",),
                                      SizedBox(height: 15,),
                                      CompteWidget (createur:"imad", Catrgorie : "A", date: "Sep 13, 2020", etat: "Actif", nomClient: "Oussama", codeClient: "125367",),
                                      SizedBox(height: 15,),
                                      CompteWidget (createur:"imad", Catrgorie : "A", date: "Sep 13, 2020", etat: "Actif", nomClient: "Oussama", codeClient: "125367",),
                                      SizedBox(height: 15,),
                                      CompteWidget (createur:"imad", Catrgorie : "A", date: "Sep 13, 2020", etat: "Actif", nomClient: "Oussama", codeClient: "125367",),
                                      SizedBox(height: 15,),
                                      CompteWidget (createur:"imad", Catrgorie : "A", date: "Sep 13, 2020", etat: "Actif", nomClient: "Oussama", codeClient: "125367",),
                                      SizedBox(height: 15,),
                                      CompteWidget (createur:"imad", Catrgorie : "A", date: "Sep 13, 2020", etat: "Actif", nomClient: "Oussama", codeClient: "125367",),
                                      SizedBox(height: 15,),
                                      CompteWidget (createur:"imad", Catrgorie : "A", date: "Sep 13, 2020", etat: "Actif", nomClient: "Oussama", codeClient: "125367",),
                                      SizedBox(height: 15,),
                                      CompteWidget (createur:"imad", Catrgorie : "A", date: "Sep 13, 2020", etat: "Actif", nomClient: "Oussama", codeClient: "125367",),
                                      SizedBox(height: 15,),
                                      CompteWidget (createur:"imad", Catrgorie : "A", date: "Sep 13, 2020", etat: "Actif", nomClient: "Oussama", codeClient: "125367",),
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