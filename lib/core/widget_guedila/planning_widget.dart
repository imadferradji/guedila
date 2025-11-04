import 'package:flutter/material.dart';
import 'package:qanaty/core/theme/app_style.dart';
import 'package:qanaty/core/widget/main_button.dart';
import 'package:qanaty/core/widget_guedila/palnning_dialog.dart';
import 'package:qanaty/core/widget_guedila/planning_detail_widget.dart';

class PlanningWidget extends StatefulWidget {
  final String date;
  final String produit;
  final int quantite;
  final String etat;
  final List<int> slots;
  const PlanningWidget({
    super.key,
    required this.date,
    required this.produit,
    required this.quantite,
    required this.etat,
    required this.slots,
  });

  @override
  State<PlanningWidget> createState() => _PlanningWidgetState();
}

class _PlanningWidgetState extends State<PlanningWidget> {
  late String etatActuel;

  @override
  void initState() {
    super.initState();
    etatActuel = widget.etat;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showDialog(
        context: context,
        builder: (_) => DetailPlanningDialog(
          date: widget.date,
          produit: widget.produit,
          quantite: widget.quantite,
          etat: etatActuel,
          slots: widget.slots,
        ),
      ),
      child: Container(
        width: 1600,
        height: 90,
        decoration: BoxDecoration(
          color: Appstyle.blanc,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildInfo("Date", widget.date),
            _buildInfo("Produit", widget.produit, color: Appstyle.blueF),
            _buildInfo("Quantité", widget.quantite.toString()),
            _buildInfo("État", etatActuel,color: etatActuel == "Actif" ? Colors.green : Colors.red),

            // --- Actions ---
            Row(
              children: [
                // 🔹 Modifier
                ElevatedButton(
                  onPressed: () async {
                    final result = await showDialog(
                      context: context,
                      builder: (_) => PlanningDialog(
                        existing: {
                          'date': widget.date,
                          'produit': widget.produit,
                          'quantite': widget.quantite,
                          'slots': widget.slots, // si tu n’as pas encore les slots
                        },
                      ),
                    );

                    if (result != null && mounted) {
                      setState(() {
                        // 🔄 Met à jour les infos localement
                        // (tu peux ensuite appeler ton API de mise à jour ici)
                        // Exemple :
                        etatActuel = 'Actif';
                      });
                    }
                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: Appstyle.blueC,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    minimumSize: const Size(44, 44),
                  ),
                  child: const Icon(Icons.edit, size: 22),
                ),
                const SizedBox(width: 10),

                // 🔹 Activer / Désactiver
                ElevatedButton(
                  onPressed: () => _showConfirmationDialog(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                    etatActuel == "Actif" ? Appstyle.rose : Appstyle.rose,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    minimumSize: const Size(44, 44),
                  ),
                  child: Icon(
                    etatActuel == "Actif" ? Icons.cancel : Icons.check_circle,
                    size: 22,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfo(String title, String value, {Color? color}) {
    return Column(
      children: [
        Text(title, style: Appstyle.textS.copyWith(color: Appstyle.grisC)),
        Text(value, style: Appstyle.textL_B.copyWith(color: color ?? Appstyle.noir)),
      ],
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    final bool isActive = etatActuel == "Actif";
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isActive ? "Désactiver le planning" : "Activer le planning"),
        content: Text(isActive
            ? "Voulez-vous vraiment désactiver ce planning ?"
            : "Voulez-vous réactiver ce planning ?"),
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
              setState(() => etatActuel = isActive ? "Désactivé" : "Actif");
              Navigator.pop(context);
            },
            child: Text(isActive ? "Désactiver" : "Activer"),
          ),
        ],
      ),
    );
  }
}
