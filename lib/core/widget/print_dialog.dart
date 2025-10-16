import 'package:flutter/material.dart';

import '../theme/app_style.dart';
import 'facture_model.dart';

class PrintDialog extends StatefulWidget {
  final Facture facture;

  const PrintDialog({Key? key, required this.facture}) : super(key: key);

  @override
  State<PrintDialog> createState() => _PrintDialogState();
}

class _PrintDialogState extends State<PrintDialog> {
  String _selectedPrinter = 'Sélectionner une imprimante';
  bool _isPrinting = false;

  // Simulated list of available printers
  final List<String> _printers = [
    'Sélectionner une imprimante',
    'Samsung Xpress SL-M2020W',
    'Imprimer en PDF',
  ];

  void _startPrinting() {
    if (_selectedPrinter == 'Sélectionner une imprimante') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Veuillez sélectionner une imprimante'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() {
      _isPrinting = true;
    });

    // Simulate printing process
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isPrinting = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Impression envoyée à $_selectedPrinter'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.of(context).pop();
    });
  }

  void _cancelPrinting() {
    Navigator.of(context).pop();
  }

  void _openPrintPreview() {
    // You can implement print preview functionality here
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Aperçu avant impression'),
          content: Container(
            width: 400,
            height: 500,
            child: _buildPrintPreview(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Fermer'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _startPrinting();
              },
              child: Text('Imprimer'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildPrintPreview() {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'FACTURE',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            Text('Numéro: ${widget.facture.id}'),
            Text('Date: ${widget.facture.dateCommande}'),
            Text('Produit: ${widget.facture.produit}'),
            Text('Quantité: ${widget.facture.quantite}'),
            Text('Montant: ${widget.facture.montant} DA'),
            Text('Date livraison: ${widget.facture.dateLivraison}'),
            Text('Palette: ${widget.facture.pallete}'),
            Text('État: ${widget.facture.etat}'),
            SizedBox(height: 30),
            Divider(),
            SizedBox(height: 20),
            Text(
              'Merci pour votre confiance!',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(color: Appstyle.blanc,
        width: 500,
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Imprimer',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Appstyle.blueC,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close, size: 20),
                  onPressed: _cancelPrinting,
                ),
              ],
            ),

            SizedBox(height: 20),

            // Destination section
            Text(
              'Destination',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Appstyle.noir,
              ),
            ),
            SizedBox(height: 8),

            // Printer dropdown
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Appstyle.blueC),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedPrinter,
                  isExpanded: true,
                  icon: Icon(Icons.arrow_drop_down, color: Appstyle.blueC),
                  items: _printers.map((String printer) {
                    return DropdownMenuItem<String>(
                      value: printer,
                      child: Text(
                        printer,
                        style: TextStyle(
                          color: printer == 'Sélectionner une imprimante'
                              ? Colors.grey
                              : Appstyle.noir,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedPrinter = newValue!;
                    });
                  },
                ),
              ),
            ),

            SizedBox(height: 16),

            // Pages section
            Row(
              children: [
                Text(
                  'Pages',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Appstyle.noir,
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Toutes',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 16),

            // Copies section
            Row(
              children: [
                Text(
                  'Copies',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Appstyle.noir,
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: '1',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),

            SizedBox(height: 24),

            // More options
            InkWell(
              onTap: () {
                // Show more options
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Plus d\'options'),
                      content: Text('Options d\'impression avancées...'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text('Fermer'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.expand_more, color: Appstyle.blueC, size: 20),
                  SizedBox(width: 4),
                  Text(
                    'Plus d\'options',
                    style: TextStyle(color: Appstyle.blueC),
                  ),
                ],
              ),
            ),

            SizedBox(height: 24),

            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: _cancelPrinting,
                  child: Text('Annuler'),
                ),
                SizedBox(width: 12),
                TextButton(
                  onPressed: _openPrintPreview,
                  child: Text('Aperçu'),
                ),
                SizedBox(width: 12),
                ElevatedButton(
                  onPressed: _isPrinting ? null : _startPrinting,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Appstyle.blueC,
                    foregroundColor: Colors.white,
                  ),
                  child: _isPrinting
                      ? SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                      : Text('Imprimer'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}