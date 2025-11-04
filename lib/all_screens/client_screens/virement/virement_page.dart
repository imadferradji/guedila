import 'package:flutter/material.dart';
import 'package:qanaty/core/utilis/responsive.dart';
import 'package:qanaty/core/widget/acount_widget.dart';
import 'package:qanaty/core/widget/main_button.dart';
import 'package:qanaty/core/widget/periode_selector.dart';
import 'package:qanaty/core/widget/side_bar_widget.dart';
import '../../../core/theme/app_style.dart';
import '../../../core/widget/search_field.dart';
import '../../../core/widget/virement_dialog.dart';
import '../../../core/widget/virement_widget.dart';

class VirementPage extends StatefulWidget {
  final String username = "Oussama Bensbaa";
  VirementPage({Key? key}) : super(key: key);

  @override
  State<VirementPage> createState() => _VirementPage();
}

class _VirementPage extends State<VirementPage> {
  final TextEditingController _controller = TextEditingController();
  String selectedEtat = "Tous";
  DateTime? dateDebut;
  DateTime? dateFin;

  final List<Map<String, String>> virements = [
    {"numero": "120320120", "montant": "15234234.00 Da", "date": "24/02/2025", "etat": "valide"},
    {"numero": "120320121", "montant": "15234234.00 Da", "date": "05/03/2025", "etat": "en attente"},
    {"numero": "120320122", "montant": "15234234.00 Da", "date": "11/03/2025", "etat": "rejeté"},
  ];

  Future<void> _selectDate(BuildContext context, bool isStart) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2030),
      locale: const Locale("fr", "FR"),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          dateDebut = picked;
        } else {
          dateFin = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appstyle.blueSC,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final screenWidth = constraints.maxWidth;
          final screenHeight = constraints.maxHeight;
          const minWidth = 1200.0;
          const minHeight = 900.0;

          final adjustedWidth = screenWidth < minWidth ? minWidth : screenWidth;
          final adjustedHeight = screenHeight < minHeight ? minHeight : screenHeight;
          final paddingV = adjustedHeight * 0.03;
          final paddingH = adjustedWidth * 0.03;

          // 🔍 Application simple du filtre
          final filteredVirements = virements.where((v) {
            if (selectedEtat != "Tous" && v["etat"] != selectedEtat.toLowerCase()) return false;
            return true;
          }).toList();

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: ConstrainedBox(
                constraints: const BoxConstraints(minWidth: minWidth, minHeight: minHeight),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    width: adjustedWidth,
                    height: adjustedHeight,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 🧭 Barre latérale
                        SizedBox(
                          width: Responsive.sidebarWidth(adjustedWidth),
                          height: Responsive.sidebarHeight(adjustedHeight),
                          child: const SideBarWidget(),
                        ),
                        SizedBox(width: paddingH),
                        // 🧾 Contenu principal
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // 🔔 Notification et profil
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    icon: Image.asset(
                                      "assets/icons/notifications_icon.png",
                                      width: Responsive.notificationSize(adjustedWidth),
                                      height: Responsive.notificationSize(adjustedWidth),
                                      fit: BoxFit.contain,
                                    ),
                                    onPressed: () {},
                                  ),
                                  AccountWidget(
                                    name: widget.username,
                                    imageUrl: "assets/images/support.png",
                                  ),
                                  const SizedBox(width: 16),
                                ],
                              ),

                              // 🏷️ Titre
                              Text(
                                "Virement",
                                style: Appstyle.textXL_B.copyWith(color: Appstyle.noir),
                              ),
                              const SizedBox(height: 20),

                              // 🎛️ Filtres combinés (date + état)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      // ✅ Sélecteur de période
                                      PeriodSelector(),
                                      const SizedBox(width: 20),

                                      // ✅ Filtre État
                                    ],
                                  ),

                                  // ✅ Bouton "Nouveau virement"
                                  MainButton(
                                    text: "Nouveau virement",
                                    color: Appstyle.rose,
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        barrierColor: Appstyle.blueF.withOpacity(0.3),
                                        builder: (context) =>  VirementDialog(),
                                      );
                                    },
                                  ),
                                ],
                              ),

                              const SizedBox(height: 40),

                              // 🧾 Mes virements + Recherche
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Mes virements", style: Appstyle.textL_B),
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 1),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(12),
                                          border: Border.all(color: Appstyle.blueC, width: 1),
                                        ),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton<String>(
                                            value: selectedEtat,
                                            items: ["Tous", "Valide", "En attente", "Rejeté"]
                                                .map((e) => DropdownMenuItem(
                                              value: e,
                                              child: Text(
                                                e,
                                                style: Appstyle.textM.copyWith(color: Appstyle.noir),
                                              ),
                                            ))
                                                .toList(),
                                            onChanged: (value) {
                                              setState(() => selectedEtat = value!);
                                            },
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10,),
                                      SizedBox(
                                        width: 412,
                                        child: SearchField(controller: _controller),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              const SizedBox(height: 20),

                              // 📦 Liste des virements
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Wrap(
                                    spacing: paddingH * 1.5,
                                    runSpacing: 26,
                                    children: filteredVirements
                                        .map(
                                          (v) => SizedBox(
                                        width: Responsive.virementWidth(adjustedWidth),
                                        height: Responsive.virementHeight(adjustedHeight),
                                        child: VirementWidget(
                                          numero: v["numero"]!,
                                          montant: v["montant"]!,
                                          date: v["date"]!,
                                          etat: v["etat"]!,
                                        ),
                                      ),
                                    )
                                        .toList(),
                                  ),
                                ),
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
