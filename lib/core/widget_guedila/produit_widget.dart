import 'package:flutter/material.dart';
import 'package:qanaty/core/theme/app_style.dart';
import 'package:qanaty/core/widget_guedila/produit_detail_dialog.dart';
import 'package:qanaty/core/widget_guedila/produit_modif_dialog.dart';
import 'compte_modif_dialog.dart';

class ProduitWidget extends StatefulWidget {
  final bool etat;
  final String id;
  final String nom;
  final String taille;
  final String prix;
  final String categorie;
  final String nombrefardos;
  final String nombrepalette;
  final String createur;
  final String date;

  const ProduitWidget({
    super.key,

    required this.date,
    required this.etat,
    required this.id,
    required this.nom,
    required this.taille,
    required this.prix,
    required this.categorie,
    required this.nombrefardos,
    required this.nombrepalette,
    required this.createur,
  });

  @override
  State<ProduitWidget> createState() => _ProduitWidgetState();
}

class _ProduitWidgetState extends State<ProduitWidget> {
  late String etatActuel;

  @override
  void initState() {
    super.initState();
    etatActuel = widget.etat?"Actif":"Désactif";
  }
  void _showProduitDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => DetailProduitDialog(categorie: widget.categorie,
        nom: widget.nom,
          id: widget.id,
        taille:widget.taille,
        prix: widget.prix,
        nombrefardos:widget.nombrefardos,
        nombrepalette:widget.nombrepalette,
        createur: widget.createur,
        date: widget.date,
        etat: widget.etat)
    );
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showProduitDetails(context) ,
      child: Container(
        width: 1600,
        height: 100,
        decoration: BoxDecoration(
          color: Appstyle.blanc,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildInfo("Date", widget.date),
              _buildInfo("Id Produit", widget.id),
              _buildInfo("Nom de Produit", widget.nom),
              _buildInfo("Status", widget.etat==true?"Actif":"Désactif", color: widget.etat ==true  ? Appstyle.blueF : Appstyle.red),
              _buildInfo("Catégorie", widget.categorie),
              _buildInfo("Prix", widget.prix,color: Appstyle.blueF),

              // 🔹 Boutons d’action
              Row(
                children: [
                  // 🔹 Bouton Modifier
                  ElevatedButton(
                  onPressed: () {
        showModifProduitDialog(
        context,
        id: widget.id,
        nom: widget.nom,
        taille: widget.taille,
        prix: widget.prix,
        categorie: widget.categorie,
        nombrefardos: widget.nombrefardos,
        nombrepalette: widget.nombrepalette,
        );
        },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Appstyle.blueF,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.all(12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      minimumSize: const Size(44, 44),
                    ),
                    child: Image.asset(
                      "assets/icons/pincel.png",
                      width: 22,
                      height: 22,
                    ),
                  ),
                  const SizedBox(width: 10),

                  // 🔹 Bouton Bloquer / Désactiver
                  ElevatedButton(
                    onPressed: () {
                      _showConfirmationDialog(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                      etatActuel == "Actif" ? Colors.red : Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.all(12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      minimumSize: const Size(44, 44),
                    ),
                    child: Icon(
                      etatActuel == "Actif" ? Icons.lock : Icons.lock_open,
                      size: 22,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 🔹 Widget helper pour éviter la répétition
  Widget _buildInfo(String title, String value, {Color? color}) {
    return Column(
      children: [
        Text(
          title,
          style: Appstyle.textM.copyWith(color: Appstyle.grisC),
        ),
        Text(
          value,
          style: Appstyle.textL_B.copyWith(color: color ?? Appstyle.noir),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  /// 🔹 Affiche une boîte de confirmation avant désactivation
  void _showConfirmationDialog(BuildContext context) {
    final bool isActive = etatActuel == "Actif";
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isActive ? "Désactiver le produit" : "Activer le produit"),
        content: Text(isActive
            ? "Voulez-vous vraiment désactiver ce produit ?"
            : "Voulez-vous réactiver ce produit ?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Annuler"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: isActive ? Colors.red : Colors.green,
            ),
            onPressed: () {
              setState(() {
                etatActuel == isActive ? "Actif" : "Désactif";
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(isActive
                      ? "Le compte a été désactivé avec succès."
                      : "Le compte a été réactivé avec succès."),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
            child: Text(isActive ? "Désactiver" : "Activer"),
          ),
        ],
      ),
    );
  }
}
