import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:qanaty/core/theme/app_style.dart';
import 'package:qanaty/core/widget/main_button.dart';
import 'package:qanaty/core/widget/palette_selectionne.dart';
import 'package:qanaty/core/widget/produit_selectionne.dart';

import '../../data/camions.dart';
import '../../data/chauffeurs.dart';
import '../../data/models/produit.dart';
import '../../data/produits.dart';
import '../../screens/api_service.dart';

/// Exemple de panier
Map<Produit, int> panier = {};
bool palette = false;
String nom_chauffeur = "";
String matricule_camion = "";
bool chaufeur = false;
double prix_palette = 10000.00;
bool commande_confirme = false;

/// Fonction pour afficher le Dialog
void showNouvelleCommandeDialog(BuildContext context, double solde, {VoidCallback? onCommandeCreated}) {
  panier.clear();
  palette = false;
  commande_confirme = false;
  showDialog(
    context: context,
    builder: (context) {
      return CommanderProduitDialog(solde: solde, onCommandeCreated: onCommandeCreated);
    },
  );
}

/// total nombre de palettes
int get totalnombrepalette {
  int total = 0;
  panier.forEach((produit, qte) {
    total += qte;
  });
  return total;
}

/// total montant commande
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
  final double solde;
  final VoidCallback? onCommandeCreated;

  const CommanderProduitDialog({super.key, required this.solde, this.onCommandeCreated});

  @override
  _CommanderProduitDialog createState() => _CommanderProduitDialog();
}

class _CommanderProduitDialog extends State<CommanderProduitDialog> {
  int currentStep = 0;
  int currentIndex = 0;
  String? selectedChauffeur;
  String? selectedCamion;
  bool _isLoading = false;

