import 'package:flutter/material.dart';

import '../../core/theme/app_style.dart';
import '../../core/utilis/responsive.dart';
import '../../core/widget/acount_widget.dart';
import '../../core/widget/side_bar_widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context){
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
                                  child: Text("Profile", style:Appstyle.textXL_B.copyWith(color: Appstyle.noir))),
                              SizedBox(height: paddingV,),



                              // Graph


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
