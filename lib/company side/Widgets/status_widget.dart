import 'package:flutter/material.dart';

class StatusWidget extends StatelessWidget {
  final int enAttente;
  final int validee;
  final int permis;
  final int livree;

  const StatusWidget({
    super.key,
    required this.enAttente,
    required this.validee,
    required this.permis,
    required this.livree,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          _buildStatusRow('En Attente', enAttente, 0),
          _buildStatusRow('Validée', validee, 1),
          _buildStatusRow('Permis', permis, 2),
          _buildStatusRow('Livrée', livree, 3),
        ],
      ),
    );
  }

  Widget _buildStatusRow(String label, int count, int index) {
    final bool isEvenRow = index % 2 == 0;
    final Color backgroundColor = isEvenRow ? Colors.lightBlue[50]! : Colors.white;

    return Container(
      color: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                count.toString(),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
