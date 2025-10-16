import 'package:flutter/material.dart';
import 'package:qanaty/core/theme/app_style.dart';
import 'package:qanaty/core/widget/main_button.dart';
import 'package:qanaty/core/widget/virement_widget.dart';
import 'dart:convert';
import '../../screens/api_service.dart';

// Controllers for text fields
final TextEditingController numeroController = TextEditingController();
final TextEditingController montantController = TextEditingController();
final TextEditingController dateController = TextEditingController();

// pour stocker l'image
String? imagePath;

/// Fonction pour afficher le Dialog
void showNouvelleVirementDialog(BuildContext context, {VoidCallback? onVirementCreated, String? userEmail}) {
  showDialog(
    context: context,
    builder: (context) => VirementDialog(
      onVirementCreated: onVirementCreated,
      userEmail: userEmail,
    ),
  );
}

/// Dialog multi-étapes
class VirementDialog extends StatefulWidget {
  final VoidCallback? onVirementCreated;
  final String? userEmail;

  const VirementDialog({super.key, this.onVirementCreated, this.userEmail});

  @override
  _VirementDialogState createState() => _VirementDialogState();
}

class _VirementDialogState extends State<VirementDialog> {
  int currentStep = 0;
  bool virement_confirme = false;
  bool _isLoading = false;

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

