import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf_editor/view/camera/model/camera_pdf.dart';
import 'package:share_plus/share_plus.dart';

class CameraProvider with ChangeNotifier {
  final List<File> images = [];
  final TextEditingController nameCon = TextEditingController();

  List<File> get pdfs => [];
  List<File> allPhoto = [];
  List<File> selectedPhotos = [];
  List<File> cameraPdfList = [];
  bool isSelected = false;

  final picker = ImagePicker();

  Future<void> captureImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      const downloadsPath = "/storage/emulated/0/Download";
      final dir = Directory(downloadsPath);

      if (!await dir.exists()) {
        await dir.create(recursive: true);
      }
      final fileName = "${DateTime.now().millisecondsSinceEpoch}.jpg";
      final newPath = "${dir.path}/$fileName";
      final savedImage = await File(image.path).copy(newPath);
      images.add(savedImage);
    }
  }

  Future<void> loadImages() async {
    const downloadsPath = "/storage/emulated/0/Download";
    final dir = Directory(downloadsPath);
    if (await dir.exists()) {
      final files = dir
          .listSync()
          .where((f) => f.path.endsWith(".jpg") || f.path.endsWith(".png"))
          .map((f) => File(f.path))
          .toList();
      allPhoto = files;
    }
  }

  Future<void> deleteImage(File file) async {
    try {
      if (await file.exists()) {
        await file.delete();
      }
      allPhoto.remove(file);
      notifyListeners();
    } catch (e) {
      debugPrint("Error deleting image: $e");
    }
  }

  toggleSelection(File file) {
    if (selectedPhotos.contains(file)) {
      selectedPhotos.remove(file);
    } else {
      selectedPhotos.add(file);
    }
    notifyListeners();
  }

  Future<void> convertToPdfWithName(String fileName) async {
    if (selectedPhotos.isEmpty) return;
    final pdf = pw.Document();
    for (var file in selectedPhotos) {
      final image = pw.MemoryImage(file.readAsBytesSync());
      pdf.addPage(
        pw.Page(
          build: (pw.Context context) => pw.Center(child: pw.Image(image)),
        ),
      );
    }
    final output = File("/storage/emulated/0/Download/$fileName.pdf");
    await output.writeAsBytes(await pdf.save());
    selectedPhotos.clear();
    notifyListeners();
  }

  List<PdfFileModel> allPdfs = [];

  Future<void> getAllPdfFile() async {
    const downloadPath = "/storage/emulated/0/Download";
    final dir = Directory(downloadPath);
    if (await dir.exists()) {
      final files = dir
          .listSync()
          .where((f) => f.path.toLowerCase().endsWith(".pdf"))
          .map((f) => PdfFileModel.fromFile(File(f.path)))
          .toList();
      allPdfs = files;
      notifyListeners();
    }
  }

  //

  Future<void> deletePdf(PdfFileModel file) async {
    final f = File(file.path);
    if (await f.exists()) {
      await f.delete();
      allPdfs.remove(file);
      notifyListeners();
    }
  }

  void reorderPhotos(int oldIndex, int newIndex) {
    final photo = allPhoto.removeAt(oldIndex);
    allPhoto.insert(newIndex, photo);
    notifyListeners();
  }

  Future<void> renamePdf(PdfFileModel file, String newName) async {
    final f = File(file.path);
    final dir = f.parent.path;
    final newPath = "$dir/$newName.pdf";
    await f.rename(newPath);
    notifyListeners();
  }

  Future<void> sharePdf(PdfFileModel file) async {
    await Share.shareXFiles([XFile(file.path)], text: "Sharing PDF file");
  }

  Future<void> movePdf(PdfFileModel file) async {
    String? selectedDir = await FilePicker.platform.getDirectoryPath();
    if (selectedDir != null) {
      final f = File(file.path);
      final newPath = "$selectedDir/${file.name}";
      await f.rename(newPath);
      notifyListeners();
    }
  }
}
