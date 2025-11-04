import 'package:flutter/material.dart';
import 'package:qanaty/core/utilis/responsive.dart';
import 'package:qanaty/core/widget/acount_widget.dart';
import 'package:qanaty/core/widget/main_button.dart';
import 'package:qanaty/core/widget_guedila/acount_widget_company.dart';
import 'package:qanaty/core/widget_guedila/produit_widget.dart';
import 'package:qanaty/data/produits.dart';
import '../../core/widget_guedila/produit_nouveau_dialog.dart';
import '../../core/widget_guedila/side_bar.dart';
import '../../core/theme/app_style.dart';
import '../../core/widget/search_field.dart';
import '../../core/widget_guedila/compte_nouveua_Dialog.dart';
import '../../core/widget_guedila/compte_widget.dart';

class ProduitsC extends StatefulWidget {
  final String username = "Oussama Bensbaa";
  final double solde = 100000.00;

  ProduitsC({Key? key}) : super(key: key);

  @override
  State<ProduitsC> createState() => _ComptesState();
}

class _ComptesState extends State<ProduitsC> {
  List<Map<String, String>> produitsGuedila = [
    {
      'idProduit': '1',
      'nomProduit': 'Bouteille 0.33 L',
      'categorie': 'Normal',
      'etat': 'Actif',
      'date': 'Sep 13, 2020',
      'taille': '0.33 L',
      'prix': '10',
      'qtdefardo': '24',
      'qtdepalette': '48',
      'createur': 'Imad'
    },
    {
      'idProduit': '2',
      'nomProduit': 'Bouteille 0.33 L Sport',
      'categorie': 'Sport',
      'etat': 'Actif',
      'date': 'Sep 13, 2020',
      'taille': '0.33 L',
      'prix': '12',
      'qtdefardo': '24',
      'qtdepalette': '48',
      'createur': 'Imad'
    },
    {
      'idProduit': '3',
      'nomProduit': 'Bouteille 0.5 L',
      'categorie': 'Normal',
      'etat': 'Actif',
      'date': 'Sep 13, 2020',
      'taille': '0.5 L',
      'prix': '15',
      'qtdefardo': '20',
      'qtdepalette': '40',
      'createur': 'Imad'
    },
    {
      'idProduit': '4',
      'nomProduit': 'Bouteille 0.5 L Sport',
      'categorie': 'Sport',
      'etat': 'Actif',
      'date': 'Sep 13, 2020',
      'taille': '0.5 L',
      'prix': '17',
      'qtdefardo': '20',
      'qtdepalette': '40',
      'createur': 'Imad'
    },
    {
      'idProduit': '5',
      'nomProduit': 'Bouteille 1 L',
      'categorie': 'Normal',
      'etat': 'Actif',
      'date': 'Sep 13, 2020',
      'taille': '1 L',
      'prix': '20',
      'qtdefardo': '20',
      'qtdepalette': '40',
      'createur': 'Imad'
    },
    {
      'idProduit': '6',
      'nomProduit': 'Bouteille 1.5 L',
      'categorie': 'Normal',
      'etat': 'Actif',
      'date': 'Sep 13, 2020',
      'taille': '1.5 L',
      'prix': '25',
      'qtdefardo': '12',
      'qtdepalette': '24',
      'createur': 'Imad'
    },
    {
      'idProduit': '7',
      'nomProduit': 'Bouteille 2 L',
      'categorie': 'Normal',
      'etat': 'Actif',
      'date': 'Sep 13, 2020',
      'taille': '2 L',
      'prix': '30',
      'qtdefardo': '6',
      'qtdepalette': '12',
      'createur': 'Imad'
    },
  ];

  // 🔹 Filtres sélectionnés
  String selectedCategorie = '';
  String selectedEtat = '';
  final TextEditingController _searchController = TextEditingController();

