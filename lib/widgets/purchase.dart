import 'package:flutter/material.dart';

class Purchase extends StatefulWidget {
  final String nomproduit;
  final String palette;
  final int prix;

  const Purchase({
    super.key,
    required this.nomproduit,
    required this.palette,
    required this.prix,
  });

  @override
  State<Purchase> createState() => _PurchaseState();
}

class _PurchaseState extends State<Purchase> {
  int quantite = 0;

  /// Fonction qui choisit l'image selon le texte du produit
  String _getProductImage(String nomproduit) {
    String lower = nomproduit.toLowerCase();

    if (lower.contains("0.33") || lower.contains("33")) {
      return "033cl.png";
    } else if (lower.contains("0.5") || lower.contains("50")) {
      return "050cl.png";
    } else if (lower.contains("1") && !lower.contains("1.5")) {
      return "1l.png";
    } else if (lower.contains("1.5")) {
      return "15l.png";
    } else if (lower.contains("2")) {
      return "2l.png";
    }
    return "assets/default.png";
  }

  @override
  Widget build(BuildContext context) {
    num total = widget.prix * (quantite == 0 ? 1 : quantite);
    return Center(
      child: SizedBox(
            width: 400,
            height: 600,
            child:Center(
              child:Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Nouveau commande"),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          SizedBox(
                            width: 30,
                            height: 30,
                            child: Image.asset("logo_commande.png"),
                          ),
                          Text("Produit & Quantite",style: const TextStyle(
                            fontSize: 18,
                            fontFamily: "oswald",
                            fontWeight: FontWeight.bold,
                          ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24,),
                      Center(
                        child: Container(
                          height: 200,
                          width: 150,
                          decoration: BoxDecoration(
                            color: Color(0xFFa6eafd),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child:
                            Padding(padding: EdgeInsets.all(10.0),
                              child: Image.asset(
                                _getProductImage(widget.nomproduit),
                                fit: BoxFit.contain,
                              ),
                            ),


                        ),
                      ),
                      const SizedBox(height: 30),

                      Row(
                        children: [
                          Text("Produit : ",
                              style: const TextStyle(fontSize: 18,fontFamily: "oswald",fontWeight: FontWeight.bold, color: Colors.grey)),
                          Text("${widget.nomproduit}",
                              style: const TextStyle(fontSize: 16,fontFamily: "oswald",fontWeight: FontWeight.bold,)),
                        ],
                      ),

                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text("Palette : ",
                              style: const TextStyle(fontSize: 18,fontFamily: "oswald",fontWeight: FontWeight.bold, color: Colors.grey)),
                          Text("${widget.palette}",
                              style: const TextStyle(fontSize: 16,fontFamily: "oswald",fontWeight: FontWeight.bold,)),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text("Prix : ",
                              style: const TextStyle(fontSize: 18,fontFamily: "oswald",fontWeight: FontWeight.bold, color: Colors.grey)),
                          Text("${widget.prix} DA",
                              style: const TextStyle(fontSize: 18,fontFamily: "oswald",fontWeight: FontWeight.bold,)),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Text("Quantite                  ",style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18,fontFamily: "oswald",color: Colors.grey,)),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                if (quantite > 0) quantite--;
                              }
                              );
                            },
                            icon: const Icon(Icons.remove_circle),
                          ),
                          Container(
                            width: 60,
                            height: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black26),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              "$quantite",
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                quantite++;
                              }
                              );
                            },
                            icon: const Icon(Icons.add_circle),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      Row(
                        children: [
                          Text(
                            "Total : ",
                            style: const TextStyle(
                                fontFamily: "oswald",
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,),
                          ),
                          SizedBox(width: 20,),
                          Text("$total DA",style: const TextStyle(
                              fontFamily: "oswald",
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,),),

                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
    );
  }
}
