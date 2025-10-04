import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/theme/app_style.dart';

class ModifyAccountDialog extends StatefulWidget {
  final List<Map<String, dynamic>> accounts;

  const ModifyAccountDialog({Key? key, required this.accounts}) : super(key: key);

  @override
  _ModifyAccountDialogState createState() => _ModifyAccountDialogState();
}

class _ModifyAccountDialogState extends State<ModifyAccountDialog> {
  String _selectedAccountType = 'Grossiste';
  String _selectedCurrency = 'EUR';
  final TextEditingController _accountNameController = TextEditingController();
  final TextEditingController _registerNumberController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  Map<String, dynamic>? _selectedAccount;

  final List<Map<String, String>> _accountTypes = [
    {'value': 'Grossiste', 'label': 'Grossiste'},
    {'value': 'Sous Grossiste', 'label': 'Sous Grossiste'},
    {'value': 'Chauffeur', 'label': 'Chauffeur'},
    {'value': 'Client', 'label': 'Client'},
  ];

  final List<Map<String, String>> _currencies = [
    {'value': 'EUR', 'label': 'EUR (€)'},
    {'value': 'USD', 'label': 'USD (\$)'},
    {'value': 'GBP', 'label': 'GBP (£)'},
    {'value': 'CHF', 'label': 'CHF (CHF)'},
  ];

  void _selectAccount(Map<String, dynamic> account) {
    setState(() {
      _selectedAccount = account;
      _accountNameController.text = account['name'] ?? '';
      _registerNumberController.text = account['registerNumber'] ?? '';
      _descriptionController.text = account['description'] ?? '';
      _selectedAccountType = account['type'] ?? 'Grossiste';
      _selectedCurrency = account['currency'] ?? 'EUR';
    });
  }

  void _submitForm() {
    if (_selectedAccount == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Veuillez sélectionner un compte à modifier.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_accountNameController.text.isEmpty || _registerNumberController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Veuillez remplir tous les champs obligatoires.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Here you would typically update the data in your backend
    print('Compte modifié:');
    print('ID: ${_selectedAccount!['id']}');
    print('Nom: ${_accountNameController.text}');
    print('Type: $_selectedAccountType');
    print('Numéro de register commerce: ${_registerNumberController.text}');
    print('Devise: $_selectedCurrency');
    print('Description: ${_descriptionController.text}');

    Navigator.of(context).pop();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Compte modifié avec succès!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _clearSelection() {
    setState(() {
      _selectedAccount = null;
      _accountNameController.clear();
      _registerNumberController.clear();
      _descriptionController.clear();
      _selectedAccountType = 'Grossiste';
      _selectedCurrency = 'EUR';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        color: Appstyle.blanc,
        constraints: BoxConstraints(maxWidth: 600, maxHeight: 700),
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
                'Modification de Compte',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            // Content
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Accounts List
                    Expanded(
                      flex: 1,
                      child: _buildAccountsList(),
                    ),

                    SizedBox(width: 15),

                    // Modification Form
                    Expanded(
                      flex: 2,
                      child: _selectedAccount != null
                          ? _buildModificationForm()
                          : _buildEmptyState(),
                    ),
                  ],
                ),
              ),
            ),

            // Footer
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Color(0xFFeeeeee))),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (_selectedAccount != null)
                    TextButton(
                      onPressed: _clearSelection,
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                      ),
                      child: Text(
                        'Changer de compte',
                        style: TextStyle(
                          color: Color(0xFF7f8c8d),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  else
                    Container(),

                  Row(
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
                          backgroundColor: Appstyle.rose,
                          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                        ),
                        child: Text(
                          'Modifier le compte',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Comptes disponibles',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF34495e),
          ),
        ),
        SizedBox(height: 10),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xFFdddddd)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: widget.accounts.isEmpty
                ? Center(
              child: Text(
                'Aucun compte disponible',
                style: TextStyle(color: Colors.grey),
              ),
            )
                : ListView.builder(
              itemCount: widget.accounts.length,
              itemBuilder: (context, index) {
                final account = widget.accounts[index];
                final isSelected = _selectedAccount?['id'] == account['id'];

                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: isSelected ? Color(0xFF3498db).withOpacity(0.1) : Colors.transparent,
                    border: Border.all(
                      color: isSelected ? Color(0xFF3498db) : Colors.transparent,
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Color(0xFF3498db),
                      child: Text(
                        account['name']?.substring(0, 1) ?? '?',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text(
                      account['name'] ?? 'Sans nom',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: isSelected ? Color(0xFF3498db) : Colors.black,
                      ),
                    ),
                    onTap: () => _selectAccount(account),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildModificationForm() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Modifier le compte',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF34495e),
            ),
          ),
          SizedBox(height: 20),

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

          // Register Number
          _buildFormField(
            label: 'Numéro de register commerce',
            isRequired: true,
            controller: _registerNumberController,
            hintText: '63481534',
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 20),
          // Description
          _buildDescriptionField(),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.account_circle_outlined,
            size: 64,
            color: Colors.grey[400],
          ),
          SizedBox(height: 16),
          Text(
            'Sélectionnez un compte',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Choisissez un compte dans la liste pour modifier ses informations',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey[500],
            ),
          ),
        ],
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
    _registerNumberController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}