import 'package:flutter/material.dart';
import '../theme/app_style.dart';
import '../widget/main_button.dart'; // ajuste le chemin selon ton architecture

class CommandeAnnuleeDialog extends StatelessWidget {
  const CommandeAnnuleeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28.0),
        ),
        width: 600,
        height: 500,
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 🔹 Titre
            Text(
                'Commande annulée',
                style: Appstyle.textL_B.copyWith(color: Appstyle.noir)
            ),
            const SizedBox(height: 60),

            // 🔹 Message de succès
            Text(
              'Votre commande a bien été annulée',
              style: Appstyle.textM_B.copyWith(color: Appstyle.gris),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 60),

            // 🔹 Icône ou image
            Image.asset(
              "icons/croix_icon.png",
              height: 100,
            ),

            const SizedBox(height: 100),

            // 🔹 Bouton Terminer
            MainButton(text: "Terminer", color: Appstyle.rose, onPressed: () => Navigator.of(context).pop(),noIcon: true,)


          ],
        ),
      ),
    );
  }
}
