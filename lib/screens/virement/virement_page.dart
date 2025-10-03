import 'package:flutter/material.dart';
import 'package:qanaty/core/utilis/responsive.dart';
import 'package:qanaty/core/widget/acount_widget.dart';
import 'package:qanaty/core/widget/main_button.dart';
import 'package:qanaty/core/widget/periode_selector.dart';
import 'package:qanaty/core/widget/side_bar_widget.dart';
import '../../core/theme/app_style.dart';
import '../../core/widget/search_field.dart';
import '../../core/widget/virement_dialog.dart';
import '../../core/widget/virement_widget.dart';

class VirementPage extends StatefulWidget {
  final String username="Oussama Bensbaa";
  VirementPage({Key? key}) : super(key: key);
  @override
  State<VirementPage> createState() => _VirementPage();
}

class _VirementPage extends State<VirementPage> {

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
                        // Side bar
                        Container(
                            width:Responsive.sidebarWidth(adjustedWidth),
                            height:Responsive.sidebarHeight(adjustedHeight),
                            child: SideBarWidget()
                        )
                        ,
                        SizedBox(width: paddingH,),
                        // MainVirement
                        Expanded(
                          child: Column(
                            children: [
                              // notif acount
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
                              // Text
                              Row(
                                children: [
                                  Text("Vierment", style:Appstyle.textXL_B.copyWith(color: Appstyle.noir)),
                                ],
                              ),
                              // Text
                              SizedBox(height: 20),
                              // button
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(width: 1,),
                                  PeriodSelector(),
                          MainButton(
                            text: "Virement",
                            color: Appstyle.rose,
                            onPressed: () {
                              showDialog(
                                context: context,
                                barrierDismissible: true, // ✅ ferme si clic dehors
                                barrierColor: Appstyle.blueF.withOpacity(0.3), // ✅ fond bleu clair
                                builder: (context) {
                                  return VirementDialog(); // ton widget Dialog multi-étapes
                                },
                              );
                            },
                          ),
                                ],
                              ),
                              SizedBox(height: 40),
                              // Mes virement & searchfield
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Mes vierment", style: Appstyle.textL_B,),
                                  SizedBox(
                                    width: 412,
                                    child:  SearchField(controller: _controller,),
                                  )

                                ],
                              ),
                              SizedBox(height: 20),
                              // Les virement
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
                              //
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