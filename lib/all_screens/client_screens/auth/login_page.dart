import 'package:flutter/material.dart';
import 'package:qanaty/core/theme/app_style.dart';
import 'package:qanaty/core/widget/commande_widget.dart';
import 'package:qanaty/core/widget/commande_widget_plus_imprimer.dart';
import 'package:qanaty/core/widget/side_bar_widget.dart';
import 'package:qanaty/core/widget/solde_widget.dart';
import 'package:qanaty/core/widget/virement_dialog.dart';
import 'package:qanaty/core/widget/virement_widget.dart';

import '../../../core/widget/main_button.dart';
import '../../../core/widget/periode_selector.dart';
import '../../../core/widget/search_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _controller = TextEditingController();
  String _text = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appstyle.gris,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 5, // colonne principale
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SearchField(controller: _controller),
                    const SizedBox(height: 16),
                   PeriodSelector(),
                    const SizedBox(height: 16),
                    MainButton(
                      text: "Ajouter",
                      color: Appstyle.rose,
                      onPressed: () {
                        debugPrint("Bouton rose pressé !");
                      },
                    ),
                    const SizedBox(height: 16),
                    MainButton(
                      text: "Ajouter",
                      color: Appstyle.blueC,
                      onPressed: () {
                        debugPrint("Bouton bleu pressé !");
                      },
                    ),
                    const SizedBox(height: 16),
                    SoldeWidget(solde: "750000.00", dernier_modif: "12/05/2025"),
                    const SizedBox(height: 16),
                    VirementWidget(
                      numero: '2534620',
                      montant: '202000.00',
                      date: '15/03/2025',
                      etat: 'Validé',
                    ),
                    const SizedBox(height: 16),
                     const SizedBox(height: 16),
                    const SizedBox(height: 16),
                    Text("NEW"),
                    const SizedBox(height: 16),
                    MainButton(
                      text: "Ajouter",
                      color: Appstyle.rose,
                      onPressed: () {
                      },
                    ),
                    const SizedBox(height: 16),
                    MainButton(
                      text: "Virement",
                      color: Appstyle.rose,
                      onPressed: () {
                        showNouvelleVirementDialog(context);
                      },
                    ),

                  ],
                ),


              ),
              const SizedBox(width: 20),
              Expanded(
                flex: 1, // sidebar
                child: SideBarWidget(),
              ),
            ],
          ),

        ),
      ),

    );
  }
}
