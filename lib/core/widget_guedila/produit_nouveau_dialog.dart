import 'package:flutter/material.dart';
import 'package:qanaty/core/theme/app_style.dart';
import 'package:qanaty/core/widget/main_button.dart';

bool all_saisie = false;
bool enregistrement = false;

/// Fonction pour afficher le Dialog d’ajout produit
void showAddProduitDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return const NewProduitDialog();
    },
  );
}

/// Dialog multi-étapes pour ajout produit
class NewProduitDialog extends StatefulWidget {
  const NewProduitDialog({super.key});

  @override
  _NewProduitDialogState createState() => _NewProduitDialogState();
}

class _NewProduitDialogState extends State<NewProduitDialog> {
  int currentStep = 0;

  // Champs de saisie
  final TextEditingController idProduitController = TextEditingController();
  final TextEditingController nomProduitController = TextEditingController();
  final TextEditingController tailleController = TextEditingController();
  final TextEditingController prixController = TextEditingController();
  final TextEditingController fardosController = TextEditingController();
  final TextEditingController paletteController = TextEditingController();

  String? categorie; // "Normal" ou "Sport"

  @override
  void initState() {
    super.initState();
    // ID produit auto-généré (exemple simple)
    idProduitController.text = "PRD-${DateTime.now().millisecondsSinceEpoch % 10000}";
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
                  // 🔹 Étape 0 → Suivant seul
                  if (currentStep == 0) ...[
                    const Spacer(),
                    MainButton(
                      text: "Suivant",
                      icon: Icons.arrow_forward,
                      iconOnRight: true,
                      color: Appstyle.rose,
                      onPressed: () {
                        if (_validateStep1()) {
                          all_saisie = true;
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

                  // 🔹 Étape 1 → Retour + Sauvegarder
                  else if (currentStep == 1) ...[
                    TextButton(
                      onPressed: () => setState(() => currentStep--),
                      child: const Text("← Retour"),
                    ),
                    const Spacer(),
                    MainButton(
                      text: "Sauvegarder",
                      noIcon: true,
                      color: Appstyle.rose,

                      onPressed: () {
                        enregistrement = true; // Simulation réussite
                        setState(() => currentStep++);
                      },
                    ),
                  ]

                  // 🔹 Étape 2 → Terminer seul et ferme le Dialog
                  else if (currentStep == 2) ...[
                      MainButton(
                        text: "Terminer",
                        icon: Icons.check,
                        iconOnRight: true,
                        color: Appstyle.rose,
                        onPressed: () {
                          Navigator.pop(context); // 🔸 Ferme la fenêtre
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

  /// Étape 1 : Saisie des informations
  Widget _buildStep1Form() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Nouveau produit", style: Appstyle.textS_B.copyWith(color: Appstyle.noir)),
          const SizedBox(height: 20),

          _buildLabel("ID Produit (auto)"),
          TextField(
            controller: idProduitController,
            enabled: false,
            decoration: _inputDecoration(),
          ),
          const SizedBox(height: 16),

          _buildLabel("Nom du produit"),
          TextField(
            controller: nomProduitController,
            decoration: _inputDecoration().copyWith(hintText: "Ex: Bouteille d'eau 1L"),
          ),
          const SizedBox(height: 16),

          _buildLabel("Taille (L)"),
          TextField(
            controller: tailleController,
            keyboardType: TextInputType.number,
            decoration: _inputDecoration().copyWith(hintText: "Ex: 0.33 L"),
          ),
          const SizedBox(height: 16),

          _buildLabel("Prix (DA)"),
          TextField(
            controller: prixController,
            keyboardType: TextInputType.number,
            decoration: _inputDecoration().copyWith(hintText: "Ex: 120 DA"),
          ),
          const SizedBox(height: 16),

          _buildLabel("Catégorie"),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            children: ["Normal", "Sport"].map((cat) {
              final bool isSelected = categorie == cat;
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
            decoration: _inputDecoration().copyWith(hintText: "Ex: 12"),
          ),
          const SizedBox(height: 16),

          _buildLabel("Bouteilles par palette"),
          TextField(
            controller: paletteController,
            keyboardType: TextInputType.number,
            decoration: _inputDecoration().copyWith(hintText: "Ex: 72"),
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
        _buildInfoRow("Taille", "${tailleController.text} cl"),
        _buildInfoRow("Prix", "${prixController.text} DA"),
        _buildInfoRow("Catégorie", categorie),
        _buildInfoRow("Bouteilles / Fardos", fardosController.text),
        _buildInfoRow("Bouteilles / Palette", paletteController.text),
        const SizedBox(height: 30),
        Center(
          child: Text(
            "Confirmez ces informations avant l’enregistrement.",
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
          enregistrement ? "Produit ajouté" : "Erreur d’ajout",
          style: Appstyle.textS_B.copyWith(color: Appstyle.noir),
        ),
        const SizedBox(height: 40),
        Image.asset(
          enregistrement ? "assets/icons/nike_icon.png" : "assets/icons/croix_icon.png",
          width: 120,
          height: 120,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 40),
        Text(
          enregistrement
              ? "Le produit a été enregistré avec succès."
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
