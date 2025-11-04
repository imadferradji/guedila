import 'package:flutter/material.dart';
import 'package:qanaty/core/utilis/responsive.dart';
import 'package:qanaty/core/widget/acount_widget.dart';
import 'package:qanaty/core/widget/main_button.dart';
import 'package:qanaty/core/widget/periode_selector.dart';
import 'package:qanaty/core/widget/side_bar_widget.dart';

import '../../../core/theme/app_style.dart';
import '../../../core/widget/commander_produit_dialog.dart';
import '../../../core/widget/commande_widget.dart';
import '../../../core/widget/search_field.dart';
import '../../../core/widget/solde_widget.dart';

class CommandePage extends StatefulWidget {
  final String username = "Oussama Bensbaa";
  final double solde = 100000.00;

  CommandePage({Key? key}) : super(key: key);

  @override
  State<CommandePage> createState() => _CommandePageState();
}

class _CommandePageState extends State<CommandePage> {
  final TextEditingController _controller = TextEditingController();

  String selectedEtat = '';
  String selectedProduit = '';

  // 🔹 Données factures simulées (à remplacer plus tard par ton API)
  final List<Map<String, dynamic>> allFactures = [
    {
      "etat": "Livrée",
      "date": "Sep 13, 2020",
      "nCommande": "161025C00001",
      "nClient": "Ahmed",
      "produit": "0.5 L",
      "quantite": "12 plt",
      "pallete": "Oui",
      "montant": "150000.00",
      "livre": "Sep 16, 2020",
      "slot": "09-12"
    },
    {
      "etat": "En attente",
      "date": "Sep 10, 2020",
      "nCommande": "161025C00002",
      "nClient": "Yacine",
      "produit": "1.5 L",
      "quantite": "6 plt",
      "pallete": "Non",
      "montant": "95000.00",
      "livre": "",
      "slot": ""
    },
    {
      "etat": "Validé",
      "date": "Sep 12, 2020",
      "nCommande": "161025C00003",
      "nClient": "Sami",
      "produit": "0.5 L",
      "quantite": "8 plt",
      "pallete": "Oui",
      "montant": "120000.00",
      "livre": "Sep 15, 2020",
      "slot": "18-21",
    },{
      "etat": "Permis",
      "date": "Sep 12, 2020",
      "nCommande": "161025C00003",
      "nClient": "Sami",
      "produit": "0.5 L",
      "quantite": "8 plt",
      "pallete": "Oui",
      "montant": "120000.00",
      "livre": "Sep 15, 2020",
      "slot": "12-15"
    },
  ];

  @override
  Widget build(BuildContext context) {
    // 🔸 Liste filtrée selon état et produit
    final filteredFactures = allFactures.where((facture) {
      final matchEtat =
          selectedEtat.isEmpty || facture['etat'] == selectedEtat;
      final matchProduit =
          selectedProduit.isEmpty || facture['produit'] == selectedProduit;
      return matchEtat && matchProduit;
    }).toList();

    // 🔸 Valeurs uniques pour les menus déroulants
    final etats = allFactures.map((f) => f['etat']).toSet().toList();
    final produits = allFactures.map((f) => f['produit']).toSet().toList();

    return Scaffold(
      backgroundColor: Appstyle.blueSC,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final screenWidth = constraints.maxWidth;
          final screenHeight = constraints.maxHeight;
          const minWidth = 1200.0;
          const minHeight = 900.0;

          final adjustedWidth = screenWidth < minWidth ? minWidth : screenWidth;
          final adjustedHeight =
          screenHeight < minHeight ? minHeight : screenHeight;
          final paddingV = adjustedHeight * 0.03;
          final paddingH = adjustedWidth * 0.03;

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
                        // 🧭 Side bar
                        SizedBox(
                          width: Responsive.sidebarWidth(adjustedWidth),
                          height: Responsive.sidebarHeight(adjustedHeight),
                          child: const SideBarWidget(),
                        ),
                        SizedBox(width: paddingH),
                        Expanded(
                          child: Column(
                            children: [
                              // 🧑 Profil + notif
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Spacer(),
                                  IconButton(
                                    icon: Image.asset(
                                      "assets/icons/notifications_icon.png",
                                      width: Responsive.notificationSize(
                                          adjustedWidth),
                                      height: Responsive.notificationSize(
                                          adjustedWidth),
                                      fit: BoxFit.contain,
                                    ),
                                    onPressed: () {},
                                  ),
                                  const AccountWidget(
                                      name: "Oussama Bensbaa",
                                      imageUrl: "assets/images/support.png"),
                                  const SizedBox(width: 16),
                                ],
                              ),

                              // 🔹 Titre + Solde
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Commande",
                                      style: Appstyle.textXL_B
                                          .copyWith(color: Appstyle.noir)),
                                  SoldeWidget(
                                    solde: "${widget.solde}.00 DA",
                                    dernier_modif: "24/02/2025",
                                  ),
                                ],
                              ),
                              SizedBox(height: paddingV),

                              // 🔹 Bouton + période
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  const SizedBox(width: 1),
                                  const PeriodSelector(),
                                  MainButton(
                                    text: "Nouveau",
                                    color: Appstyle.rose,
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        barrierColor:
                                        Appstyle.blueF.withOpacity(0.3),
                                        builder: (context) {
                                          return CommanderProduitDialog(
                                              solde: widget.solde);
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),

                              SizedBox(height: paddingV),

                              // 🔹 Barre recherche + filtres
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Mes commandes",
                                      style: Appstyle.textL_B),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 200,
                                        child: DropdownButtonFormField<String>(
                                          decoration: InputDecoration(
                                            labelText: "État",
                                            border: OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius.circular(12),
                                            ),
                                            contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                          ),
                                          value: selectedEtat.isEmpty
                                              ? null
                                              : selectedEtat,
                                          items: [
                                            const DropdownMenuItem(
                                                value: '', child: Text("Tous")),
                                            ...etats.map((e) => DropdownMenuItem(
                                                value: e, child: Text(e))),
                                          ],
                                          onChanged: (value) {
                                            setState(() {
                                              selectedEtat = value ?? '';
                                            });
                                          },
                                        ),
                                      ),
                                      SizedBox(width: 20,),
                                      SizedBox(
                                        width: 200,
                                        child: DropdownButtonFormField<String>(
                                          decoration: InputDecoration(
                                            labelText: "Produit",
                                            border: OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius.circular(12),
                                            ),
                                            contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                          ),
                                          value: selectedProduit.isEmpty
                                              ? null
                                              : selectedProduit,
                                          items: [
                                            const DropdownMenuItem(
                                                value: '', child: Text("Tous")),
                                            ...produits.map((p) => DropdownMenuItem(
                                                value: p, child: Text(p))),
                                          ],
                                          onChanged: (value) {
                                            setState(() {
                                              selectedProduit = value ?? '';
                                            });
                                          },
                                        ),
                                      ),
                                      SizedBox(width: 20,),
                                      SizedBox(
                                        width: 250,
                                        child: SearchField(controller: _controller),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              SizedBox(height: paddingV),

                              // 🧾 Liste des factures filtrées
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: filteredFactures.map((f) {
                                      return Padding(
                                        padding:
                                        const EdgeInsets.only(bottom: 15.0),
                                        child: FactureWidget(
                                          quantite: f['quantite'],
                                          produit: f['produit'],
                                          livre: f['livre'],
                                          pallete: f['pallete'],
                                          montant: f['montant'],
                                          date: f['date'],
                                          etat: f['etat'],
                                          nClient: f['nClient'],
                                          nCommande: f['nCommande'], slot: f['slot'],
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ],
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
