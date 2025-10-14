import 'package:flutter/material.dart';
import 'package:qanaty/core/theme/app_style.dart';

class CamionWidget extends StatefulWidget {
  final String Matricule;
  final String MatriculeR;
  final String type;
  final String tonnage;
  final String etat;

  const CamionWidget({
    super.key,
    required this.Matricule,
    required this.MatriculeR,
    required this.type,
    required this.tonnage,
    required this.etat,
  });

  @override
  State<CamionWidget> createState() => _CamionWidgetState();
}

class _CamionWidgetState extends State<CamionWidget> {
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
              ? "Voulez-vous désactiver ce camion ?"
              : "Voulez-vous activer ce camion ?",
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
            // 👉 Bouton changer déplacé au début avec une icône
            IconButton(
              onPressed: _changerEtat,
              icon: Icon(
                Icons.sync, // icône de changement
                color: Appstyle.gold,
                size: 28,
              ),
              tooltip: "Changer l'état",
            ),

            // Matricule
            Column(
              children: [
                Text("Matricule", style: Appstyle.textS.copyWith(color: Appstyle.grisC)),
                Text(widget.Matricule, style: Appstyle.textM_B.copyWith(color: Appstyle.noir)),
              ],
            ),
            // Remorque
            Column(
              children: [
                Text("Remorque", style: Appstyle.textS.copyWith(color: Appstyle.grisC)),
                Text(widget.MatriculeR, style: Appstyle.textL_B.copyWith(color: Appstyle.noir)),
              ],
            ),
            // Tonnage
            Column(
              children: [
                Text("Tonnage", style: Appstyle.textS.copyWith(color: Appstyle.grisC)),
                Text(widget.tonnage, style: Appstyle.textM_B.copyWith(color: Appstyle.blueF)),
              ],
            ),
            // Type
            Column(
              children: [
                Text("Type", style: Appstyle.textS.copyWith(color: Appstyle.grisC)),
                Text(widget.type, style: Appstyle.textM_B.copyWith(color: Appstyle.noir)),
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
