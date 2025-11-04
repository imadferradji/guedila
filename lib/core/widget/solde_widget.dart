import 'package:flutter/material.dart';
import 'package:qanaty/core/theme/app_style.dart';
import 'package:qanaty/core/widget/solde_operation_dialog.dart';

class SoldeWidget extends StatelessWidget {
  final String solde;
  final String dernier_modif;

  const SoldeWidget({
    super.key,
    required this.solde,
    required this.dernier_modif,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          barrierDismissible: true,
          barrierColor: Appstyle.blueF.withOpacity(0.2),
          builder: (context) => const SoldeOperationDialog(),
        );
      },
      child: Container(
        width: 220,
        height: 120,
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
          padding: const EdgeInsets.fromLTRB(10, 5, 6, 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(solde,
                  style: Appstyle.textL_B.copyWith(color: Appstyle.blueF)),
              Text("Solde", style: Appstyle.textM_B.copyWith(color: Appstyle.noir)),
              const SizedBox(height: 12),
              Text(dernier_modif,
                  style: Appstyle.textS_B.copyWith(color: Appstyle.noir)),
              Text("Dernière modification",
                  style: Appstyle.textS_B.copyWith(color: Appstyle.noir)),
            ],
          ),
        ),
      ),
    );
  }
}
