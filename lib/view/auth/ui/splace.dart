import 'package:flutter/material.dart';

import 'new_bottom_bar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () async {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (con) => NewBottomBar()), (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
