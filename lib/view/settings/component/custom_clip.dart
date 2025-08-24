import 'package:flutter/material.dart';

class CustomChoiceChip extends StatelessWidget {
  final bool selected;
  final VoidCallback onTap;
  final String label;
  final Color? textColor;

  const CustomChoiceChip({
    Key? key,
    required this.selected,
    required this.onTap,
    required this.label,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? Colors.blue : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? Colors.blueAccent : Colors.grey,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: textColor ?? (selected ? Colors.white : Colors.black),
            fontWeight: selected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
