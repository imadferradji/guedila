import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/theme/app_style.dart';

class ManageAccountsDialog extends StatefulWidget {
  final List<Map<String, dynamic>> accounts;

  const ManageAccountsDialog({Key? key, required this.accounts}) : super(key: key);

  @override
  _ManageAccountsDialogState createState() => _ManageAccountsDialogState();
}

class _ManageAccountsDialogState extends State<ManageAccountsDialog> {
  Map<String, dynamic>? _selectedAccount;

  void _selectAccount(Map<String, dynamic> account) {
    setState(() {
      _selectedAccount = account;
    });
  }

  void _deleteAccount() {
    if (_selectedAccount != null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Confirmer la suppression'),
            content: Text('Êtes-vous sûr de vouloir supprimer le compte "${_selectedAccount!['name']}" ? Cette action est irréversible.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Annuler'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Here you would typically delete the account from your backend
                  print('Compte supprimé: ${_selectedAccount!['id']} - ${_selectedAccount!['name']}');

                  // Remove from local list
                  widget.accounts.removeWhere((account) => account['id'] == _selectedAccount!['id']);

                  Navigator.of(context).pop(); // Close confirmation dialog
                  Navigator.of(context).pop(); // Close main dialog

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Compte supprimé avec succès!'),
                      backgroundColor: Colors.red,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: Text('Supprimer', style: TextStyle(color: Colors.white)),
              ),
            ],
          );
        },
      );
    }
  }

  void _clearSelection() {
    setState(() {
      _selectedAccount = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        color: Appstyle.blanc,
        constraints: BoxConstraints(maxWidth: 500),
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
                'Gestion des Comptes',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            // Content
            Padding(
              padding: EdgeInsets.all(25),
              child: Column(
                children: [
                  // Accounts List
                  _buildAccountsList(),

                  SizedBox(height: 20),

                  // Selected Account Details
                  if (_selectedAccount != null) _buildAccountDetails(),
                ],
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
                    ElevatedButton(
                      onPressed: _deleteAccount,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Appstyle.rose,
                        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                      ),
                      child: Text(
                        'Supprimer le compte',
                        style: TextStyle(
                          color: Colors.white,
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
                          'Fermer',
                          style: TextStyle(
                            color: Color(0xFF7f8c8d),
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
        Container(
          height: 200,
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFFdddddd)),
            borderRadius: BorderRadius.circular(6),
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
                  subtitle: Text(
                    account['type'] ?? 'Type inconnu',
                    style: TextStyle(fontSize: 12),
                  ),
                  trailing: Text(
                    account['registerNumber'] ?? '',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600],
                    ),
                  ),
                  onTap: () => _selectAccount(account),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAccountDetails() {
    final account = _selectedAccount!;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Color(0xFFdddddd)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Détails du compte sélectionné:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF34495e),
            ),
          ),
          SizedBox(height: 10),
          _buildDetailRow('Nom:', account['name'] ?? 'Non spécifié'),
          _buildDetailRow('Type:', account['type'] ?? 'Non spécifié'),
          _buildDetailRow('Numéro RC:', account['registerNumber'] ?? 'Non spécifié'),
          if (account['description'] != null && account['description'].isNotEmpty)
            _buildDetailRow('Description:', account['description']),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: Color(0xFF34495e),
              ),
            ),
          ),
        ],
      ),
    );
  }
}