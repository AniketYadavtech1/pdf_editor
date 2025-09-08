import 'package:flutter/material.dart';
import 'package:pdf_editor/view/camera/component/allphoto.dart';
import 'package:provider/provider.dart';

import '../../auth/ui/all_pdf.dart';
import '../provider/camera_provider.dart';

class NewHomeScreen extends StatefulWidget {
  const NewHomeScreen({super.key});

  @override
  State<NewHomeScreen> createState() => _NewHomeScreenState();
}

class _NewHomeScreenState extends State<NewHomeScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CameraProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("PDF Application")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () => provider.captureImage(),
              icon: const Icon(Icons.camera_alt),
              label: const Text("Capture Image"),
            ),
            ElevatedButton.icon(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ImageGridScreen()),
              ),
              icon: const Icon(Icons.picture_as_pdf),
              label: const Text("allPhoto"),
            ),
            ElevatedButton.icon(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PdfListScreen()),
              ),
              icon: const Icon(Icons.picture_as_pdf),
              label: const Text("all pdf"),
            ),
          ],
        ),
      ),
    );
  }
}