  // ✅ Déclaration du contrôleur pour le carrousel
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    panier.clear();
    palette = false;
    commande_confirme = false;
    _pageController = PageController(viewportFraction: 0.7);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // Function to save command to database
  // Function to save command to database
  // Function to save command to database
// Function to save command to database
  Future<void> _saveCommandeToDatabase() async {
    if (panier.isEmpty) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // Get user email from SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final userEmail = prefs.getString('userEmail') ?? '';

      // Calculate total amount properly
      double totalAmount = 0;
      String productNames = '';

      panier.forEach((produit, quantite) {
        final productTotal = produit.prix * quantite;
        totalAmount += productTotal;
        productNames += '${produit.nom} (x$quantite), ';
      });

      // Add palette cost if selected
      if (palette) {
        totalAmount += prix_palette;
      }

      // Remove trailing comma
      if (productNames.isNotEmpty) {
        productNames = productNames.substring(0, productNames.length - 2);
      }

      // Use the first product as main product, or combine all
      final mainProduct = panier.keys.first;
      final totalQuantity = totalnombrepalette;

      print('💰 Calculated total: $totalAmount');
      print('📦 Products: $productNames');
      print('🔢 Total quantity: $totalQuantity');

      // Use proper date format (YYYY-MM-DD)
      final now = DateTime.now();
      final formattedDate = "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";

      final response = await ApiService.createCommande(
        userEmail: userEmail,
        quantite: totalQuantity.toString(), // Send total quantity
        produit: productNames.isEmpty ? mainProduct.nom : productNames, // Send all product names
        dateCommande: formattedDate,
        montant: totalAmount.toStringAsFixed(2),
        pallete: palette ? 'Oui' : 'Non',
      );

      final responseData = json.decode(response.body);

      print('📊 Create commande response status: ${response.statusCode}');
      print('📊 Response data: $responseData');

      if (response.statusCode == 201 && responseData['success'] == true) {
        print('✅ Commande created successfully! New solde: ${responseData['newSolde']}');

        // Success - close dialog and refresh list
        if (widget.onCommandeCreated != null) {
          widget.onCommandeCreated!();
        }

        // Show success message with new solde
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Commande créée! Nouveau solde: ${responseData['newSolde'] ?? "N/A"} DA'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 5),
            ),
          );
        }

        // Wait a bit before closing to show the message
        await Future.delayed(Duration(seconds: 2));
        Navigator.of(context).pop();
      } else {
        print('❌ Failed to create commande: ${responseData['message']}');
        // Show error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(responseData['message'] ?? 'Erreur lors de la création'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 5),
          ),
        );
      }
    } catch (e) {
      print('❌ Error creating commande: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur de connexion: $e'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 5),
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(20), // évite que ça colle aux bords
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // On calcule la hauteur réelle dispo
          final screenHeight = MediaQuery.of(context).size.height;

          return ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 500, // largeur fixe
              maxHeight: screenHeight - 40, // 👈 garde marge même si petit écran
            ),
            child: Container(
              width: 500,
              height: 850, // taille "idéale"
              decoration: BoxDecoration(
                color: Appstyle.blanc,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView( // 👈 scroll si ça dépasse
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 750, // contenu fixe, scrollable si petit écran
                      child: _buildStepContent(),
                    ),
                    Row(
                      children: [
                        if (currentStep > 0 && currentStep < 4)
                          TextButton(
                            onPressed: _isLoading ? null : () => setState(() => currentStep--),
                            child: const Text("← Retour"),
                          ),
                        if (currentStep == 4)
                          Expanded(
                            child: Center(
                              child: MainButton(
                                text: "Terminer",
                                icon: Icons.check,
                                iconOnRight: true,
                                color: Appstyle.rose,
                                onPressed: _isLoading ? () {} : () => setState(() => currentStep--),
                              ),
                            ),
                          )
                        else ...[
                          const Spacer(),
                          MainButton(
                            text: currentStep == 3 ? "Payer" : "Suivant",
                            icon: Icons.arrow_forward,
                            iconOnRight: true,
                            color: Appstyle.rose,
                            onPressed: _isLoading ? () {} : () {
                              if (currentStep == 0) {
                                // ✅ Vérifie si la quantité du produit sélectionné est > 0
                                if (totalnombrepalette > 0) {
                                  setState(() => currentStep++);
                                } else {
                                  // Affiche un message d'erreur
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Veuillez sélectionner au moins une quantité avant de continuer."),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                }
                              } else if (currentStep < 3) {
                                setState(() => currentStep++);
                              } else if (currentStep == 3) {
                                // Payment step - check balance and save to database
                                if (widget.solde >= totalCommande) {
                                  _saveCommandeToDatabase();
                                  setState(() {
                                    commande_confirme = true;
                                    currentStep++;
                                  });
                                } else {
                                  setState(() {
                                    commande_confirme = false;
                                    currentStep++;
                                  });
                                }
                              }
                            },
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  /// Contenu étapes
  Widget _buildStepContent() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    switch (currentStep) {
      case 0:
        return _buildStep1ProduitQuantite();
      case 1:
        return _buildStep2Chau_camion();
      case 2:
        return _buildStep2Palette();
      case 3:
        return _buildStep3Confirmation();
      case 4:
        return _buildStep4Confirmation();
      default:
        return const SizedBox.shrink();
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

        SizedBox(height: 40),

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
        // --- Total commande ---

        SizedBox(height: 120),
        // --- Total nombre pallete commande ---

        Row(
          children: [
            Text(
              "Total de palette :",
              style: Appstyle.textM_B.copyWith(color: Appstyle.gris),
            ),
            SizedBox(width: 10),
            Text(
              "${totalnombrepalette.toStringAsFixed(0)}",
              style: Appstyle.textM_B.copyWith(color: Appstyle.blueF),
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

  /// Étape 2 : Chauffeur et camion
  Widget _buildStep2Chau_camion() {
    return Column(
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
              "assets/icons/chauffeur_icon.png",
              width: 20,
              height: 20,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 10),
            Text(
              "Chauffeur & Camion",
              style: Appstyle.textS_B.copyWith(color: Appstyle.gris),
            ),
          ],
        ),
        const SizedBox(height: 40),
        Text(
          "Vous voulez envoyé un chauffeur ?",
          style: Appstyle.textS_B.copyWith(color: Appstyle.gris),
        ),
        const SizedBox(height: 20),
        // Boutons Oui / Non
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  chaufeur = true;
                });
              },
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: chaufeur ? Appstyle.rose : Appstyle.grisC,
                ),
                alignment: Alignment.center,
                child: Text(
                  "Oui",
                  style: Appstyle.textS_B.copyWith(
                    color: chaufeur ? Colors.white : Appstyle.blanc,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  chaufeur = false;
                });
              },
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: !chaufeur ? Appstyle.rose : Appstyle.grisC,
                ),
                alignment: Alignment.center,
                child: Text(
                  "Non",
                  style: Appstyle.textS_B.copyWith(
                    color: !chaufeur ? Colors.white : Appstyle.blanc,
                  ),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 20),

        // --- Si chauffeur == true => afficher les listes déroulantes
        if (chaufeur) ...[
          const SizedBox(height: 20),
          Text("Sélectionnez un chauffeur :", style: Appstyle.textS_B),
          const SizedBox(height: 10),
          DropdownButtonFormField<String>(
            value: selectedChauffeur,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey.shade100,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
            items: chauffeurs.map((c) {
              return DropdownMenuItem<String>(
                value: c.nom,
                child: Text(c.nom, style: Appstyle.textS_B),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedChauffeur = value;
              });
            },
          ),

          const SizedBox(height: 20),
          Text("Sélectionnez un camion :", style: Appstyle.textS_B),
          const SizedBox(height: 10),
          DropdownButtonFormField<String>(
            value: selectedCamion,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey.shade100,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
            items: camions.map((c) {
              return DropdownMenuItem<String>(
                value: c.Matricule,
                child: Text(c.Matricule, style: Appstyle.textS_B),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedCamion = value;
              });
            },
          ),
        ],

        chaufeur ? SizedBox(height: 270) : SizedBox(height: 470),

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

  /// Étape 3 : Palette
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
                    height: 70,
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

  /// Étape 4 : Confrimation
  Widget _buildStep3Confirmation() {
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
              height: 260, // limite la hauteur
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

            // ✅ Affichage chauffeur et camion si choisi

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
                  "${(palette ? (totalCommande - prix_palette) : totalCommande).toStringAsFixed(2)} DA",
                  style: Appstyle.textM_B.copyWith(color: Appstyle.blueF),
                ),
              ],
            ),
          ],
        ),

        const SizedBox(height: 40),

        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (palette)
              PaletteSelectionne(
                quantite: totalnombrepalette.toString(),
                montant: prix_palette.toStringAsFixed(2) + " DA",
              ),
          ],
        ),

        const SizedBox(height: 10),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            const SizedBox(height: 20),
            if (chaufeur && selectedChauffeur != null && selectedCamion != null) ...[
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    "Chauffeur : ",
                    style: Appstyle.textS_B.copyWith(color: Appstyle.grisC),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    selectedChauffeur!,
                    style: Appstyle.textS_B.copyWith(color: Appstyle.noir),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    "Camion : ",
                    style: Appstyle.textS_B.copyWith(color: Appstyle.grisC),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    selectedCamion!,
                    style: Appstyle.textS_B.copyWith(color: Appstyle.noir),
                  ),
                ],
              ),
            ],
          ],
        ),
      ],
    );
  }

  /// Étape 5 : Message
  Widget _buildStep4Confirmation() {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              commande_confirme ? "Commande confirmé" : "Commande echoué",
              style: Appstyle.textS_B.copyWith(color: Appstyle.noir),
            ),
            const SizedBox(height: 120),
            Text(
              commande_confirme ? "Votre commande est bien confirmé !!" : "Solde client insufisant !!",
              style: Appstyle.textS_B.copyWith(color: Appstyle.noir),
            ),
            const SizedBox(height: 40),
            Image.asset(
              commande_confirme ? "assets/icons/nike_icon.png" : "assets/icons/croix_icon.png",
              width: 150,
              height: 150,
              fit: BoxFit.contain,
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