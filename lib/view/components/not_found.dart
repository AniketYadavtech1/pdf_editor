import 'package:flutter/material.dart';

class NoDataFound extends StatelessWidget {
  final String title;
  final String subTitle;
  final String image;
  const NoDataFound({super.key, required this.title, required this.subTitle, required this.image});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        Text(subTitle),
        const SizedBox(height: 10),
        Image.asset(image),
      ],
    );
  }
}
