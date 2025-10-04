import 'package:flutter/material.dart';

import '../theme/app_style.dart';

final TextEditingController fullNameController = TextEditingController();
final TextEditingController licenseNumberController = TextEditingController();
final TextEditingController birthDateController = TextEditingController();
final TextEditingController phoneNumberController = TextEditingController();

// pour stocker l'image
String? driverImagePath ="assets/images/profile.jpg";

/// Fonction pour afficher le Dialog d'ajout de chauffeur
void showNewDriverDialog(BuildContext context, VoidCallback onDriverAdded) {
  showDialog(
    context: context,
    builder: (context) => DriverDialog(onDriverAdded: onDriverAdded),
  );
}

/// Dialog multi-étapes pour l'ajout d'un chauffeur
class DriverDialog extends StatefulWidget {
  final VoidCallback onDriverAdded;

  DriverDialog({required this.onDriverAdded});

  @override
  _DriverDialogState createState() => _DriverDialogState();
}

class _DriverDialogState extends State<DriverDialog> {
  int currentStep = 0;

  // FocusNodes pour gérer le focus des champs
  final FocusNode fullNameFocus = FocusNode();
  final FocusNode licenseNumberFocus = FocusNode();
  final FocusNode birthDateFocus = FocusNode();
  final FocusNode phoneNumberFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    fullNameFocus.addListener(() => setState(() {}));
    licenseNumberFocus.addListener(() => setState(() {}));
    birthDateFocus.addListener(() => setState(() {}));
    phoneNumberFocus.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    fullNameFocus.dispose();
    licenseNumberFocus.dispose();
    birthDateFocus.dispose();
    phoneNumberFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: 500,
        height: 650,
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
                          _saveDriverInfo();
                          widget.onDriverAdded();
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
                          backgroundColor: Colors.blue,
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
                      backgroundColor: Colors.blue,
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
    return fullNameController.text.isNotEmpty &&
        licenseNumberController.text.isNotEmpty &&
        birthDateController.text.isNotEmpty &&
        phoneNumberController.text.isNotEmpty;
  }

  /// Save driver information
  void _saveDriverInfo() {
    // Here you would typically save to database or state management
    print('Driver Information Saved:');
    print('Full Name: ${fullNameController.text}');
    print('License Number: ${licenseNumberController.text}');
    print('Birth Date: ${birthDateController.text}');
    print('Phone Number: ${phoneNumberController.text}');
    print('Image Path: $driverImagePath');

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Chauffeur ajouté avec succès!')),
    );
  }

  /// Contenu selon l'étape
  Widget _buildStepContent() {
    switch (currentStep) {
      case 0:
        return _buildStep1DriverInfo();
      case 1:
        return _buildStep2Confirmation();
      case 2:
        return _buildStep3Success();
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
    String? hintText,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: focusNode.hasFocus ? Colors.blue.withOpacity(0.1) : Colors.grey.withOpacity(0.1),
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
          hintText: hintText,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        ),
      ),
    );
  }

  /// Étape 1 : Informations du chauffeur
  Widget _buildStep1DriverInfo() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Nouveau Chauffeur",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Icon(Icons.person, size: 20, color: Colors.grey),
              const SizedBox(width: 10),
              Text(
                "Informations personnelles",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey),
              ),
            ],
          ),

          const SizedBox(height: 80),

          // Full Name
          _buildTextField(
            label: "Nom complet",
            controller: fullNameController,
            focusNode: fullNameFocus,
            hintText: "Ex: Mohamed Benali",
          ),
          const SizedBox(height: 16),

          // License Number
          _buildTextField(
            label: "Numéro de permis",
            controller: licenseNumberController,
            focusNode: licenseNumberFocus,
            hintText: "Ex: AB123456",
          ),
          const SizedBox(height: 16),

          // Birth Date
          _buildTextField(
            label: "Date de naissance",
            controller: birthDateController,
            focusNode: birthDateFocus,
            readOnly: true,
            onTap: () async {
              DateTime? picked = await showDatePicker(
                context: context,
                initialDate: DateTime.now().subtract(Duration(days: 365 * 25)), // 25 years ago
                firstDate: DateTime(1950),
                lastDate: DateTime.now(),
              );
              if (picked != null) {
                setState(() {
                  birthDateController.text = "${picked.day}/${picked.month}/${picked.year}";
                });
              }
            },
            hintText: "JJ/MM/AAAA",
          ),
          const SizedBox(height: 16),

          // Phone Number
          _buildTextField(
            label: "Numéro de téléphone",
            controller: phoneNumberController,
            focusNode: phoneNumberFocus,
            keyboardType: TextInputType.phone,
            hintText: "Ex: 05 12 34 56 78",
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  /// Étape 2 : Confirmation des informations
  Widget _buildStep2Confirmation() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Confirmation des informations",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          const SizedBox(height: 30),

          // Driver Photo
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.withOpacity(0.1),
              border: Border.all(color: Colors.grey),
            ),
            child: driverImagePath == null
                ? Icon(Icons.person, size: 40, color: Colors.grey)
                : Container(
              color: Colors.blue.withOpacity(0.1),
              child: Icon(Icons.person, size: 40, color: Colors.blue),
            ),
          ),

          const SizedBox(height: 30),

          // Driver Information
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey),
            ),
            child: Column(
              children: [
                _buildInfoRow("Nom complet:", fullNameController.text),
                _buildInfoRow("Numéro de permis:", licenseNumberController.text),
                _buildInfoRow("Date de naissance:", birthDateController.text),
                _buildInfoRow("Téléphone:", phoneNumberController.text),
              ],
            ),
          ),

          const SizedBox(height: 30),

          Text(
            "Vérifiez les informations avant de confirmer",
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
      padding: const EdgeInsets.symmetric(vertical: 8),
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
              style: TextStyle(fontSize: 14, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  /// Étape 3 : Message de succès
  Widget _buildStep3Success() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.check_circle,
          size: 80,
          color: Appstyle.blueC,
        ),
        SizedBox(height: 20),
        Text(
          "Chauffeur ajouté avec succès!",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20),
        Text(
          "${fullNameController.text} a été ajouté à votre liste de chauffeurs.",
          style: TextStyle(fontSize: 16, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10),
        Text(
          "Numéro de permis: ${licenseNumberController.text}",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  /// Function to select driver image

}