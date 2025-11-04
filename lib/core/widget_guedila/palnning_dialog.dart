import 'package:flutter/material.dart';
import 'package:qanaty/core/theme/app_style.dart';
import '../../core/widget/main_button.dart';
import '../../data/produits.dart';
import '../../data/slots.dart';

class PlanningDialog extends StatefulWidget {
  final Map<String, dynamic>? existing; // ✅ planning existant (optionnel)

  const PlanningDialog({Key? key, this.existing}) : super(key: key);

  @override
  State<PlanningDialog> createState() => _PlanningDialogState();
}

class _PlanningDialogState extends State<PlanningDialog> {
  int currentStep = 0;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _date = TextEditingController();
  final TextEditingController _quantite = TextEditingController();

  String? _selectedProduit;
  late List<int> _slotsValues;
  bool _saved = false;
  int nombrejour=0;
  @override
  void initState() {
    super.initState();

    // ✅ Si c'est une modification, on pré-remplit les données existantes
    if (widget.existing != null) {
      final data = widget.existing!;
      _date.text = data['date'] ?? '';
      _selectedProduit = data['produit'];
      _quantite.text = data['quantite']?.toString() ?? '';
      _slotsValues = List<int>.from(data['slots'] ?? List.filled(8, 0));
    } else {
      _slotsValues = List.filled(8, 0);
    }
  }

  int get sommeSlots => _slotsValues.reduce((a, b) => a + b);

  String _getDateFin() {
    if (_date.text.isEmpty) return "-";
    try {
      final parts = _date.text.split("/");
      if (parts.length != 3) return "-";
      final day = int.parse(parts[0]);
      final month = int.parse(parts[1]);
      final year = int.parse(parts[2]);
      final dateDebut = DateTime(year, month, day);
      final dateFin = dateDebut.add(Duration(days: nombrejour-1));
      return "${dateFin.day.toString().padLeft(2, '0')}/${dateFin.month.toString().padLeft(2, '0')}/${dateFin.year}";
    } catch (e) {
      return "-";
    }
  }

  void _repartirQuantite() {
    final quantite = int.tryParse(_quantite.text) ?? 0;
    if (quantite <= 0) return;

    final base = quantite ~/ 8;
    final reste = quantite % 8;
    for (int i = 0; i < 8; i++) {
      _slotsValues[i] = base + (i < reste ? 1 : 0);
    }
    setState(() {});
  }

  Future<void> _selectDate(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now.add(const Duration(days: 1)),
      firstDate: now.add(const Duration(days: 1)),
      lastDate: now.add(const Duration(days: 30)),
      locale: const Locale('fr', 'FR'),
    );
    if (picked != null) {
      setState(() {
        _date.text =
        "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: 600,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Appstyle.blanc,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              child: _buildStepContent(),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                if (currentStep > 0 && currentStep < 2)
                  TextButton(
                    onPressed: () => setState(() => currentStep--),
                    child: const Text("← Retour"),
                  ),
                const Spacer(),
                if (currentStep == 2)
                  MainButton(
                    text: "Fermer",
                    noIcon: true,
                    color: Appstyle.rose,
                    onPressed: () => Navigator.pop(context, {
                      'date': _date.text,
                      'produit': _selectedProduit,
                      'quantite': int.tryParse(_quantite.text) ?? 0,
                      'slots': _slotsValues,
                    }),
                  )
                else
                  MainButton(
                    text: currentStep == 1 ? "Enregistrer" : "Suivant",
                    noIcon: true,
                    iconOnRight: true,
                    color: Appstyle.rose,
                    onPressed: _handleNext,
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _handleNext() {
    if (currentStep == 0) {
      if (_formKey.currentState!.validate()) {
        final quantite = int.tryParse(_quantite.text) ?? 0;
        if (sommeSlots != quantite) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                sommeSlots > quantite
                    ? "⚠️ La somme des slots dépasse la quantité totale !"
                    : "⚠️ La somme des slots est inférieure à la quantité totale !",
              ),
              duration: const Duration(seconds: 3),
            ),
          );
          return;
        }
        setState(() => currentStep++);
      }
    } else if (currentStep == 1) {
      Future.delayed(const Duration(milliseconds: 500), () {
        setState(() {
          _saved = true;
          currentStep++;
        });
      });
    }
  }

  // --- Étape 1
  Widget _buildStep1Saisie() {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        key: const ValueKey("step1"),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.existing != null
                  ? "Modifier un planning"
                  : "Ajouter un planning",
              style: Appstyle.textL_B.copyWith(color: Appstyle.noir),
            ),
            const SizedBox(height: 16),

            // Date
            Text(
              "Sélectionnez une date de production :",
              style: Appstyle.textS_B.copyWith(color: Appstyle.grisC),
            ),
            const SizedBox(height: 10),

