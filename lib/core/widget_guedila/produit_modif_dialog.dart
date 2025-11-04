import 'package:flutter/material.dart';
import 'package:qanaty/core/theme/app_style.dart';
import 'package:qanaty/core/widget/main_button.dart';

bool modification = false;

/// Fonction pour afficher le Dialog de modification produit
void showModifProduitDialog(
    BuildContext context, {
      required String id,
      required String nom,
      required String taille,
      required String prix,
      required String categorie,
      required String nombrefardos,
      required String nombrepalette,
    }) {
  showDialog(
    context: context,
    builder: (context) {
      return ModifProduitDialog(
        id: id,
        nom: nom,
        taille: taille,
        prix: prix,
        categorie: categorie,
        nombrefardos: nombrefardos,
        nombrepalette: nombrepalette,
      );
    },
  );
}

/// Dialog multi-étapes pour la modification du produit
class ModifProduitDialog extends StatefulWidget {
  final String id;
  final String nom;
  final String taille;
  final String prix;
  final String categorie;
  final String nombrefardos;
  final String nombrepalette;

  const ModifProduitDialog({
    super.key,
    required this.id,
    required this.nom,
    required this.taille,
    required this.prix,
    required this.categorie,
    required this.nombrefardos,
    required this.nombrepalette,
  });

  @override
  _ModifProduitDialogState createState() => _ModifProduitDialogState();
}

class _ModifProduitDialogState extends State<ModifProduitDialog> {
  int currentStep = 0;

  // Champs de saisie
  late TextEditingController idProduitController;
  late TextEditingController nomProduitController;
  late TextEditingController tailleController;
  late TextEditingController prixController;
  late TextEditingController fardosController;
  late TextEditingController paletteController;

  String? categorie;

  @override
  void initState() {
    super.initState();
    idProduitController = TextEditingController(text: widget.id);
    nomProduitController = TextEditingController(text: widget.nom);
    tailleController = TextEditingController(text: widget.taille);
    prixController = TextEditingController(text: widget.prix);
    fardosController = TextEditingController(text: widget.nombrefardos);
    paletteController = TextEditingController(text: widget.nombrepalette);
    categorie = widget.categorie;
  }

