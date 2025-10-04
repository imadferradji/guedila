import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qanaty/core/theme/app_style.dart';

class SideBarWidgetC extends StatelessWidget {
  const SideBarWidgetC ({super.key});

  @override
  Widget build(BuildContext context) {
    // route courante
    final String currentRoute = GoRouterState.of(context).uri.toString();

    Widget buildMenuItem({
      required String iconPath,
      required String text,
      required String route,
    }) {
      final bool isActive = currentRoute == route;

      return InkWell(
        onTap: () => context.go(route),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 6),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          decoration: BoxDecoration(
            color: isActive ? Appstyle.blueC : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Image.asset(
                iconPath,
                width: 28,
                height: 28,
                color: isActive ? Colors.white : Appstyle.grisC,
              ),
              const SizedBox(width: 12),
              Text(
                text,
                style: Appstyle.textM_B.copyWith(
                  color: isActive ? Colors.white : Appstyle.grisC,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      width: 260,
      decoration: BoxDecoration(
        color: Appstyle.blanc,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 10, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Logo
            Center(
              child: Image.asset(
                "assets/icons/qanaty_icon.png",
                width: 100,
                height: 100,
              ),
            ),
            const SizedBox(height: 40),

            // ✅ Items menu
            buildMenuItem(
                iconPath: "assets/icons/dashboard_icon.png",
                text: "Dashboard",
                route: "/"),
            buildMenuItem(
                iconPath: "assets/icons/commande_icon.png",
                text: "Commande",
                route: "/CommandeCompany"),
            buildMenuItem(
                iconPath: "assets/icons/virement_icon.png",
                text: "Virement",
                route: "/Virmentcompany"),
            buildMenuItem(
                iconPath: "assets/icons/document_icon.png",
                text: "Document",
                route: "/documentCompany"),
            buildMenuItem(
                iconPath: "assets/icons/compte_icon.png",
                text: "Compte",
                route: "/comptes"),
            buildMenuItem(
                iconPath: "assets/icons/profile_icon.png",
                text: "Profile",
                route: "/profileC"),

            const Spacer(),

            // Support
            Center(
              child: Image.asset(
                "assets/images/Support.png",
                width: 140,
                height: 140,
              ),
            ),
            const SizedBox(height: 20),

            // Logout
            Center(
              child: Image.asset(
                "assets/icons/log_out_icon.png",
                width: 90,
                height: 70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
