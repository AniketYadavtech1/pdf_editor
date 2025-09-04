import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:media_scanner/media_scanner.dart' show MediaScanner;
import 'package:pdf/pdf.dart' show PdfPageFormat;
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf_editor/view/utils/toast.dart';
import 'package:permission_handler/permission_handler.dart';

class ImagePdfProvider extends ChangeNotifier {
  final List<File> selectedImages = [];
  File? pdfFile;
  List<XFile> savePdfs = [];
  bool load = false;

  List pdfList = [];

  final TextEditingController nameController = TextEditingController(text: "MyPdf");
  Future<void> chooseImages() async {
    PermissionStatus status = await requestMediaPermission();
    if (!status.isGranted) {
      debugPrint("Permission denied: $status");
      return;
    }
    final List<XFile> images = await ImagePicker().pickMultiImage() ?? [];
    if (images.isNotEmpty) {
      selectedImages.clear();
      for (var image in images) {
        final file = File(image.path);
        selectedImages.add(file);
      }
      notifyListeners();
    }
  }

  Future<PermissionStatus> requestMediaPermission() async {
    if (Platform.isAndroid) {
      if (await Permission.photos.isGranted) {
        return Permission.photos.status;
      }
      return await Permission.photos.request();
    } else {
      return await Permission.photos.request();
    }
  }

  Future<File?> convertToPdf(List<File> selectedImages, String fileName) async {
    try {
      if (Platform.isAndroid) {
        if (!await Permission.manageExternalStorage.isGranted) {
          await Permission.manageExternalStorage.request();
        }
      }
      final pdf = pw.Document();
      for (var imageFile in selectedImages) {
        final image = pw.MemoryImage(await imageFile.readAsBytes());
        pdf.addPage(
          pw.Page(
            pageFormat: PdfPageFormat.a4,
            margin: pw.EdgeInsets.zero,
            build: (context) => pw.Image(image, fit: pw.BoxFit.contain),
          ),
        );
      }
      final String downloadsPath = "/storage/emulated/0/Download";
      final outputFile = File("$downloadsPath/$fileName.pdf");
      await outputFile.writeAsBytes(await pdf.save());
      MediaScanner.loadMedia(path: outputFile.path);
      debugPrint("PDF saved: ${outputFile.path}");
      return outputFile;
    } catch (e) {
      debugPrint("Error while converting: $e");
      return null;
    }
  }

  Future<void> getPdf() async {
    final path = "/storage/emulated/0/Download";
    final dir = Directory(path);
    try {
      if (Platform.isAndroid) {
        if (!await Permission.manageExternalStorage.isGranted) {
          await Permission.manageExternalStorage.request();
        }
      }
      if (await dir.exists()) {
        final files = dir.listSync();
        pdfList.clear();

        for (var file in files) {
          if (file is File && file.path.toLowerCase().endsWith(".pdf")) {
            pdfList.add(file.path);
          }
        }
        if (pdfList.isEmpty) {
          AppUtils.show("No PDF files found in Download folder");
        } else {
          notifyListeners();
        }
      } else {
        AppUtils.show("Download folder not found");
      }
    } catch (e) {
      AppUtils.show("Error while fetching PDFs: $e");
    }
  }
}
