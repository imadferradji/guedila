import 'package:flutter/material.dart';
import 'package:qanaty/core/theme/app_style.dart';

class MainButton extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback onPressed;
  final IconData icon; // icône dynamique
  final bool iconOnRight; // pour gérer la position

  const MainButton({
    super.key,
    required this.text,
    required this.color,
    required this.onPressed,
    this.icon = Icons.add, // valeur par défaut
    this.iconOnRight = false, // par défaut icône à gauche
  });

  @override
  Widget build(BuildContext context) {
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
          Icon(icon, color: Colors.white),
        ]
            : [
          Icon(icon, color: Colors.white),
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
