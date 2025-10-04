import 'package:flutter/material.dart';

class BottleSizeWidget extends StatelessWidget {
  final int size33CL;
  final int size50CL;
  final int size1L;
  final int size15L;
  final int size2L;

  const BottleSizeWidget({
    super.key,
    required this.size33CL,
    required this.size50CL,
    required this.size1L,
    required this.size15L,
    required this.size2L,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 250, // Fixed height to enable scrolling
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Scrollbar(
              child: ListView(
                children: [
                  _buildBottleRow('0.33CL', size33CL, 0),
                  _buildBottleRow('0.50CL', size50CL, 1),
                  _buildBottleRow('1L', size1L, 2),
                  _buildBottleRow('1.5L', size15L, 3),
                  _buildBottleRow('2L', size2L, 4),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottleRow(String size, int count, int index) {
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
                size,
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


