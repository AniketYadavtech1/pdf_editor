import 'package:flutter/material.dart';
import 'package:pdf_editor/view/utils/app_padding.dart';
import 'package:provider/provider.dart';

import '../provider/editor_provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Images To Pdf"),
        centerTitle: true,
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Consumer<EditorProvider>(
        builder: (context, v, child) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MaterialButton(
                color: Colors.teal,
                textColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                onPressed: v.pickGalleryImage,
                child: const Text("Gallery Images"),
              ),
              AppHeights.h18,
              MaterialButton(
                color: Colors.teal,
                textColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                onPressed: v.captureCameraImages,
                child: const Text("Capture Image"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
