import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qanaty/core/theme/app_style.dart';

// Controllers pour les informations du camion
final TextEditingController matriculeController = TextEditingController();
final TextEditingController tonnageController = TextEditingController();
final TextEditingController marqueController = TextEditingController();
final TextEditingController modeleController = TextEditingController();
final TextEditingController anneeController = TextEditingController();
final TextEditingController couleurController = TextEditingController();
final TextEditingController dateMiseCirculationController = TextEditingController();

// pour stocker l'image du camion
String? camionImagePath;

/// Fonction pour afficher le Dialog d'ajout de camion
void showNewCamionDialog(BuildContext context, VoidCallback onCamionAdded) {
  showDialog(
    context: context,
    builder: (context) => CamionDialog(onCamionAdded: onCamionAdded),
  );
}

/// Dialog multi-étapes pour l'ajout d'un camion
class CamionDialog extends StatefulWidget {
  final VoidCallback onCamionAdded;

  CamionDialog({required this.onCamionAdded});

  @override
  _CamionDialogState createState() => _CamionDialogState();
}

class _CamionDialogState extends State<CamionDialog> {
  int currentStep = 0;
  String? selectedTypeCamion;
  String? selectedStatut;

  // Liste des types de camion
  final List<String> typesCamion = [
    'Camion plateau',
    'Semi-remorque',
    'Camion'
  ];

  // Liste des statuts
  final List<String> statuts = [
    'En service',
    'En maintenance',
    'Hors service',
    'En réparation'
  ];

