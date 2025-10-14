import 'package:flutter/material.dart';
import 'purchase.dart';

class Confirmation extends StatefulWidget {
  final List<Map<String, dynamic>> commandes;
  final Function(List<Map<String, dynamic>>) onCommandesUpdated;

  const Confirmation({
    super.key,
    required this.commandes,
    required this.onCommandesUpdated,
  });

  @override
  State<Confirmation> createState() => _ConfirmationState();
}

class _ConfirmationState extends State<Confirmation> {
  List<Map<String, dynamic>> get commandes => widget.commandes;

  @override
  Widget build(BuildContext context) {
    double totalSansPalette = _calculateTotalSansPalette();
    double totalAvecPalette = _calculateTotalAvecPalette();

    return Center(
      child: SizedBox(
        width: 400,
        height: 600,
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with back button and title
                Row(
                  children: [
                    SizedBox(
                      width: 40,
                      height: 40,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back, color: Color(0xFFF482D2)),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      "Nouveau commande",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close, color: Colors.black54),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Confirmation Title
                const Center(
                  child: Text(
                    "Confirmation",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: "oswald",
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // Instruction text
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Votre commande est comme suivant:",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Command items list
                Expanded(
                  child: commandes.isEmpty
                      ? const Center(
                    child: Text(
                      "Aucune commande ajoutée",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                        fontFamily: "oswald",
                      ),
                    ),
                  )
                      : ListView.builder(
                    itemCount: commandes.length,
                    itemBuilder: (context, index) {
                      return _buildCommandeItem(commandes[index], index);
                    },
                  ),
                ),

                // Add new command button
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF482D2),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: _addNewCommande,
                    icon: const Icon(Icons.add, color: Colors.white),
                    label: const Text(
                      "Ajouter un nouveau commande",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                const Divider(color: Colors.grey, height: 20),

                // First total
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Total",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: "oswald",
                        ),
                      ),
                      Text(
                        "$totalSansPalette DA",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: "oswald",
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                // Palette rows
                ..._buildPaletteRows(),

                const Divider(color: Colors.grey, height: 20),

                // Final total
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Total",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: "oswald",
                          color: Colors.blue,
                        ),
                      ),
                      Text(
                        "$totalAvecPalette DA",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: "oswald",
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Buttons row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Cancel button
                    SizedBox(
                      width: 120,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey.shade300,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Annuler",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ),

                    // Confirm button
                    SizedBox(
                      width: 120,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFF482D2),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          // Handle confirmation logic here
                          print("Commande confirmée!");
                          _showSuccessDialog();
                        },
                        child: const Text(
                          "Confirmer",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCommandeItem(Map<String, dynamic> commande, int index) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: Table(
        columnWidths: const {
          0: FlexColumnWidth(2),
          1: FlexColumnWidth(2),
          2: FlexColumnWidth(1.5),
        },
        children: [
          TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    Text(
                      "${commande['quantite']} Ptt",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: "oswald",
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red, size: 18),
                      onPressed: () => _removeCommande(index),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  commande['produit'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: "oswald",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  "${commande['montant']} DA",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: "oswald",
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> _buildPaletteRows() {
    List<Widget> rows = [];
    for (var commande in commandes) {
      if (commande['avecPalette'] == true) {
        rows.add(
          Container(
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
            child: Table(
              columnWidths: const {
                0: FlexColumnWidth(2),
                1: FlexColumnWidth(2),
                2: FlexColumnWidth(1.5),
              },
              children: [
                TableRow(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        "24",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: "oswald",
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        "Palette",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: "oswald",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        "${commande['prixPalette']} DA",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: "oswald",
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }
    }
    return rows;
  }

  double _calculateTotalSansPalette() {
    double total = 0;
    for (var commande in commandes) {
      total += commande['montant'];
    }
    return total;
  }

  double _calculateTotalAvecPalette() {
    double total = _calculateTotalSansPalette();
    for (var commande in commandes) {
      if (commande['avecPalette'] == true) {
        total += commande['prixPalette'];
      }
    }
    return total;
  }

  void _addNewCommande() async {
    // Navigate to Purchase widget to add new command
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Purchase(
          nomproduit: "0.5 L",
          palette: "Standard",
          prix: 12500,
        ),
      ),
    );

    // Handle the result returned from Purchase/Decision flow
    if (result != null && result is Map<String, dynamic>) {
      setState(() {
        commandes.add(result);
      });
      widget.onCommandesUpdated(commandes);
    }
  }

  void _removeCommande(int index) {
    setState(() {
      commandes.removeAt(index);
    });
    widget.onCommandesUpdated(commandes);
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Commande Confirmée"),
          content: const Text("Votre commande a été confirmée avec succès!"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }
}