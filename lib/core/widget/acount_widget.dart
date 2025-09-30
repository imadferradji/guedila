import 'package:flutter/material.dart';
import 'package:qanaty/core/theme/app_style.dart';

class AccountWidget extends StatelessWidget {
  final String name;
  final String imageUrl;

  const AccountWidget({
    super.key,
    required this.name,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 14,
            backgroundImage: NetworkImage(imageUrl),
          ),
          const SizedBox(width: 8),
          Text(name, style:Appstyle.textS_B.copyWith(color: Appstyle.noir)),
          const Icon(Icons.keyboard_arrow_down, size: 20),
        ],
      ),
    );
  }
}
