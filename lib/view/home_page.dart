import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:nextgen_pdf_editor/nextgen_pdf_editor.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File? _pdfFile;
  bool _isLoading = false;

  Future<void> _pickPDF() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null && result.files.single.path != null) {
      setState(() {
        _pdfFile = File(result.files.single.path!);
      });
      await _viewPDF();
      await _editPDF();
    }
  }

  Future<void> _editPDF() async {
    if (_pdfFile == null) return;

    setState(() => _isLoading = true);

    File? editedFile = await NGPdf.openEditor(context, _pdfFile!);

    setState(() {
      _pdfFile = editedFile;
      _isLoading = false;
    });
  }

  Future<void> _viewPDF() async {
    if (_pdfFile == null) return;

    await NGPdf.lauchPdf(_pdfFile!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('NextGen PDF Editor Example')),
      body: Column(
        children: [
          const SizedBox(height: 20),
          ElevatedButton(onPressed: _pickPDF, child: const Text('Pick PDF')),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(onPressed: _editPDF, child: const Text('Edit PDF')),
              ElevatedButton(onPressed: _viewPDF, child: const Text('View PDF')),
            ],
          ),
        ],
      ),
    );
  }
}
