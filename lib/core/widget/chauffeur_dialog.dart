import 'package:flutter/material.dart';
import '../theme/app_style.dart';

/// Fonction pour afficher le Dialog d'ajout de chauffeur
void showNewDriverDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    barrierColor: Appstyle.blueF.withOpacity(0.3),
    builder: (context) => DriverDialog(),
  );
}

/// Dialog multi-étapes pour l'ajout d'un chauffeur
class DriverDialog extends StatefulWidget {
  @override
  _DriverDialogState createState() => _DriverDialogState();
}

class _DriverDialogState extends State<DriverDialog> {
  int currentStep = 0;

  // Controllers
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController licenseNumberController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  // FocusNodes
  final FocusNode fullNameFocus = FocusNode();
  final FocusNode licenseNumberFocus = FocusNode();
  final FocusNode birthDateFocus = FocusNode();
  final FocusNode phoneNumberFocus = FocusNode();

  // pour stocker l'image
  String? driverImagePath = "assets/images/profile.png";

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
    fullNameController.dispose();
    licenseNumberController.dispose();
    birthDateController.dispose();
    phoneNumberController.dispose();

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
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
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
                      child: ElevatedButton.icon(
                        onPressed: () {
                          _saveDriverInfo();
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.check),
                        label: const Text("Terminer"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                        ),
                      ),
                    ),
                  )
                else ...[
                  const Spacer(),
                  ElevatedButton.icon(
                    onPressed: () {
                      if (currentStep == 0 && _validateStep1()) {
                        setState(() => currentStep++);
                      } else if (currentStep == 1) {
                        setState(() => currentStep++);
                      }
                    },
                    icon: Icon(currentStep == 1 ? Icons.check : Icons.arrow_forward),
                    label: Text(currentStep == 1 ? "Confirmer" : "Suivant"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
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

  /// Étape affichée selon currentStep
  Widget _buildStepContent() {
    switch (currentStep) {
      case 0:
        return _buildStep1DriverInfo();
      case 1:
        return _buildStep2Confirmation();
      case 2:
        return _buildStep3Success();
      default:
        return const SizedBox.shrink();
    }
  }

  /// Validation des champs
  bool _validateStep1() {
    return fullNameController.text.isNotEmpty &&
        licenseNumberController.text.isNotEmpty &&
        birthDateController.text.isNotEmpty &&
        phoneNumberController.text.isNotEmpty;
  }

  /// Sauvegarde infos chauffeur
  void _saveDriverInfo() {
    debugPrint("Driver Saved: ${fullNameController.text}");
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Chauffeur ajouté avec succès!')),
    );
  }

  /// Step 1 : Formulaire infos chauffeur
  Widget _buildStep1DriverInfo() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Nouveau Chauffeur",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Row(
            children: const [
              Icon(Icons.person, size: 20, color: Colors.grey),
              SizedBox(width: 10),
              Text("Informations personnelles",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey)),
            ],
          ),
          const SizedBox(height: 40),

          _buildTextField(
            label: "Nom complet",
            controller: fullNameController,
            focusNode: fullNameFocus,
            hintText: "Ex: Mohamed Benali",
          ),
          const SizedBox(height: 16),

          _buildTextField(
            label: "Numéro de permis",
            controller: licenseNumberController,
            focusNode: licenseNumberFocus,
            hintText: "Ex: AB123456",
          ),
          const SizedBox(height: 16),

          _buildTextField(
            label: "Date de naissance",
            controller: birthDateController,
            focusNode: birthDateFocus,
            readOnly: true,
            onTap: () async {
              DateTime? picked = await showDatePicker(
                context: context,
                initialDate: DateTime.now().subtract(const Duration(days: 365 * 25)),
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

          _buildTextField(
            label: "Téléphone",
            controller: phoneNumberController,
            focusNode: phoneNumberFocus,
            keyboardType: TextInputType.phone,
            hintText: "Ex: 05 12 34 56 78",
          ),
        ],
      ),
    );
  }

  /// Step 2 : Confirmation
  Widget _buildStep2Confirmation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("Confirmation des informations",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        CircleAvatar(
          radius: 50,
          backgroundImage: AssetImage(driverImagePath ?? "assets/images/profile.png"),
        ),
        const SizedBox(height: 20),
        _buildInfoRow("Nom complet:", fullNameController.text),
        _buildInfoRow("Numéro de permis:", licenseNumberController.text),
        _buildInfoRow("Date de naissance:", birthDateController.text),
        _buildInfoRow("Téléphone:", phoneNumberController.text),
      ],
    );
  }

  /// Step 3 : Succès
  Widget _buildStep3Success() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.check_circle, size: 80, color: Appstyle.blueC),
        const SizedBox(height: 20),
        Text("Chauffeur ajouté avec succès!",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Text("${fullNameController.text} a été ajouté à la liste."),
      ],
    );
  }

  /// Champ stylisé
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
        decoration: InputDecoration(
          labelText: label,
          hintText: hintText,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        ),
      ),
    );
  }

  /// Ligne info confirm
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(flex: 2, child: Text(label, style: const TextStyle(color: Colors.grey))),
          Expanded(flex: 3, child: Text(value)),
        ],
      ),
    );
  }
}
