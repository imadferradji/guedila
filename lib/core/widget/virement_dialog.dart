import 'package:flutter/material.dart';
import 'package:qanaty/core/theme/app_style.dart';
import 'package:qanaty/core/widget/main_button.dart';
import 'package:qanaty/core/widget/virement_widget.dart';
import '../../data/models/produit.dart';
import '../../data/models/virement.dart';

final TextEditingController numeroController = TextEditingController();
final TextEditingController montantController = TextEditingController();
final TextEditingController dateController = TextEditingController();

// pour stocker l’image
String? imagePath;

/// Exemple de produits
double prix_palette = 10000.00;
double solde = 100000.0;
bool virement_confirme = true;

/// Fonction pour afficher le Dialog
void showNouvelleVirementDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => VirementDialog(),
  );
}

/// Dialog multi-étapes
class VirementDialog extends StatefulWidget {
  @override
  _VirementDialogState createState() => _VirementDialogState();
}

class _VirementDialogState extends State<VirementDialog> {
  int currentStep = 0;

  // FocusNodes pour gérer le focus des champs
  final FocusNode numeroFocus = FocusNode();
  final FocusNode montantFocus = FocusNode();
  final FocusNode dateFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    numeroFocus.addListener(() => setState(() {}));
    montantFocus.addListener(() => setState(() {}));
    dateFocus.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    numeroFocus.dispose();
    montantFocus.dispose();
    dateFocus.dispose();
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
                if (currentStep > 0 && currentStep < 2)
                  TextButton(
                    onPressed: () => setState(() => currentStep--),
                    child: const Text("← Retour"),
                  ),
                if (currentStep == 2)
                  Expanded(
                    child: Center(
                      child: MainButton(
                        text: "Terminer",
                        icon: Icons.check,
                        iconOnRight: true,
                        color: Appstyle.rose,
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  )
                else ...[
                  Spacer(),
                  MainButton(
                    text: currentStep == 1 ? "Confirmer" : "Suivant",
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
        return _buildStep2Confirmation();
      case 2:
        return _buildStep3Message();
      default:
        return SizedBox.shrink();
    }
  }

  /// Widget générique pour un TextField stylisé
  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required FocusNode focusNode,
    bool readOnly = false,
    TextInputType keyboardType = TextInputType.text,
    VoidCallback? onTap,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: focusNode.hasFocus ? Appstyle.blueC.withOpacity(0.2) : Appstyle.grisC.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: focusNode.hasFocus ? Colors.blue : Colors.transparent,
          width: 1.5,
        ),
      ),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        readOnly: readOnly,
        keyboardType: keyboardType,
        onTap: onTap,
        style: TextStyle(
          color: Colors.grey[800],
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.grey[600], fontSize: 14),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        ),
      ),
    );
  }

  /// Étape 1 : Produit & Quantité
  Widget _buildStep1ProduitQuantite() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Nouvelle virement",
          style: Appstyle.textS_B.copyWith(color: Appstyle.noir),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Image.asset(
              "assets/icons/virement_icon.png",
              width: 20,
              height: 20,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 10),
            Text(
              "Réference et Montant",
              style: Appstyle.textS_B.copyWith(color: Appstyle.gris),
            ),
          ],
        ),
        const SizedBox(height: 20),
        _buildTextField(
          label: "Numéro de virement",
          controller: numeroController,
          focusNode: numeroFocus,
        ),
        const SizedBox(height: 16),
        _buildTextField(
          label: "Montant (DA)",
          controller: montantController,
          focusNode: montantFocus,
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 16),
        _buildTextField(
          label: "Date de virement",
          controller: dateController,
          focusNode: dateFocus,
          readOnly: true,
          onTap: () async {
            DateTime? picked = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2020),
              lastDate: DateTime(2100),
            );
            if (picked != null) {
              setState(() {
                dateController.text = "${picked.day}/${picked.month}/${picked.year}";
              });
            }
          },
        ),
        const SizedBox(height: 16),
        // Bouton pour choisir une image
        GestureDetector(
          onTap: () {
            setState(() {
              imagePath = "assets/images/recu.png"; // exemple
            });
          },
          child: Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Appstyle.grisC),
              borderRadius: BorderRadius.circular(8),
              color: Appstyle.gris.withOpacity(0.05),
            ),
            alignment: Alignment.center,
            child: imagePath == null
                ? Text("Joindre une photo du reçu")
                : Image.asset(imagePath!, fit: BoxFit.contain),
          ),
        ),
      ],
    );
  }

  /// Étape 2 : Confirmation du virement
  Widget _buildStep2Confirmation() {
    Virement virement = Virement(
      numero: numeroController.text,
      montant: double.tryParse(montantController.text) ?? 0.0,
      date: dateController.text,
      etat: "En attente",
      imagePath: imagePath,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("Confirmation du virement", style: Appstyle.textS_B.copyWith(color: Appstyle.noir)),
        const SizedBox(height: 60),
        VirementWidget(
          numero: virement.numero,
          montant: "${virement.montant.toStringAsFixed(2)} DA",
          date: virement.date,
          etat: virement.etat,
        ),
        const SizedBox(height: 60),
        if (virement.imagePath != null)
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(virement.imagePath!, height: 120),
          ),
      ],
    );
  }

  /// Étape 3 : Message final
  Widget _buildStep3Message() {
    return Column(
      children: [
        Text(
          virement_confirme ? "Virement confirmé" : "Virement échoué",
          style: Appstyle.textS_B.copyWith(color: Appstyle.noir),
        ),
        const SizedBox(height: 120),
        Text(
          virement_confirme ? "Votre virement est bien créé !" : "Solde client insuffisant !",
          style: Appstyle.textS_B.copyWith(color: Appstyle.noir),
        ),
        const SizedBox(height: 40),
        Image.asset(
          virement_confirme ? "assets/icons/nike_icon.png" : "assets/icons/croix_icon.png",
          width: 150,
          height: 150,
          fit: BoxFit.contain,
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
