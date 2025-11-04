import 'package:flutter/material.dart';
import 'package:qanaty/core/utilis/responsive.dart';
import 'package:qanaty/core/widget/acount_widget.dart';
import 'package:qanaty/core/widget/main_button.dart';
import 'package:qanaty/core/widget_guedila/acount_widget_company.dart';
import '../../core/widget_guedila/side_bar.dart';
import '../../core/theme/app_style.dart';
import '../../core/widget/search_field.dart';
import '../../core/widget_guedila/commande_widget_C.dart';

class TarificationPageC extends StatefulWidget {
  final String username = "Oussama Bensbaa";
  final double solde = 100000.00;

  final List<Map<String, dynamic>> commandes = [
    {"nom": "Client 1", "etat": "En attente", "date": "2020-09-13", "quantite": "12 plt", "produit": "0.5 L", "pallete": true, "montant": "150000.00","slot":"00-03","datelivre":""},
    {"nom": "Client 1", "etat": "Validé", "date": "2020-09-13", "quantite": "12 plt", "produit": "0.5 L", "pallete": true, "montant": "150000.00","slot":"00-03","datelivre":"15/09/2025"},
    {"nom": "Client 1", "etat": "En attente", "date": "2020-09-13", "quantite": "12 plt", "produit": "0.5 L", "pallete": true, "montant": "150000.00","slot":"00-03","datelivre":""},
    {"nom": "Client 1", "etat": "Validé", "date": "2020-09-13", "quantite": "12 plt", "produit": "0.5 L", "pallete": true, "montant": "150000.00","slot":"00-03","datelivre":"15/09/2025"},
    {"nom": "Client 1", "etat": "En attente", "date": "2020-09-13", "quantite": "12 plt", "produit": "0.5 L", "pallete": true, "montant": "150000.00","slot":"00-03","datelivre":""},
    {"nom": "Client 1", "etat": "Validé", "date": "2020-09-13", "quantite": "12 plt", "produit": "0.5 L", "pallete": true, "montant": "150000.00","slot":"00-03","datelivre":"15/09/2025"},
  ];

  TarificationPageC({Key? key}) : super(key: key);

  @override
  State<TarificationPageC> createState() => _TarificationPageC();
}

class _TarificationPageC extends State<TarificationPageC> {
  final TextEditingController _searchController = TextEditingController();
  TextEditingController dateFromController = TextEditingController();
  TextEditingController dateToController = TextEditingController();

  String? triNom;
  String? triEtat;

  Future<void> selectDate(BuildContext context, TextEditingController controller) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      controller.text = "${picked.year}-${picked.month}-${picked.day}";
    }
  }

  void resetFilters() {
    setState(() {
      triNom = null;
      triEtat = null;
      dateFromController.clear();
      dateToController.clear();
      _searchController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<String> nomsUniques = widget.commandes.map((c) => c['nom'] as String).toSet().toList()..sort();
    final List<String> etatsUniques = widget.commandes.map((c) => c['etat'] as String).toSet().toList()..sort();

    // 🔹 Filtrage des commandes selon critères
    final commandesFiltrees = widget.commandes.where((c) {
      bool matchNom = triNom == null || c['nom'] == triNom;
      bool matchEtat = triEtat == null || c['etat'] == triEtat;
      bool matchSearch = _searchController.text.isEmpty ||
          c['produit'].toString().toLowerCase().contains(_searchController.text.toLowerCase());
      return matchNom && matchEtat && matchSearch;
    }).toList();

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
                        // 🔹 Side Barre
                        Container(
                          width: Responsive.sidebarWidth(adjustedWidth),
                          height: Responsive.sidebarHeight(adjustedHeight),
                          child: SideBarWidgetC(),
                        ),
                        SizedBox(width: paddingH),

                        // 🔹 Contenu principal
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // 🔹 Ligne de profil
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    icon: Image.asset(
                                      "assets/icons/notifications_icon.png",
                                      width: Responsive.notificationSize(adjustedWidth),
                                      height: Responsive.notificationSize(adjustedWidth),
                                    ),
                                    onPressed: () {},
                                  ),
                                  AccountWidgetC(name: "Oussama Bensbaa", imageUrl: "assets/images/support.png"),
                                  const SizedBox(width: 16),
                                ],
                              ),
                              Text("Tarification", style: Appstyle.textXL_B.copyWith(color: Appstyle.noir)),
                              SizedBox(height: paddingV),

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
