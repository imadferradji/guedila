import 'package:flutter/material.dart';
import 'package:qanaty/core/theme/app_style.dart';

class MainButton extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback onPressed;
  final IconData? icon; // peut être null
  final bool iconOnRight; // position de l’icône
  final bool noIcon; // désactive complètement l’icône

  const MainButton({
    super.key,
    required this.text,
    required this.color,
    required this.onPressed,
    this.icon,
    this.iconOnRight = false,
    this.noIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    // 🔹 Si noIcon est true, on affiche seulement le texte
    if (noIcon) {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: Appstyle.textM_B.copyWith(color: Appstyle.blanc),
        ),
      );
    }

    // 🔹 Sinon, on affiche le texte + l’icône (personnalisée ou “+” par défaut)
    final usedIcon = icon ?? Icons.add;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: iconOnRight
            ? [
          Text(
            text,
            style: Appstyle.textM_B.copyWith(color: Appstyle.blanc),
          ),
          const SizedBox(width: 8),
          Icon(usedIcon, color: Colors.white),
        ]
            : [
          Icon(usedIcon, color: Colors.white),
          const SizedBox(width: 8),
          Text(
            text,
            style: Appstyle.textM_B.copyWith(color: Appstyle.blanc),
          ),
        ],
      ),
    );
  }
}
