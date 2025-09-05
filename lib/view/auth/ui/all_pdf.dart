import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PdfListScreen extends StatefulWidget {
  const PdfListScreen({super.key});

  @override
  State<PdfListScreen> createState() => _PdfListScreenState();
}

class _PdfListScreenState extends State<PdfListScreen> {
  List<String> pdfPaths = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadPdfs();
  }

  /// Function to get all PDF files from Internal Storage
  Future<void> loadPdfs() async {
    setState(() => isLoading = true);

    // Step 1: Ensure storage permission
    if (await Permission.manageExternalStorage.isGranted || await Permission.storage.isGranted) {
      final Directory rootDir = Directory('/storage/emulated/0');

      if (rootDir.existsSync()) {
        try {
          // Step 2: Fetch PDF files recursively
          final files = rootDir
              .listSync(recursive: true, followLinks: false)
              .where((item) => item is File && item.path.toLowerCase().endsWith('.pdf'))
              .map((e) => e.path)
              .toList();

          setState(() {
            pdfPaths = files;
          });
        } catch (e) {
          debugPrint("Error while scanning: $e");
        }
      }
    } else {
      // Step 3: Request permission
      if (await Permission.manageExternalStorage.request().isGranted || await Permission.storage.request().isGranted) {
        await loadPdfs();
      } else {
        debugPrint("Permission denied");
      }
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("All PDFs in Internal Storage")),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : pdfPaths.isEmpty
              ? const Center(child: Text("No PDF files found"))
              : ListView.builder(
                  itemCount: pdfPaths.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const Icon(Icons.picture_as_pdf, color: Colors.red),
                      title: Text(pdfPaths[index].split('/').last),
                      subtitle: Text(pdfPaths[index]),
                    );
                  },
                ),
    );
  }
}
