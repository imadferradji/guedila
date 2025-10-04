import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qanaty/core/theme/app_style.dart';

import '../../screens/profile/profile_page.dart';

class AccountWidget extends StatelessWidget {
  final String name;
  final String imageUrl;

  const AccountWidget({
    super.key,
    required this.name,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      color: Colors.white, // 👈 couleur de fond du menu
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16), // plus arrondi
      ),
      elevation: 4, // petite ombre
      onSelected: (value) {
        if (value == "Logout") {
          context.go("/login");
        } else if (value == "Compte") {
          context.go("/profile?tab=0");
        } else if (value == "Notification") {
          context.go("/profile?tab=1");
        } else if (value == "Confidentiality") {
          context.go("/profile?tab=2");
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          value: "Compte",
          child: Row(
            children: [
              Icon(Icons.person, color: Appstyle.blueC),
              const SizedBox(width: 8),
              Text("Compte", style: Appstyle.textS_B.copyWith(color: Appstyle.noir)),
            ],
          ),
        ),
        PopupMenuItem(
          value: "Notification",
          child: Row(
            children: [
              Icon(Icons.notifications, color: Appstyle.gold),
              const SizedBox(width: 8),
              Text("Notification", style: Appstyle.textS_B.copyWith(color: Appstyle.noir)),
            ],
          ),
        ),
        PopupMenuItem(
          value: "Confidentiality",
          child: Row(
            children: [
              Icon(Icons.lock, color: Appstyle.vert),
              const SizedBox(width: 8),
              Text("Confidentialité", style: Appstyle.textS_B.copyWith(color: Appstyle.noir)),
            ],
          ),
        ),
        const PopupMenuDivider(),
        PopupMenuItem(
          value: "Logout",
          child: Row(
            children: [
              Icon(Icons.logout, color: Appstyle.rose),
              const SizedBox(width: 8),
              Text("Déconnexion", style: Appstyle.textS_B.copyWith(color: Appstyle.rose)),
            ],
          ),
        ),
      ],
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 14,
              backgroundImage: AssetImage(imageUrl),
            ),
            const SizedBox(width: 8),
            Text(
              name,
              style: Appstyle.textS_B.copyWith(color: Appstyle.noir),
            ),
            const Icon(Icons.keyboard_arrow_down, size: 20, color: Colors.black54),
          ],
        ),
      ),
    );
  }
}