  @override
  void dispose() {
    idProduitController.dispose();
    nomProduitController.dispose();
    tailleController.dispose();
    prixController.dispose();
    fardosController.dispose();
    paletteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500, maxHeight: 700),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Appstyle.blanc,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(child: _buildStepContent()),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 🔹 Étape 0 → Bouton "Suivant" seul
                  if (currentStep == 0) ...[
                    const Spacer(),
                    MainButton(
                      text: "Suivant",
                      icon: Icons.arrow_forward,
                      iconOnRight: true,
                      color: Appstyle.rose,
                      onPressed: () {
                        if (_validateStep1()) {
                          setState(() => currentStep++);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Veuillez remplir tous les champs."),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      },
                    ),
                  ]

                  // 🔹 Étape 1 → Bouton "Retour" + "Enregistrer"
                  else if (currentStep == 1) ...[
                    TextButton(
                      onPressed: () => setState(() => currentStep--),
                      child: const Text("← Retour"),
                    ),
                    const Spacer(),
                    MainButton(
                      text: "Enregistrer",
                      noIcon: true,
                       color: Appstyle.rose,
                      onPressed: () {
                        modification = true; // 🔸 succès simulé
                        setState(() => currentStep++);
                      },
                    ),
                  ]

                  // 🔹 Étape 2 → Bouton "Terminer" centré seul
                  else if (currentStep == 2) ...[
                      MainButton(
                        text: "Terminer",
                        icon: Icons.check,
                        iconOnRight: true,
                        color: Appstyle.rose,
                        onPressed: () {
                          Navigator.pop(context); // 🔹 Ferme le popup
                        },
                      ),
                    ],
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  /// Validation étape 1
  bool _validateStep1() {
    return nomProduitController.text.isNotEmpty &&
        tailleController.text.isNotEmpty &&
        prixController.text.isNotEmpty &&
        fardosController.text.isNotEmpty &&
        paletteController.text.isNotEmpty &&
        categorie != null;
  }

  /// Contenu selon l’étape
  Widget _buildStepContent() {
    switch (currentStep) {
      case 0:
        return _buildStep1Form();
      case 1:
        return _buildStep2Confirmation();
      case 2:
        return _buildStep3Result();
      default:
        return const SizedBox.shrink();
    }
  }

  /// Étape 1 : Saisie
  Widget _buildStep1Form() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Modifier le produit", style: Appstyle.textS_B.copyWith(color: Appstyle.noir)),
          const SizedBox(height: 20),

          _buildLabel("ID Produit"),
          TextField(
            controller: idProduitController,
            enabled: false,
            decoration: _inputDecoration(),
          ),
          const SizedBox(height: 16),

          _buildLabel("Nom du produit"),
          TextField(
            controller: nomProduitController,
            decoration: _inputDecoration(),
          ),
          const SizedBox(height: 16),

          _buildLabel("Taille (L)"),
          TextField(
            controller: tailleController,
            keyboardType: TextInputType.number,
            decoration: _inputDecoration(),
          ),
          const SizedBox(height: 16),

          _buildLabel("Prix (DA)"),
          TextField(
            controller: prixController,
            keyboardType: TextInputType.number,
            decoration: _inputDecoration(),
          ),
          const SizedBox(height: 16),

          _buildLabel("Catégorie"),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            children: ["Normal", "Sport"].map((cat) {
              final isSelected = categorie == cat;
              return GestureDetector(
                onTap: () => setState(() => categorie = cat),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: isSelected ? Appstyle.blueC : Appstyle.grisC,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    cat,
                    style: Appstyle.textS_B.copyWith(
                      color: isSelected ? Colors.white : Appstyle.noir,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),

          _buildLabel("Bouteilles par fardos"),
          TextField(
            controller: fardosController,
            keyboardType: TextInputType.number,
            decoration: _inputDecoration(),
          ),
          const SizedBox(height: 16),

          _buildLabel("Bouteilles par palette"),
          TextField(
            controller: paletteController,
            keyboardType: TextInputType.number,
            decoration: _inputDecoration(),
          ),
        ],
      ),
    );
  }

  /// Étape 2 : Confirmation
  Widget _buildStep2Confirmation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Vérification des informations", style: Appstyle.textS_B.copyWith(color: Appstyle.noir)),
        const SizedBox(height: 20),
        _buildInfoRow("ID Produit", idProduitController.text),
        _buildInfoRow("Nom", nomProduitController.text),
        _buildInfoRow("Taille", "${tailleController.text} L"),
        _buildInfoRow("Prix", "${prixController.text} DA"),
        _buildInfoRow("Catégorie", categorie),
        _buildInfoRow("Bouteilles / Fardos", fardosController.text),
        _buildInfoRow("Bouteilles / Palette", paletteController.text),
        const SizedBox(height: 30),
        Center(
          child: Text(
            "Confirmez avant d’enregistrer les modifications.",
            style: Appstyle.textS_B.copyWith(color: Appstyle.gris),
          ),
        ),
      ],
    );
  }

  /// Étape 3 : Résultat
  Widget _buildStep3Result() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          modification ? "Produit modifié" : "Erreur de modification",
          style: Appstyle.textS_B.copyWith(color: Appstyle.noir),
        ),
        const SizedBox(height: 40),
        Image.asset(
          modification ? "assets/icons/nike_icon.png" : "assets/icons/croix_icon.png",
          width: 120,
          height: 120,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 40),
        Text(
          modification
              ? "Le produit a été mis à jour avec succès."
              : "Une erreur est survenue, réessayez.",
          textAlign: TextAlign.center,
          style: Appstyle.textS_B.copyWith(color: Appstyle.gris),
        ),
      ],
    );
  }

  /// Widgets utilitaires
  InputDecoration _inputDecoration() {
    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    );
  }

  Widget _buildLabel(String label) {
    return Text(label, style: Appstyle.textS_B.copyWith(color: Appstyle.noir));
  }

  Widget _buildInfoRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(flex: 2, child: Text(label, style: Appstyle.textS_B.copyWith(color: Appstyle.gris))),
          Expanded(flex: 3, child: Text(value ?? "-", style: Appstyle.textS_B.copyWith(color: Appstyle.noir))),
        ],
      ),
    );
  }
}
