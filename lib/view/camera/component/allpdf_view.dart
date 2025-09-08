import 'package:flutter/material.dart';
import 'package:pdf_editor/view/camera/provider/camera_provider.dart';
import 'package:provider/provider.dart';

class PdfViewScreen extends StatefulWidget {
  const PdfViewScreen({super.key});

  @override
  State<PdfViewScreen> createState() => _PdfViewScreenState();
}

class _PdfViewScreenState extends State<PdfViewScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CameraProvider>().getAllPdfFile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My PDFs")),
      body: Consumer<CameraProvider>(
        builder: (context, v, child) {
          if (v.allPdfs.isEmpty) {
            return const Center(child: Text("No PDF found"));
          }
          return ListView.builder(
            itemCount: v.allPdfs.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: const Icon(Icons.picture_as_pdf, color: Colors.red),
                title: Text(v.allPdfs[index].name),
                subtitle: Text(
                  "Size: ${(v.allPdfs[index].size / 1024).toStringAsFixed(2)} KB\n"
                  "Created: ${v.allPdfs[index].createdAt}",
                ),
                onTap: () {
                  // later: open PDF viewer
                },
              );
            },
          );
        },
      ),
    );
  }
}
