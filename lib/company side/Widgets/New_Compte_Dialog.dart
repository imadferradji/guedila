import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/theme/app_style.dart';

class NewAccountDialog extends StatefulWidget {
  @override
  _NewAccountDialogState createState() => _NewAccountDialogState();
}

class _NewAccountDialogState extends State<NewAccountDialog> {
  String _selectedAccountType = 'checking';
  String _selectedCurrency = 'EUR';
  final TextEditingController _accountNameController = TextEditingController();
  final TextEditingController _initialDepositController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final List<Map<String, String>> _accountTypes = [
    {'value': 'Grossiste', 'label': 'Grossiste'},
    {'value': 'Sous Groussiste', 'label': 'Sous Groussiste'},
    {'value': 'Chauffeur', 'label': 'Chauffeur'},
    {'value': 'Chauffeur', 'label': 'Client'},
  ];

  final List<Map<String, String>> _currencies = [
    {'value': 'EUR', 'label': 'EUR (€)'},
    {'value': 'USD', 'label': 'USD (\$)'},
    {'value': 'GBP', 'label': 'GBP (£)'},
    {'value': 'CHF', 'label': 'CHF (CHF)'},
  ];

  void _submitForm() {
    if (_accountNameController.text.isEmpty || _initialDepositController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Veuillez remplir tous les champs obligatoires.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Here you would typically send the data to your backend
    print('Nouveau compte créé:');
    print('Nom: ${_accountNameController.text}');
    print('Type: $_selectedAccountType');
    print('Dépôt initial: ${_initialDepositController.text}');
    print('Devise: $_selectedCurrency');
    print('Description: ${_descriptionController.text}');

    Navigator.of(context).pop();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Compte créé avec succès!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Appstyle.blueSC, // Make dialog background transparent
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        constraints: BoxConstraints(maxWidth: 500),
        decoration: BoxDecoration(
          color: Appstyle.blueSC, // Apply blue background to entire dialog
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Appstyle.blueC,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Text(
                'Création de Nouveau Compte',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            // Content - White background for content area
            Container(
              margin: EdgeInsets.all(10), // Add some margin to create the border effect
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: EdgeInsets.all(25),
                child: Column(
                  children: [
                    // Account Name
                    _buildFormField(
                      label: 'Nom du compte',
                      isRequired: true,
                      controller: _accountNameController,
                      hintText: 'Ex: Imad Ferradji',
                    ),

                    SizedBox(height: 20),

                    // Account Type
                    _buildAccountTypeSelector(),

                    SizedBox(height: 20),

                    // Initial Deposit and Currency
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: _buildFormField(
                            label: 'Numero de register commerce',
                            isRequired: true,
                            controller: _initialDepositController,
                            hintText: '63481534',
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 20),

                    // Description
                    _buildDescriptionField(),
                  ],
                ),
              ),
            ),

            // Footer - White background for footer
            Container(
              margin: EdgeInsets.all(10), // Add some margin to create the border effect
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: Color(0xFFeeeeee))),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                      ),
                      child: Text(
                        'Annuler',
                        style: TextStyle(
                          color: Color(0xFF7f8c8d),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(width: 15),
                    ElevatedButton(
                      onPressed: _submitForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF2ecc71),
                        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                      ),
                      child: Text(
                        'Créer le compte',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormField({
    required String label,
    required bool isRequired,
    required TextEditingController controller,
    String? hintText,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label,
            style: TextStyle(
              color: Color(0xFF34495e),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            children: isRequired
                ? [
              TextSpan(
                text: ' *',
                style: TextStyle(color: Colors.red),
              ),
            ]
                : [],
          ),
        ),
        SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(color: Color(0xFFdddddd)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(color: Color(0xFF3498db)),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildAccountTypeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: 'Type de compte',
            style: TextStyle(
              color: Color(0xFF34495e),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            children: [
              TextSpan(
                text: ' *',
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: _accountTypes.map((type) {
            final isSelected = _selectedAccountType == type['value'];
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedAccountType = type['value']!;
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected ? Color(0xFF3498db) : Colors.transparent,
                  border: Border.all(
                    color: isSelected ? Color(0xFF3498db) : Color(0xFFdddddd),
                  ),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  type['label']!,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildDescriptionField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description (optionnelle)',
          style: TextStyle(
            color: Color(0xFF34495e),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8),
        TextField(
          controller: _descriptionController,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: 'Description du compte...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(color: Color(0xFFdddddd)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(color: Color(0xFF3498db)),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _accountNameController.dispose();
    _initialDepositController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}