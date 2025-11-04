import 'package:flutter/material.dart';
import 'package:qanaty/core/theme/app_style.dart';
import 'package:qanaty/core/widget/main_button.dart';
import '../../data/camions.dart';
import '../../data/chauffeurs.dart';
import '../../data/models/camion.dart';
import '../../data/models/chauffeur.dart';
import 'commande_valide_confr_dialog.dart';

class ValidationCommandeDialog extends StatefulWidget {
  final String date;
  final int nCommande;
  final String client;
  final String produit;
  final String quantite;
  final bool palette;
  final String montant;
  final bool avecChauffeur; // ✅ nouveau paramètre

  const ValidationCommandeDialog({
    super.key,
    required this.date,
    required this.nCommande,
    required this.client,
    required this.produit,
    required this.quantite,
    required this.palette,
    required this.montant,
    this.avecChauffeur = true,
  });

  @override
  State<ValidationCommandeDialog> createState() => _ValidationCommandeDialogState();
}

class _ValidationCommandeDialogState extends State<ValidationCommandeDialog> {
  final TextEditingController _dateChargementController = TextEditingController();
  String? selectedSlot;
  Chauffeur? selectedChauffeur;
  Camion? selectedCamion;
  bool activerPlanning = false; // ✅ contrôle l’affichage