            GestureDetector(
              onTap: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now().add(const Duration(days: 1)),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 30)),
                );
                if (picked != null) {
                  setState(() {
                    _date.text =
                    "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
                  });
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _date.text.isEmpty
                          ? "Choisir une date"
                          : _date.text,
                      style: Appstyle.textS_B.copyWith(
                        color: _date.text.isEmpty ? Colors.grey : Appstyle.noir,
                      ),
                    ),
                    const Icon(Icons.calendar_today, color: Colors.grey),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // --- Sélecteur nombre de jour ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Quantité :",
                  style: Appstyle.textS_B.copyWith(color: Appstyle.grisC),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        if (nombrejour > 0) {
                          setState(() => nombrejour = nombrejour - 1);
                        }
                      },
                      icon: Icon(
                        Icons.remove_circle,
                        size: 32,
                        color: Appstyle.grisC,
                      ),
                    ),
                    Container(
                      width: 60,
                      child: TextField(
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        controller: TextEditingController(text: nombrejour.toString()),
                        onChanged: (value) {
                          int? newValue = int.tryParse(value);
                          if (newValue != null) {
                            if (newValue > 7) {
                              newValue = 7; // 🔒 Limite automatique à 24
                            } else if (newValue < 0) {
                              newValue = 0; // 🔒 Évite les valeurs négatives
                            }
                            setState(() => nombrejour = newValue!);
                          }
                        },

                        decoration: InputDecoration(
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 8),
                        ),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        if (nombrejour < 7) {
                          setState(() => nombrejour = nombrejour + 1);
                        }
                      },
                      icon: Icon(Icons.add_circle, size: 32, color: Appstyle.blueF),
                    ),
                  ],
                ),
              ],
            ),


            // Produit
            DropdownButtonFormField<String>(
              value: _selectedProduit,
              decoration: const InputDecoration(labelText: "Produit"),
              items: produits
                  .map((p) => DropdownMenuItem<String>(
                value: p.abrev,
                child: Text(p.abrev),
              ))
                  .toList(),
              onChanged: (value) => setState(() => _selectedProduit = value),
              validator: (v) => v == null ? "Produit requis" : null,
            ),
            const SizedBox(height: 12),

            // Quantité
            TextFormField(
              controller: _quantite,
              keyboardType: TextInputType.number,
              decoration:
              const InputDecoration(labelText: "Quantité journalière"),
              validator: (v) => v!.isEmpty ? "Champ requis" : null,
              onChanged: (v) {
                if (v.isNotEmpty) _repartirQuantite();
              },
            ),
            const SizedBox(height: 20),

            // Répartition par slots
            Text("Répartition par slots",
                style: Appstyle.textM_B.copyWith(color: Appstyle.gris)),
            const SizedBox(height: 10),

            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: List.generate(slots.length, (i) {
                return SizedBox(
                  width: 90,
                  child: TextFormField(
                    key: ValueKey("slot$i-${_slotsValues[i]}"),
                    initialValue: _slotsValues[i].toString(),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: slots[i].nom),
                    onChanged: (v) {
                      final value = int.tryParse(v) ?? 0;
                      setState(() => _slotsValues[i] = value);
                    },
                  ),
                );
              }),
            ),
            const SizedBox(height: 10),

            Text(
              "Total slots : $sommeSlots",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: sommeSlots >
                    (int.tryParse(_quantite.text.isEmpty
                        ? "0"
                        : _quantite.text) ??
                        0)
                    ? Colors.red
                    : Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep2Verification() {
    return SingleChildScrollView(
      key: const ValueKey("step2"),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Vérification du planning",
              style: Appstyle.textL_B.copyWith(color: Appstyle.noir)),
          const SizedBox(height: 20),

          // ✅ Gestion intelligente de la date du / date au
          if (nombrejour > 0) ...[
            _buildInfoRow("Date du", _date.text),
            _buildInfoRow("Date au", _getDateFin()),
          ] else
            _buildInfoRow("Date", _date.text),

          const SizedBox(height: 10),

          _buildInfoRow("Produit", _selectedProduit ?? "-"),
          _buildInfoRow("Quantité", _quantite.text),
          const SizedBox(height: 20),

          Text("Répartition détaillée :",
              style: Appstyle.textS_B.copyWith(color: Appstyle.gris)),
          const SizedBox(height: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              slots.length,
                  (i) => Text("${slots[i].nom} : ${_slotsValues[i]}"),
            ),
          ),
          const SizedBox(height: 40),
          Center(
            child: Text(
              "Confirmez ces informations avant enregistrement.",
              style: Appstyle.textS_B.copyWith(color: Appstyle.gris),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildStep3Result() {
    return Column(
      key: const ValueKey("step3"),
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 40),
        Text(
          _saved ? "Planning enregistré" : "Erreur d’enregistrement",
          style: Appstyle.textL_B.copyWith(color: Appstyle.noir),
        ),
        const SizedBox(height: 30),
        Text(
          _saved
              ? "Le planning a été enregistré avec succès ✅"
              : "Une erreur est survenue ❌",
          style: Appstyle.textS_B.copyWith(color: Appstyle.gris),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 30),
        Icon(
          _saved ? Icons.check_circle : Icons.error,
          color: _saved ? Colors.green : Colors.red,
          size: 80,
        ),
        const SizedBox(height: 40),
      ],
    );
  }

  Widget _buildStepContent() {
    switch (currentStep) {
      case 0:
        return _buildStep1Saisie();
      case 1:
        return _buildStep2Verification();
      case 2:
        return _buildStep3Result();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
              flex: 2,
              child: Text(label,
                  style: Appstyle.textS_B.copyWith(color: Appstyle.gris))),
          Expanded(
              flex: 3,
              child: Text(value,
                  style: Appstyle.textS_B.copyWith(color: Appstyle.noir))),
        ],
      ),
    );
  }
}