  // FocusNodes pour gérer le focus des champs
  final FocusNode matriculeFocus = FocusNode();
  final FocusNode tonnageFocus = FocusNode();
  final FocusNode remorqueFocus = FocusNode();
  final FocusNode modeleFocus = FocusNode();
  final FocusNode anneeFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    matriculeFocus.addListener(() => setState(() {}));
    tonnageFocus.addListener(() => setState(() {}));
    remorqueFocus.addListener(() => setState(() {}));
    modeleFocus.addListener(() => setState(() {}));
    anneeFocus.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    matriculeFocus.dispose();
    tonnageFocus.dispose();
    remorqueFocus.dispose();
    modeleFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: 550,
        height: 700,
        decoration: BoxDecoration(
          color: Colors.white,
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
                      child: ElevatedButton(
                        onPressed: () {
                          _saveCamionInfo();
                          widget.onCamionAdded();
                          Navigator.pop(context);
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("Terminer"),
                            SizedBox(width: 8),
                            Icon(Icons.check),
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Appstyle.rose,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                        ),
                      ),
                    ),
                  )
                else ...[
                  Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      if (currentStep == 0 && _validateStep1()) {
                        setState(() => currentStep++);
                      } else if (currentStep == 1) {
                        setState(() => currentStep++);
                      }
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(currentStep == 1 ? "Confirmer" : "Suivant"),
                        SizedBox(width: 8),
                        Icon(Icons.arrow_forward),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Appstyle.rose,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Validation for step 1
  bool _validateStep1() {
    return matriculeController.text.isNotEmpty &&
        tonnageController.text.isNotEmpty &&
        selectedTypeCamion != null &&
        marqueController.text.isNotEmpty;
  }

  /// Save camion information
  void _saveCamionInfo() {
    // Here you would typically save to database or state management
    print('Camion Information Saved:');
    print('Matricule: ${matriculeController.text}');
    print('Tonnage: ${tonnageController.text} tonnes');
    print('Type: $selectedTypeCamion');
    print('Matricule de remorque: ${marqueController.text}');
    print('Modèle: ${modeleController.text}');
    print('Année: ${anneeController.text}');
    print('Couleur: ${couleurController.text}');
    print('Date mise en circulation: ${dateMiseCirculationController.text}');
    print('Statut: $selectedStatut');
    print('Image Path: $camionImagePath');

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Camion ajouté avec succès!')),
    );
  }

  /// Contenu selon l'étape
  Widget _buildStepContent() {
    switch (currentStep) {
      case 0:
        return _buildStep1CamionInfo();
      case 1:
        return _buildStep3Confirmation();
      default:
        return _buildStep3Success();
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
    String? hintText,
    String? suffixText,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: focusNode.hasFocus ? Appstyle.blueC.withOpacity(0.1) : Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: focusNode.hasFocus ? Appstyle.blueC : Colors.transparent,
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
          hintText: hintText,
          suffixText: suffixText,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        ),
      ),
    );
  }
  //Widget pour le tonnage
  Widget _buildNumberField({
    required String label,
    required TextEditingController controller,
    required FocusNode focusNode,
    bool readOnly = false,
    TextInputType keyboardType = TextInputType.text,
    VoidCallback? onTap,
    String? hintText,
    String? suffixText,
    bool isNumber = false,
    bool allowDecimal = false, // For decimal numbers
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: focusNode.hasFocus ? Appstyle.blueC : Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: focusNode.hasFocus ? Appstyle.blueC : Colors.transparent,
          width: 1.5,
        ),
      ),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        readOnly: readOnly,
        keyboardType: isNumber
            ? (allowDecimal ? TextInputType.numberWithOptions(decimal: true) : TextInputType.number)
            : keyboardType,
        onTap: onTap,
        style: TextStyle(
          color: Colors.grey[800],
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        inputFormatters: isNumber
            ? [
          if (allowDecimal)
            FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')) // Allow decimal with max 2 digits
          else
            FilteringTextInputFormatter.digitsOnly,
        ]
            : null,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.grey[600], fontSize: 14),
          hintText: hintText,
          suffixText: suffixText,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        ),
      ),
    );
  }

  /// Widget pour les dropdowns
  Widget _buildDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.withOpacity(0.3)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: DropdownButtonFormField<String>(
          value: value,
          onChanged: onChanged,
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(color: Colors.grey[600], fontSize: 14),
            border: InputBorder.none,
          ),
          icon: Icon(Icons.arrow_drop_down, color: Appstyle.blueC),
        ),
      ),
    );
  }

  /// Étape 1 : Informations principales du camion
  Widget _buildStep1CamionInfo() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Nouveau Camion",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.local_shipping, size: 20, color: Colors.grey),
              const SizedBox(width: 10),
              Text(
                "Informations principales",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Photo du camion
          Center(
            child: Container(
              width: 120,
              height: 80,
              decoration: BoxDecoration(
                color: Appstyle.blueC.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Appstyle.blueC),
              ),
              child: Icon(Icons.local_shipping, size: 50, color: Appstyle.blueC),
            ),
          ),
          const SizedBox(height: 20),

          // Matricule
          _buildTextField(
            label: "Numéro d'immatriculation",
            controller: matriculeController,
            focusNode: matriculeFocus,
            hintText: "Ex: 12345-A-56",
          ),
          const SizedBox(height: 16),

          // Tonnage
          _buildNumberField(
            label: "Tonnage / Capacité",
            controller: tonnageController,
            focusNode: tonnageFocus,
            isNumber: true,
            allowDecimal: true, // For decimal numbers like 25.5
            hintText: "Ex: 25.5",
            suffixText: "tonnes",
          ),
          const SizedBox(height: 16),

          // Type de camion
          _buildDropdown(
            label: "Type de camion",
            value: selectedTypeCamion,
            items: typesCamion,
            onChanged: (value) {
              setState(() {
                selectedTypeCamion = value;
              });
            },
          ),
          const SizedBox(height: 16),

          // Marque
          _buildTextField(
            label: "matriculation de remorque",
            controller: marqueController,
            focusNode: remorqueFocus,
            hintText: "Ex: 12345-A-56",
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }


  Widget _buildStep3Confirmation() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Confirmation",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          const SizedBox(height: 30),

          // Camion Icon
          Container(
            width: 120,
            height: 80,
            decoration: BoxDecoration(
              color: Appstyle.blueC.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Appstyle.blueC),
            ),
            child: Icon(Icons.local_shipping, size: 50, color: Appstyle.blueC),
          ),

          const SizedBox(height: 30),

          // Camion Information
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey),
            ),
            child: Column(
              children: [
                _buildInfoRow("Immatriculation:", matriculeController.text),
                _buildInfoRow("Tonnage:", "${tonnageController.text} tonnes"),
                _buildInfoRow("Type:", selectedTypeCamion ?? "Non spécifié"),
                _buildInfoRow("Matricule de remourqe:", "${marqueController.text} "),]
            ),
          ),

          const SizedBox(height: 30),

          Text(
            "Vérifiez les informations avant de confirmer l'ajout",
            style: TextStyle(fontSize: 14, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  /// Widget pour afficher une ligne d'information
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildStep3Success() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset("assets/icons/nike_icon.png"),
        SizedBox(height: 20),
        Text(
          "Camion ajouté avec succès!",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
  /// Function to select camion image
  void _selectCamionImage() {
    // For demo purposes, we'll just toggle between no image and a placeholder
    setState(() {
      if (camionImagePath == null) {
        // In a real app, you would use image_picker here
        camionImagePath = "placeholder";
      } else {
        camionImagePath = null;
      }
    });
  }
}