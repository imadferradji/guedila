import 'package:flutter/material.dart';

class Decision extends StatefulWidget {
  final int prixPalette;
  final int totalCommande;
  final int nbPalette;
  final String nomproduit;

  const Decision({
    super.key,
    required this.prixPalette,
    required this.totalCommande,
    required this.nbPalette,
    required this.nomproduit,
  });

  @override
  State<Decision> createState() => _DecisionState();
}

class _DecisionState extends State<Decision> {
  bool? avecPalette;

  @override
  Widget build(BuildContext context) {
    num total = widget.totalCommande + (avecPalette == true ? widget.prixPalette : 0);

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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
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

                Row(
                  children: const [
                    Icon(Icons.inventory_2_outlined, color: Colors.grey),
                    SizedBox(width: 8),
                    Text(
                      "Palette",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: "oswald",
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 22),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child:  Text(
                    "Merci de nous confirmer est ce que votre commande est avec ou sans palette",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),

                const SizedBox(height: 20),

                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                    ),
                    const Icon(Icons.local_shipping_outlined, size: 50, color: Colors.grey),
                    const SizedBox(width: 12),
                    Column(
                      children: [
                        Text(
                          "${widget.nbPalette} Palettes",
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "Prix: ${widget.prixPalette} DA",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                // Oui / Non
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildChoiceButton("Oui", true),
                    _buildChoiceButton("Non", false),
                  ],
                ),

                const Spacer(),

                Row(
                  children: [
                    const Text(
                      " Total",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width:15,),
                    Text(
                      "$total.00 DA",
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(width: 50,),
                    SizedBox(
                      width: 100,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFF482D2),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: avecPalette == null
                            ? null
                            : () {
                          // Create command data
                          Map<String, dynamic> commandeData = {
                            'quantite': widget.nbPalette,
                            'produit': widget.nomproduit,
                            'montant': widget.totalCommande.toDouble(),
                            'avecPalette': avecPalette!,
                            'prixPalette': widget.prixPalette.toDouble(),
                          };

                          // Navigate back to Purchase with the result, which will then pass it to Confirmation
                          Navigator.of(context).pop(commandeData);
                        },
                        child: const Text(
                          "Suivant →",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.white,),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChoiceButton(String label, bool value) {
    final isSelected = avecPalette == value;
    return GestureDetector(
      onTap: () {
        setState(() {
          avecPalette = value;
        });
      },
      child: Container(
        width: 120,
        height: 80,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? Color(0xFFF482D2) : Colors.transparent,
            width: 2,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 22,
            color: Colors.grey.shade600,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}