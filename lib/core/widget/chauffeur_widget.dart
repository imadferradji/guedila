import 'package:flutter/material.dart';
import 'package:qanaty/core/theme/app_style.dart';

class ChauffeurWidget extends StatefulWidget {
  final String Nom;
  final String datenaissance;
  final String npermis;
  final String ntelephone;
  final String etat;

  const ChauffeurWidget({
    super.key,
    required this.Nom,
    required this.datenaissance,
    required this.npermis,
    required this.ntelephone,
    required this.etat,
  });

  @override
  State<ChauffeurWidget> createState() => _ChauffeurWidgetState();
}

class _ChauffeurWidgetState extends State<ChauffeurWidget> {
  late String _etat;

  @override
  void initState() {
    super.initState();
    _etat = widget.etat;
  }

  Color getEtatColor(String etat) {
    switch (etat) {
      case "Actif":
        return Appstyle.vert;
      case "Non Actif":
        return Appstyle.gris;
      default:
        return Appstyle.gris;
    }
  }

  void _changerEtat() async {
    final bool? confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirmation"),
        content: Text(
          _etat == "Actif"
              ? "Voulez-vous désactiver ce chauffeur ?"
              : "Voulez-vous activer ce chauffeur ?",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Annuler"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Appstyle.vert,
            ),
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Confirmer"),
          ),
        ],
      ),
    );

    if (confirm == true) {
      setState(() {
        _etat = (_etat == "Actif") ? "Non Actif" : "Actif";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1600,
      height: 80,
      decoration: BoxDecoration(
        color: Appstyle.blanc,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Appstyle.gris.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 👉 Bouton changer au tout début
            IconButton(
              onPressed: _changerEtat,
              icon: Icon(
                Icons.sync, // icône de changement
                color: Appstyle.gold,
                size: 28,
              ),
              tooltip: "Changer l'état",
            ),

            // Nom
            Column(
              children: [
                Text("Nom", style: Appstyle.textS.copyWith(color: Appstyle.grisC)),
                Text(widget.Nom,
                    style: Appstyle.textM_B.copyWith(color: Appstyle.noir),
                    textAlign: TextAlign.center),
              ],
            ),
            // Date naissance
            Column(
              children: [
                Text("Date de naissance", style: Appstyle.textS.copyWith(color: Appstyle.grisC)),
                Text(widget.datenaissance,
                    style: Appstyle.textL_B.copyWith(color: Appstyle.noir),
                    textAlign: TextAlign.center),
              ],
            ),
            // Permis
            Column(
              children: [
                Text("N° Permis de conduire", style: Appstyle.textS.copyWith(color: Appstyle.grisC)),
                Text(widget.npermis,
                    style: Appstyle.textM_B.copyWith(color: Appstyle.noir),
                    textAlign: TextAlign.center),
              ],
            ),
            // Téléphone
            Column(
              children: [
                Text("N° Téléphone", style: Appstyle.textS.copyWith(color: Appstyle.grisC)),
                Text(widget.ntelephone,
                    style: Appstyle.textM_B.copyWith(color: Appstyle.blueF),
                    textAlign: TextAlign.center),
              ],
            ),
            // Etat
            Container(
              width: 120,
              height: 40,
              decoration: BoxDecoration(
                color: getEtatColor(_etat),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  _etat,
                  style: Appstyle.textM_B.copyWith(color: Appstyle.blanc),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
