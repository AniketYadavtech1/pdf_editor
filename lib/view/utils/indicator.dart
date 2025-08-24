import 'package:flutter/material.dart';

import 'app_colors.dart';

class Indicator extends StatelessWidget {
  final Color? color;

  const Indicator({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(color: color ?? AppColors.white),
      ),
    );
  }
}
