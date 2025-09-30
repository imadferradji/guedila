import 'package:flutter/material.dart';
import 'package:qanaty/core/theme/app_style.dart';
import 'package:qanaty/core/widget/main_button.dart';
import 'package:qanaty/core/widget/palette_selectionne.dart';
import 'package:qanaty/core/widget/produit_selectionne.dart';

import '../../data/models/produi.dart';

/// Modèle Produit

/// Exemple de produits
List<Produit> produits = [
  Produit(
    nom: "Bouteille 1.5 L",
    image: "assets/icons/eau_15l_icon.png",
    bouteillesParPalette: 100,
    prix: 22800,
  ),
  Produit(
    nom: "Bouteille 1 L",
    image: "assets/icons/eau_1l_icon.png",
    bouteillesParPalette: 120,
    prix: 18000,
  ),
  Produit(
    nom: "Bouteille 2 L",
    image: "assets/icons/eau_2l_icon.png",
    bouteillesParPalette: 80,
    prix: 25000,
  ),
  Produit(
    nom: "Bouteille 0.33 Cl",
    image: "assets/icons/eau_33l_icon.png",
    bouteillesParPalette: 80,
    prix: 25000,
  ),
  Produit(
    nom: "Bouteille 0.33 L Sport",
    image: "assets/icons/eau_33l_sport_icon.png",
    bouteillesParPalette: 80,
    prix: 25000,
  ),
  Produit(
    nom: "Bouteille 0.5 L Sport",
    image: "assets/icons/eau_05l_sport_icon.png",
    bouteillesParPalette: 80,
    prix: 25000,
  ),
];
Map<Produit, int> panier = {};
bool palette = false;
double prix_palette=10000.00;

/// Fonction pour afficher le Dialog
void showNouvelleCommandeDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return CommanderProduitDialog();
    },
  );
}

int get totalnombrepalette {
  int total = 0;
  panier.forEach((produit, qte) {
    total += qte;
  });
  return total;
}

double get totalCommande {
  double total = 0;
  panier.forEach((produit, qte) {
    total += produit.prix * qte;
  });
  if (palette) {
    total += prix_palette;
  }
  return total;
}
/// Dialog multi-étapes
class CommanderProduitDialog extends StatefulWidget {
  @override
  _CommanderProduitDialog createState() => _CommanderProduitDialog();
}

class _CommanderProduitDialog extends State<CommanderProduitDialog> {
  int currentStep = 0;

  // Données étape 1
  int currentIndex = 0;