    // Set default date to today
    final now = DateTime.now();
    dateController.text = "${now.day}/${now.month}/${now.year}";
  }

  @override
  void dispose() {
    numeroController.clear();
    montantController.clear();
    dateController.clear();
    imagePath = null;

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
            _buildBottomButtons(),
          ],
        ),
      ),
    );
  }

  /// Bottom navigation buttons
  Widget _buildBottomButtons() {
    return Row(
      children: [
        if (currentStep > 0 && currentStep < 2)
          TextButton(
            onPressed: _isLoading ? null : () => setState(() => currentStep--),
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
                  Navigator.pop(context);
                  widget.onVirementCreated?.call();
                },
              ),
            ),
          )
        else ...[
          Spacer(),
          _isLoading
              ? Container(
            padding: EdgeInsets.all(8),
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Appstyle.rose),
            ),
          )
              : MainButton(
            text: currentStep == 1 ? "Confirmer" : "Suivant",
            icon: Icons.arrow_forward,
            iconOnRight: true,
            color: Appstyle.rose,
            onPressed: _handleNextStep,
          ),
        ],
      ],
    );
  }

  /// Handle next step button press
  void _handleNextStep() {
    if (currentStep == 0) {
      // Validate step 1
      if (_validateStep1()) {
        setState(() => currentStep++);
      }
    } else if (currentStep == 1) {
      // Create virement
      _createVirement();
    }
  }

  /// Validate step 1 fields
  bool _validateStep1() {
    if (numeroController.text.isEmpty) {
      _showError("Veuillez entrer un numéro de virement");
      return false;
    }
    if (montantController.text.isEmpty) {
      _showError("Veuillez entrer un montant");
      return false;
    }
    if (dateController.text.isEmpty) {
      _showError("Veuillez sélectionner une date");
      return false;
    }

    final montant = double.tryParse(montantController.text);
    if (montant == null || montant <= 0) {
      _showError("Veuillez entrer un montant valide");
      return false;
    }

    return true;
  }

  /// Show error message
  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  /// Create virement via API
  Future<void> _createVirement() async {
    setState(() {
      _isLoading = true;
    });

    try {
      print('🔄 Creating virement...');

      final response = await ApiService.createVirement(
        userEmail: widget.userEmail ?? '',
        numero: numeroController.text,
        montant: montantController.text,
        dateVirement: _formatDateForAPI(dateController.text),
        imagePath: imagePath,
      );

      final responseData = json.decode(response.body);

      print('📊 Virement creation response: ${response.statusCode}');
      print('📦 Response data: $responseData');

      if (response.statusCode == 201 && responseData['success'] == true) {
        setState(() {
          virement_confirme = true;
          currentStep++;
          _isLoading = false;
        });

        print('✅ Virement created successfully');
      } else {
        setState(() {
          virement_confirme = false;
          currentStep++;
          _isLoading = false;
        });

        final errorMessage = responseData['message'] ?? 'Erreur lors de la création du virement';
        print('❌ Virement creation failed: $errorMessage');
      }
    } catch (e) {
      print('❌ Error creating virement: $e');
      setState(() {
        virement_confirme = false;
        currentStep++;
        _isLoading = false;
      });

      _showError('Erreur de connexion: $e');
    }
  }

  /// Helper method to format date for API
  String _formatDateForAPI(String date) {
    try {
      final parts = date.split('/');
      if (parts.length == 3) {
        final day = parts[0].padLeft(2, '0');
        final month = parts[1].padLeft(2, '0');
        final year = parts[2];
        return '$year-$month-$day'; // Convert to YYYY-MM-DD
      }
      return DateTime.now().toString().split(' ')[0]; // Fallback to today
    } catch (e) {
      return DateTime.now().toString().split(' ')[0];
    }
  }

  /// Contenu selon l'étape
  Widget _buildStepContent() {
    switch (currentStep) {
      case 0:
        return _buildStep1ProduitQuantite();
      case 1:
        return _buildStep2Confirmation();
      case 2:
        return _buildStep3Message();
      default:
        return const SizedBox.shrink();
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
          "Nouveau virement",
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
              "Référence et Montant",
              style: Appstyle.textS_B.copyWith(color: Appstyle.gris),
            ),
          ],
        ),
        const SizedBox(height: 20),
        _buildTextField(
          label: "Numéro de virement*",
          controller: numeroController,
          focusNode: numeroFocus,
        ),
        const SizedBox(height: 16),
        _buildTextField(
          label: "Montant (DA)*",
          controller: montantController,
          focusNode: montantFocus,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
        ),
        const SizedBox(height: 16),
        _buildTextField(
          label: "Date de virement*",
          controller: dateController,
          focusNode: dateFocus,
          readOnly: true,
          onTap: () async {
            final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2020),
              lastDate: DateTime(2100),
              locale: const Locale('fr', 'FR'),
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
            // For now, we'll use a static image path
            // In a real app, you would use image_picker to select from gallery/camera
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
                ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.attach_file, size: 40, color: Appstyle.grisC),
                const SizedBox(height: 8),
                Text(
                  "Joindre une photo du reçu\n(Optionnel)",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Appstyle.grisC),
                ),
              ],
            )
                : Stack(
              children: [
                Image.asset(imagePath!, fit: BoxFit.contain),
                Positioned(
                  top: 4,
                  right: 4,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        imagePath = null;
                      });
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.close, color: Colors.white, size: 20),
                      padding: const EdgeInsets.all(4),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          "* Champs obligatoires",
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }

  /// Étape 2 : Confirmation du virement
  Widget _buildStep2Confirmation() {
    final virementMontant = double.tryParse(montantController.text) ?? 0.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Confirmation du virement",
          style: Appstyle.textS_B.copyWith(color: Appstyle.noir),
        ),
        const SizedBox(height: 20),
        Text(
          "Veuillez vérifier les informations de votre virement:",
          style: TextStyle(
            color: Appstyle.gris,
            fontSize: 14,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 40),
        VirementWidget(
          numero: numeroController.text,
          montant: "${virementMontant.toStringAsFixed(2)} DA",
          date: dateController.text,
          etat: "En attente",
        ),
        const SizedBox(height: 40),
        if (imagePath != null) ...[
          Text(
            "Reçu joint:",
            style: TextStyle(
              color: Appstyle.gris,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(imagePath!, height: 120),
          ),
          const SizedBox(height: 20),
        ],
        if (_isLoading) ...[
          const SizedBox(height: 20),
          Column(
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Appstyle.rose),
              ),
              const SizedBox(height: 10),
              Text(
                "Création du virement en cours...",
                style: TextStyle(
                  color: Appstyle.gris,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  /// Étape 3 : Message final
  Widget _buildStep3Message() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          virement_confirme ? "Virement confirmé !" : "Virement échoué",
          style: Appstyle.textS_B.copyWith(
            color: virement_confirme ? Appstyle.vert : Colors.red,
          ),
        ),
        const SizedBox(height: 60),
        Text(
          virement_confirme
              ? "Votre virement a été créé avec succès!\nIl est maintenant en attente de validation."
              : "Une erreur est survenue lors de la création du virement.\nVeuillez réessayer.",
          style: Appstyle.textM_B.copyWith(color: Appstyle.noir),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 40),
        Image.asset(
          virement_confirme ? "assets/icons/nike_icon.png" : "assets/icons/croix_icon.png",
          width: 150,
          height: 150,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 40),
        if (virement_confirme)
          Text(
            "Numéro: ${numeroController.text}",
            style: TextStyle(
              color: Appstyle.gris,
              fontSize: 14,
            ),
          ),
      ],
    );
  }
}