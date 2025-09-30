import 'package:flutter/material.dart';
import 'package:qanaty/core/theme/app_style.dart';

import 'icon_text_widget.dart';

class SideBarWidget extends StatelessWidget {

  const SideBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width:700,
      height: 700,
      decoration: BoxDecoration(
        color: Appstyle.blanc,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Appstyle.gris.withOpacity(0.3),
            spreadRadius: 4,
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10,5,6,5),
        child: Row(
          children: [


            SizedBox(width: 20,),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  "assets/icons/qanaty_icon.png",
                  width: 100,
                  height: 100,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 40,),
                IconTextRow(
                  iconPath: "assets/icons/dashboard_icon.png",
                  text: "Dashboard",
                  iconSize: 28,
                  textStyle: Appstyle.textM_B.copyWith(color: Appstyle.gris),
                ),
                SizedBox(height: 10,),
                IconTextRow(
                  iconPath: "assets/icons/commande_icon.png",
                  text: "Commande",
                  iconSize: 28,
                  textStyle: Appstyle.textM_B.copyWith(color: Appstyle.grisC),
                ),
                SizedBox(height: 10,),
                IconTextRow(
                  iconPath: "assets/icons/virement_icon.png",
                  text: "Viremement",
                  iconSize: 28,
                  textStyle: Appstyle.textM_B.copyWith(color: Appstyle.grisC),
                ),
                SizedBox(height: 10,),
                IconTextRow(
                  iconPath: "assets/icons/document_icon.png",
                  text: "Document",
                  iconSize: 28,
                  textStyle: Appstyle.textM_B.copyWith(color: Appstyle.grisC),
                ),
                SizedBox(height: 10,),
                IconTextRow(
                  iconPath: "assets/icons/profile_icon.png",
                  text: "Profile",
                  iconSize: 28,
                  textStyle: Appstyle.textM_B.copyWith(color: Appstyle.grisC),
                ),
                SizedBox(height: 120,),

                Image.asset(
                  "assets/images/Support.png",
                  width: 150,
                  height: 150,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 20,),
                Image.asset(
                  "assets/icons/log_out_icon.png",
                  width: 70,
                  height: 70,
                  fit: BoxFit.contain,
                ),


              ],
            ),
            SizedBox(width: 20,),
         ],
        ),
      ),
    );
  }
}
