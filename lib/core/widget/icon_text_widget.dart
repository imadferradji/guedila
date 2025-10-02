import 'package:flutter/material.dart';
import 'package:qanaty/core/theme/app_style.dart';

class IconTextRow extends StatelessWidget {
  final String iconPath; // chemin de l'icône
  final String text;     // texte à afficher
  final double iconSize;
  final TextStyle? textStyle;
  final VoidCallback? onTap;

  const IconTextRow({
    super.key,
    required this.iconPath,
    required this.text,
    this.iconSize = 24,
    this.textStyle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap, // 👈 déclenche l’action
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              iconPath,
              width: iconSize,
              height: iconSize,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 26),
            Text(
              text,
              style: textStyle ?? Appstyle.textS.copyWith(color: Appstyle.grisC),
            ),
          ],
        ),
      ),
    );
  }
}