  // 🔹 Fonction pour filtrer les comptes
  List<Map<String, dynamic>> get filteredAccounts {
    return produitsGuedila.where((acc) {
      final categorieMatch =
          selectedCategorie.isEmpty || acc['categorie'] == selectedCategorie;
      final etatMatch = selectedEtat.isEmpty || acc['etat'] == selectedEtat;
      return  categorieMatch && etatMatch ;
    }).toList();
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
          final adjustedHeight =
          screenHeight < minHeight ? minHeight : screenHeight;
          final paddingV = adjustedHeight * 0.03;
          final paddingH = adjustedWidth * 0.03;

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: ConstrainedBox(
                constraints:
                const BoxConstraints(minWidth: minWidth, minHeight: minHeight),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    width: adjustedWidth,
                    height: adjustedHeight,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 🔹 Barre latérale
                        SizedBox(
                          width: Responsive.sidebarWidth(adjustedWidth),
                          height: Responsive.sidebarHeight(adjustedHeight),
                          child: SideBarWidgetC(),
                        ),
                        SizedBox(width: paddingH),

                        // 🔹 Zone principale
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // 🔹 Barre supérieure
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
                                    name: "Oussama Bensbaa",
                                    imageUrl: "assets/images/support.png",
                                  ),
                                  const SizedBox(width: 16),
                                ],
                              ),

                              // 🔹 Titre
                              Text(
                                "Produits",
                                style: Appstyle.textXL_B
                                    .copyWith(color: Appstyle.noir),
                              ),
                              SizedBox(height: paddingV),

                              // 🔹 Ligne des filtres
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [

                                // Filter
                                  Row(
                                    children: [
                                      // 🔹 Catégorie
                                      SizedBox(
                                        width: 180,
                                        child: DropdownButtonFormField<String>(
                                          value: selectedCategorie,
                                          decoration: InputDecoration(
                                            labelText: "Catégorie",
                                            border: OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius.circular(12),
                                            ),
                                          ),
                                          items: [
                                            const DropdownMenuItem(
                                                value: '', child: Text("Toutes")),
                                            ...produitsGuedila
                                                .map((a) =>
                                            a['categorie']?.toString() ?? '')
                                                .where((cat) => cat.isNotEmpty)
                                                .toSet()
                                                .map((cat) => DropdownMenuItem(
                                              value: cat,
                                              child: Text(cat),
                                            ))
                                                .toList(),
                                          ],
                                          onChanged: (val) =>
                                              setState(() => selectedCategorie = val ?? ''),
                                        ),
                                      ),
                                      SizedBox(width: 20,),
                                      // 🔹 Statut
                                      SizedBox(
                                        width: 180,
                                        child: DropdownButtonFormField<String>(
                                          value: selectedEtat,
                                          decoration: InputDecoration(
                                            labelText: "Status",
                                            border: OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius.circular(12),
                                            ),
                                          ),
                                          items: const [
                                            DropdownMenuItem(
                                                value: '', child: Text("Tous")),
                                            DropdownMenuItem(
                                                value: 'Actif', child: Text("Actif")),
                                            DropdownMenuItem(
                                                value: 'Désactivé',
                                                child: Text("Désactivé")),
                                          ],
                                          onChanged: (val) =>
                                              setState(() => selectedEtat = val ?? ''),
                                        ),
                                      ),
                                    ],
                                  ),

                                  // 🔹 Recherche + bouton Ajouter
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 300,
                                        child: SearchField(
                                          controller: _searchController,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      MainButton(
                                        text: "Ajouter",
                                        color: Appstyle.rose,
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (_) => NewProduitDialog(),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              const SizedBox(height: 40),

                              // 🔹 Liste filtrée des comptes
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: filteredAccounts.map((acc) {
                                      return Padding(
                                        padding:
                                        const EdgeInsets.only(bottom: 15),
                                        child: ProduitWidget(
                                          createur: acc['createur'],
                                          date: acc['date'],
                                          etat: acc['etat'] == 'Actif',
                                          id: acc['idProduit'],
                                          nom: acc['nomProduit'],
                                          taille: acc['taille'],
                                          prix: acc['prix'],
                                          categorie: acc['categorie'],
                                          nombrefardos: acc['qtdefardo'],
                                          nombrepalette: acc['qtdepalette'],
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
