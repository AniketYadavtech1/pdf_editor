import 'package:flutter/cupertino.dart';

class VGap extends StatelessWidget {
  final double size;

  const VGap(this.size, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: size);
  }
}
