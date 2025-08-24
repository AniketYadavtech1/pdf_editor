import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:media_scanner/media_scanner.dart' show MediaScanner;
import 'package:pdf/pdf.dart' show PdfPageFormat;
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';

class ImagePdfProvider extends ChangeNotifier {



  final List<File> selectedImages = [];
  File? pdfFile;
  List<File> savePdfs = [];
  bool load = false;
  final TextEditingController nameController = TextEditingController(text: "MyPdf");
  Future<void> chooseImages() async {
    PermissionStatus status = await requestMediaPermission();
    if (!status.isGranted) {
      debugPrint("Permission denied: $status");
      return;
    }
    final List<XFile> images = await ImagePicker().pickMultiImage() ?? [];
    if (images.isNotEmpty) {
      selectedImages.clear(); // clear previous selections
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
      // 1. Permissions
      if (Platform.isAndroid) {
        if (!await Permission.manageExternalStorage.isGranted) {
          await Permission.manageExternalStorage.request();
        }
      }
      // 2. Create PDF
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
      // 3. Path to Downloads folder
      final String downloadsPath = "/storage/emulated/0/Download";
      final outputFile = File("$downloadsPath/$fileName.pdf");
      // 4. Save
      await outputFile.writeAsBytes(await pdf.save());
      // 5. Make visible in file manager
      MediaScanner.loadMedia(path: outputFile.path);
      debugPrint("PDF saved: ${outputFile.path}");
      return outputFile;
    } catch (e) {
      debugPrint("Error while converting: $e");
      return null;
    }
  }
}