  // ✅ Déclaration du contrôleur pour le carrousel
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.7);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: 500,
        height: 850,
        decoration: BoxDecoration(
          color: Appstyle.blanc,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: _buildStepContent()),
            Row(
              children: [
                if (currentStep > 0)
                  TextButton(
                    onPressed: () => setState(() => currentStep--),
                    child: const Text("← Retour"),
                  ),
                const Spacer(),
                MainButton(
                  text: "Suivant",
                  icon: Icons.arrow_forward,
                  iconOnRight: true,
                  color: Appstyle.rose,
                  onPressed: () {
                    if (currentStep < 2) {
                      setState(() => currentStep++);
                    } else {
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Contenu selon l’étape
  Widget _buildStepContent() {
    switch (currentStep) {
      case 0:
        return _buildStep1ProduitQuantite();
      case 1:
        return _buildStep2Palette();
      case 2:
        return _buildStep3Confirmation();
      default:
        return SizedBox.shrink();
    }
  }

  /// Étape 1 : Produit & Quantité
  Widget _buildStep1ProduitQuantite() {
    Produit produit = produits[currentIndex];
    int quantite = panier[produit] ?? 0; // ✅ la vraie source
    double montant = produit.prix * quantite;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // TItre
        Text(
          "Nouvelle commande",
          style: Appstyle.textS_B.copyWith(color: Appstyle.noir),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Image.asset(
              "assets/icons/commande_icon.png",
              width: 20,
              height: 20,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 10),
            Text(
              "Produit & Quantité",
              style: Appstyle.textS_B.copyWith(color: Appstyle.gris),
            ),
          ],
        ),

        // --- Carrousel Produits ---
        SizedBox(
          height: 250,
          child: PageView.builder(
            itemCount: produits.length,
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              final p = produits[index];
              final isSelected = index == currentIndex;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    currentIndex = index;
                  });
                  _pageController.animateToPage(
                    index,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  margin: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Colors.blue.shade50
                        : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isSelected ? Colors.blue : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(p.image, height: isSelected ? 140 : 110),
                      SizedBox(height: 10),
                      Text(
                        p.nom,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isSelected ? Colors.blue : Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),

        SizedBox(height: 20),

        // --- Sélecteur quantité ---
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Quantité :",
              style: Appstyle.textS_B.copyWith(color: Appstyle.grisC),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    if (quantite > 0) {
                      setState(() => panier[produit] = quantite - 1);
                    }
                  },
                  icon: Icon(
                    Icons.remove_circle,
                    size: 32,
                    color: Appstyle.grisC,
                  ),
                ),
                Container(
                  width: 60,
                  alignment: Alignment.center,
                  child: Text(
                    "$quantite",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() => panier[produit] = quantite + 1);
                  },
                  icon: Icon(Icons.add_circle, size: 32, color: Appstyle.blueF),
                ),
              ],
            ),
          ],
        ),

        // ---- Infos produit ----
        Row(
          children: [
            Text(
              "Produit : ",
              style: Appstyle.textS_B.copyWith(color: Appstyle.grisC),
            ),
            const SizedBox(width: 10),
            Text(
              produit.nom,
              style: Appstyle.textS_B.copyWith(color: Appstyle.noir),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Text(
              "Palette : ",
              style: Appstyle.textS_B.copyWith(color: Appstyle.grisC),
            ),
            const SizedBox(width: 10),
            Text(
              "${produit.bouteillesParPalette} bouteilles",
              style: Appstyle.textS_B.copyWith(color: Appstyle.noir),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Text(
              "Prix : ",
              style: Appstyle.textS_B.copyWith(color: Appstyle.grisC),
            ),
            const SizedBox(width: 10),
            Text(
              "${produit.prix.toStringAsFixed(2)} DA",
              style: Appstyle.textS_B.copyWith(color: Appstyle.rose),
            ),
          ],
        ),
        const SizedBox(height: 20),

        SizedBox(height: 20),

        // --- Montant produit ---
        Row(
          children: [
            Text(
              "Total produit : ",
              style: Appstyle.textS_B.copyWith(color: Appstyle.grisC),
            ),
            SizedBox(width: 10),
            Text(
              "${montant.toStringAsFixed(2)} DA",
              style: Appstyle.textS_B.copyWith(color: Appstyle.blueF),
            ),
          ],
        ),

        SizedBox(height: 20),

        // --- Total commande ---
        Row(
          children: [
            Text(
              "Total de commande :",
              style: Appstyle.textM_B.copyWith(color: Appstyle.gris),
            ),
            SizedBox(width: 10),
            Text(
              "${totalCommande.toStringAsFixed(2)} DA",
              style: Appstyle.textM_B.copyWith(color: Appstyle.blueF),
            ),
          ],
        ),
      ],
    );
  }

  /// Étape 2 : Palette
  Widget _buildStep2Palette() {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Nouvelle commande",
              style: Appstyle.textS_B.copyWith(color: Appstyle.noir),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Image.asset(
                  "assets/icons/palette_icon.png",
                  width: 20,
                  height: 20,
                  fit: BoxFit.contain,
                ),
                const SizedBox(width: 10),
                Text(
                  "Palette",
                  style: Appstyle.textS_B.copyWith(color: Appstyle.gris),
                ),
              ],
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Text(
              "Merci de nous confirmer si votre commande est avec ou sans palette",
              style: Appstyle.textS_B.copyWith(color: Appstyle.grisC),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 20),

            // --- Nombre de palette ---
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/icons/palette_icon.png",
                    width: 70,
                    height:70,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "$totalnombrepalette Palettes",
                    style: Appstyle.textL_B.copyWith(color: Appstyle.gris),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // --- Prix palette ---
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Prix palette : ",
                  style: Appstyle.textS_B.copyWith(color: Appstyle.grisC),
                ),
                const SizedBox(width: 10),
                Text(
                  "${prix_palette.toStringAsFixed(2)} DA",
                  style: Appstyle.textS_B.copyWith(color: Appstyle.noir),
                ),
              ],
            ),
            const SizedBox(height: 40),

            // --- Boutons OUI / NON ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Bouton OUI
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (!palette) {
                        palette = true;
                        // ajoute
                      }
                    });
                  },
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: palette ? Appstyle.rose : Appstyle.grisC,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "Oui",
                      style: Appstyle.textS_B.copyWith(
                        color: palette ? Colors.white : Appstyle.blanc,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),

                // Bouton NON
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (palette) {
                        palette = false;
                        }
                    });
                  },
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: !palette ? Appstyle.rose : Appstyle.grisC,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "Non",
                      style: Appstyle.textS_B.copyWith(
                        color: !palette ? Colors.white : Appstyle.blanc,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 180),

            // --- Total commande ---
             ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Total commande ---
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Total de commande :",
                  style: Appstyle.textM_B.copyWith(color: Appstyle.gris),
                ),
                const SizedBox(width: 10),
                Text(
                  "${totalCommande.toStringAsFixed(2)} DA",
                  style: Appstyle.textM_B.copyWith(color: Appstyle.blueF),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  /// Étape 3 : Confrimation
  Widget _buildStep3Confirmation() {
    Produit produit = produits[currentIndex];

    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Nouvelle commande",
              style: Appstyle.textS_B.copyWith(color: Appstyle.noir),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Image.asset(
                  "assets/icons/nike_gris_icon.png",
                  width: 20,
                  height: 20,
                  fit: BoxFit.contain,
                ),
                const SizedBox(width: 10),
                Text(
                  "Confirmation",
                  style: Appstyle.textS_B.copyWith(color: Appstyle.gris),
                ),
              ],
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              "Votre commande est comme suit :",
              style: Appstyle.textS_B.copyWith(color: Appstyle.grisC),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 200, // limite la hauteur
              child: SingleChildScrollView(
                child: Column(
                  children: panier.entries.map((entry) {
                    final produit = entry.key;
                    final quantite = entry.value;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: ProduitSelectionne(
                        quantite: quantite.toString(),
                        produit: produit.nom,
                        montant: (produit.prix * quantite).toStringAsFixed(2) + " DA",
                        onDelete: () {
                          setState(() {
                            panier.remove(produit);
                          });
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),



            const SizedBox(height: 10),



            // --- Total commande ---
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Total commande ---
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Total :",
                  style: Appstyle.textM_B.copyWith(color: Appstyle.gris),
                ),
                const SizedBox(width: 10),
                Text(
                  "${(palette?(totalCommande-prix_palette):totalCommande).toStringAsFixed(2)} DA",
                  style: Appstyle.textM_B.copyWith(color: Appstyle.blueF),
                ),
              ],
            ),
          ],
        ),
        // ✅ Ligne Palette si choisie
        const SizedBox(height: 40),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // --- Total commande ---
            if (palette)
              PaletteSelectionne(
                quantite: totalnombrepalette.toString(),
                montant: prix_palette.toStringAsFixed(2) + " DA",
              ),

          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Total commande ---
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Total de commande:",
                  style: Appstyle.textM_B.copyWith(color: Appstyle.gris),
                ),
                const SizedBox(width: 10),
                Text(
                  "${totalCommande.toStringAsFixed(2)} DA",
                  style: Appstyle.textM_B.copyWith(color: Appstyle.blueF),
                ),
              ],
            ),
          ],
        ),
      ],
    );

  }
}

class LigneCommande {
  final Produit produit;
  final int quantite;
  double get montant => produit.prix * quantite;

  LigneCommande({required this.produit, required this.quantite});
}
