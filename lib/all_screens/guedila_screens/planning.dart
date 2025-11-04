import 'package:flutter/material.dart';
import 'package:qanaty/core/utilis/responsive.dart';
import 'package:qanaty/core/widget/acount_widget.dart';
import 'package:qanaty/core/widget/main_button.dart';
import 'package:qanaty/core/widget/search_field.dart';
import 'package:qanaty/core/theme/app_style.dart';
import 'package:qanaty/core/widget_guedila/side_bar.dart';
import 'package:qanaty/core/widget_guedila/palnning_dialog.dart';
import 'package:qanaty/core/widget_guedila/planning_widget.dart';
import '../../core/widget_guedila/acount_widget_company.dart';
import '../../data/models/planning.dart';
import '../../data/plannings .dart';

class PlanningCompany extends StatefulWidget {
  final String username = "Oussama Bensbaa";
  const PlanningCompany({super.key});

  @override
  State<PlanningCompany> createState() => _PlanningCompanyState();
}

class _PlanningCompanyState extends State<PlanningCompany> {
  String selectedProduit = '';
  DateTime? selectedDate;
  final TextEditingController _searchController = TextEditingController();

  List<Planning> get filteredPlannings {
    return plannings.where((p) {
      final produitMatch =
          selectedProduit.isEmpty || p.produit == selectedProduit;

      final searchMatch = _searchController.text.isEmpty ||
          p.produit.toLowerCase().contains(_searchController.text.toLowerCase());

      final dateMatch = selectedDate == null ||
          p.date == _formatDate(selectedDate!);

      return produitMatch && searchMatch && dateMatch;
    }).toList();
  }

  String _formatDate(DateTime date) {
    // format simple : 2025-10-23
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appstyle.blueSC,
      body: LayoutBuilder(
        builder: (context, constraints) {
          const minWidth = 1200.0;
          const minHeight = 900.0;
          final screenWidth =
          constraints.maxWidth < minWidth ? minWidth : constraints.maxWidth;
          final screenHeight = constraints.maxHeight < minHeight
              ? minHeight
              : constraints.maxHeight;

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: ConstrainedBox(
                constraints:
                const BoxConstraints(minWidth: minWidth, minHeight: minHeight),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                    width: screenWidth,
                    height: screenHeight,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 🔹 Barre latérale
                        SizedBox(
                          width: Responsive.sidebarWidth(screenWidth),
                          height: Responsive.sidebarHeight(screenHeight),
                          child: SideBarWidgetC(),
                        ),

                        const SizedBox(width: 20),

                        // 🔹 Contenu principal
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Barre supérieure
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      icon: Image.asset(
                                        "assets/icons/notifications_icon.png",
                                        width: 30,
                                        height: 30,
                                      ),
                                      onPressed: () {},
                                    ),
                                    AccountWidgetC(
                                      name: widget.username,
                                      imageUrl: "assets/images/support.png",
                                    ),
                                    const SizedBox(width: 16),
                                  ],
                                ),

                                // Titre principal
                                Text(
                                  "Plannings de production / vente",
                                  style: Appstyle.textXL_B
                                      .copyWith(color: Appstyle.noir),
                                ),
                                const SizedBox(height: 30),

                                // 🔹 Filtres
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        // 🔹 Sélecteur de date
                                        SizedBox(
                                          width: 200,
                                          child: TextFormField(
                                            readOnly: true,
                                            decoration: InputDecoration(
                                              labelText: selectedDate == null
                                                  ? "Date"
                                                  : _formatDate(selectedDate!),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                BorderRadius.circular(12),
                                              ),
                                              suffixIcon: const Icon(Icons.calendar_today),
                                            ),
                                            onTap: () async {
                                              final pickedDate = await showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime(2020),
                                                lastDate: DateTime(2030),
                                              );
                                              if (pickedDate != null) {
                                                setState(() {
                                                  selectedDate = pickedDate;
                                                });
                                              }
                                            },
                                          ),
                                        ),
                                        // Bouton pour réinitialiser la date
                                        IconButton(
                                          icon: const Icon(Icons.close),
                                          tooltip: "Réinitialiser la date",
                                          onPressed: () =>
                                              setState(() => selectedDate = null),
                                        ),
                                        const SizedBox(width: 20),
                                        // Produit
                                        SizedBox(
                                          width: 200,
                                          child: DropdownButtonFormField<String>(
                                            value: selectedProduit.isEmpty
                                                ? null
                                                : selectedProduit,
                                            decoration: InputDecoration(
                                              labelText: "Produit",
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                BorderRadius.circular(12),
                                              ),
                                            ),
                                            items: [
                                              const DropdownMenuItem(
                                                  value: '', child: Text("Tous")),
                                              ...plannings
                                                  .map((p) => p.produit)
                                                  .toSet()
                                                  .map(
                                                    (prod) => DropdownMenuItem(
                                                  value: prod,
                                                  child: Text(prod),
                                                ),
                                              )
                                                  .toList(),
                                            ],
                                            onChanged: (val) => setState(
                                                    () => selectedProduit = val ?? ''),
                                          ),
                                        ),

                                           ],
                                    ),

                                    // Recherche + bouton Ajouter
                                    Row(
                                      children: [
                                        const SizedBox(width: 10), MainButton(
                                          text: "Ajouter planning",
                                          color: Appstyle.rose,
                                          onPressed: () async {
                                            await showDialog(
                                              context: context,
                                              builder: (_) =>
                                              const PlanningDialog(),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 40),

                                // 🔹 Liste des plannings
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: filteredPlannings.map((p) {
                                        return Padding(
                                          padding:
                                          const EdgeInsets.only(bottom: 12),
                                          child: PlanningWidget(
                                            date: p.date,
                                            produit: p.produit,
                                            quantite:
                                            int.tryParse(p.quantite) ?? 0,
                                            etat: p.etat, slots: p.slots,
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
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
