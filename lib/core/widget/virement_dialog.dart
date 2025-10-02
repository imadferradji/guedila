import 'package:flutter/material.dart';
import 'package:qanaty/core/theme/app_style.dart';
import 'package:qanaty/core/widget/main_button.dart';
import 'package:qanaty/core/widget/virement_widget.dart';
import '../../data/models/produi.dart';
import '../../data/models/virement.dart';


final TextEditingController numeroController = TextEditingController();
final TextEditingController montantController = TextEditingController();
final TextEditingController dateController = TextEditingController();

// pour stocker l’image
String? imagePath;

/// Exemple de produits
double prix_palette=10000.00;
double solde=100000.0;
bool virement_confirme =true;

/// Fonction pour afficher le Dialog
void showNouvelleVirementDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return VirementDialog();
    },
  );
}



/// Dialog multi-étapes
class VirementDialog extends StatefulWidget {
  @override
  _VirementDialog createState() => _VirementDialog();
}

class _VirementDialog extends State<VirementDialog> {
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
                if (currentStep > 0 && currentStep<2)
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
                        onPressed: () {
                          Navigator.pop(context); // ferme la fenêtre ou revient à l'accueil
                        },
                      ),
                    ),
                  )

               else ...[ Spacer(),
                MainButton(
                  text: currentStep==1?"Confirmer":"Suivant",
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
        return _buildStep2ProduitQuantite();
      case 2:
        return _buildStep3Confirmation();
      default:
        return SizedBox.shrink();
    }
  }

  /// Étape 1 : Produit & Quantité
  Widget _buildStep1ProduitQuantite() {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // TItre
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
      // --- Numero virement ---
        const SizedBox(height: 20),

        TextField(
          controller: numeroController,
          decoration: InputDecoration(
            labelText: "Numéro de virement",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        const SizedBox(height: 16),

        // Champ Montant (numérique seulement)
        TextField(
          controller: montantController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: "Montant (DA)",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        const SizedBox(height: 16),

        // Champ Date
        TextField(
          controller: dateController,
          readOnly: true,
          decoration: InputDecoration(
            labelText: "Date de virement",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            suffixIcon: Icon(Icons.calendar_today),
          ),
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
            // TODO: Ajouter image picker (ex: image_picker package)
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

  /// Étape 2 : Confrimation
  Widget _buildStep2ProduitQuantite() {
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


  /// Étape 3 : Message
  Widget _buildStep3Confirmation() {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              virement_confirme?"Virement confirmé":"Virement echoué",
              style: Appstyle.textS_B.copyWith(color: Appstyle.noir),
            ),
            const SizedBox(height: 120),
            Text(
              virement_confirme?"Votre virement est bien crée !!":"Solde client insufisant !!",
              style: Appstyle.textS_B.copyWith(color: Appstyle.noir),
            ),
            const SizedBox(height:40),
            Image.asset(
              virement_confirme?"assets/icons/nike_icon.png":"assets/icons/croix_icon.png",
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