  final List<String> slots = ['00-03', '03-06', '06-09', '09-12', '12-15','15-18','18-21','21-00'];

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _dateChargementController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: 650,
        height: 650,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28.0),
          color: Colors.white,
        ),
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 🔹 Titre
              Text(
                'Validation commande',
                style: Appstyle.textL_B.copyWith(color: Appstyle.noir),
              ),
              const SizedBox(height: 16),

              // 🔹 Description
              Text(
                'Veuillez confirmer les informations de la commande :',
                style: Appstyle.textM_B.copyWith(color: Appstyle.gris),
              ),
              const SizedBox(height: 30),

              _buildCommandDetailsTable(),
              const SizedBox(height: 30),



              // 🔹 Bloc Planning de chargement (optionnel)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ✅ Checkbox d’activation
                  Row(
                    children: [
                      Checkbox(
                        value: activerPlanning,
                        onChanged: (val) => setState(() => activerPlanning = val ?? false),
                      ),
                      Text(
                        "Changé la date & slot",
                        style: Appstyle.textS.copyWith(
                          color: Appstyle.blueF,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // ✅ Si activé : afficher date + slot (en plus des autres champs existants)
                  if (activerPlanning)
                     Column(
                       children: [
                         Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [

                           Row(
                             children: [
                               Text(
                                 "Date",
                                 style: Appstyle.textS.copyWith(color: Appstyle.grisC),
                               ),

                              SizedBox(width: 20,),
                               Text(
                                 "25/09/2025",
                                 style: Appstyle.textM_B.copyWith(color: Appstyle.noir),
                                 textAlign: TextAlign.center,
                               ),
                             ],
                           ),

                           Row(
                             children: [
                               Text(
                                 "Slot",
                                 style: Appstyle.textS.copyWith(color: Appstyle.grisC),
                               ),
                               SizedBox(width: 20,),

                               Text(
                                 "06-09",
                                 style: Appstyle.textM_B.copyWith(color: Appstyle.noir),
                                 textAlign: TextAlign.center,
                               ),
                             ],
                           ),
                               SizedBox(width: 20,),

                             ]),
                          SizedBox(height: 20,)  ,
                         Row(
                          children: [
                            // 🔹 Champ Date de chargement
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Date de chargement",
                                    style: Appstyle.textS.copyWith(color: Appstyle.gris),
                                  ),
                                  const SizedBox(height: 6),
                                  TextField(
                                    controller: _dateChargementController,
                                    readOnly: true,
                                    decoration: InputDecoration(
                                      hintText: "Sélectionnez une date",
                                      prefixIcon:
                                      Icon(Icons.calendar_today, color: Appstyle.blueC),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    onTap: () => _selectDate(context),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),

                            // 🔹 Slot (Créneau horaire)
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Créneau horaire (Slot)",
                                    style: Appstyle.textS.copyWith(color: Appstyle.gris),
                                  ),
                                  const SizedBox(height: 6),
                                  DropdownButtonFormField<String>(
                                    value: selectedSlot,
                                    items: slots
                                        .map((slot) => DropdownMenuItem(
                                      value: slot,
                                      child: Text(slot),
                                    ))
                                        .toList(),
                                    onChanged: (val) => setState(() => selectedSlot = val),
                                    decoration: InputDecoration(
                                      hintText: "Choisir un slot",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                                             ),
                       ],
                     ),
                  if (!activerPlanning)
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Row(
                                children: [
                                  Text(
                                    "Date",
                                    style: Appstyle.textS.copyWith(color: Appstyle.grisC),
                                  ),

                                  SizedBox(width: 20,),
                                  Text(
                                    "25/09/2025",
                                    style: Appstyle.textM_B.copyWith(color: Appstyle.noir),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),

                              Row(
                                children: [
                                  Text(
                                    "Slot",
                                    style: Appstyle.textS.copyWith(color: Appstyle.grisC),
                                  ),
                                  SizedBox(width: 20,),

                                  Text(
                                    "06-09",
                                    style: Appstyle.textM_B.copyWith(color: Appstyle.noir),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                              SizedBox(width: 20,),
                            ]),

                  ],
              ),

              SizedBox(height: 20,)  ,


              // 🔹 Si commande sans chauffeur
              if (!widget.avecChauffeur) ...[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Chauffeur",
                    style: Appstyle.textS.copyWith(color: Appstyle.gris),
                  ),
                ),
                const SizedBox(height: 6),
                DropdownButtonFormField<Chauffeur>(
                  value: selectedChauffeur,
                  items: chauffeurs
                      .map((c) => DropdownMenuItem(
                    value: c,
                    child: Text("${c.nom} "),
                  ))
                      .toList(),
                  onChanged: (val) => setState(() => selectedChauffeur = val),
                  decoration: InputDecoration(
                    hintText: "Sélectionner un chauffeur",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 20),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Camion",
                    style: Appstyle.textS.copyWith(color: Appstyle.gris),
                  ),
                ),
                const SizedBox(height: 6),
                DropdownButtonFormField<Camion>(
                  value: selectedCamion,
                  items: camions
                      .map((c) => DropdownMenuItem(
                    value: c,
                    child: Text("${c.Matricule} "),
                  ))
                      .toList(),
                  onChanged: (val) => setState(() => selectedCamion = val),
                  decoration: InputDecoration(
                    hintText: "Sélectionner un camion",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 20),
              ],

              const SizedBox(height: 40),

              // 🔹 Bouton de confirmation
              MainButton(
                text: "Confirmer",
                color: Appstyle.rose,
                noIcon: true,
                onPressed: () {
                  // ✅ Validation complète
                  if (_dateChargementController.text.isEmpty || selectedSlot == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Veuillez compléter tous les champs obligatoires"),
                      ),
                    );
                    return;
                  }

                  if (!widget.avecChauffeur &&
                      (selectedChauffeur == null || selectedCamion == null)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Veuillez sélectionner un chauffeur et un camion"),
                      ),
                    );
                    return;
                  }

                  Navigator.of(context).pop(true);
                  showDialog(
                    context: context,
                    builder: (context) => const CommandeConfirmeeDialog(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 🔹 Tableau des détails
  Widget _buildCommandDetailsTable() {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(1.5),
        1: FlexColumnWidth(2),
        2: FlexColumnWidth(1.5),
        3: FlexColumnWidth(2),
      },
      border: TableBorder.all(color: Colors.white, width: 0),
      children: [
        _buildTableRow(['Date', widget.date, 'Produit', widget.produit]),
        _buildTableRow(['N° Commande', widget.nCommande.toString(), 'Quantité', widget.quantite]),
        _buildTableRow(['Client', widget.client, 'Palette', widget.palette ? 'Oui' : 'Non']),
        _buildTableRow(['', '', 'Montant', widget.montant], isLastRow: true),
      ],
    );
  }

  TableRow _buildTableRow(List<String> cells, {bool isLastRow = false}) {
    return TableRow(
      children: List.generate(
        cells.length,
            (index) => Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            cells[index],
            style: Appstyle.textS_B.copyWith(
              color: (isLastRow && index == 3)
                  ? Appstyle.blueF
                  : (index == 0 || index == 2)
                  ? Appstyle.gris
                  : Appstyle.noir,
              fontWeight: (index == 0 || index == 2)
                  ? FontWeight.normal
                  : FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
