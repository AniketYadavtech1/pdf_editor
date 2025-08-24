import 'dart:io';

import 'package:external_path/external_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:media_scanner/media_scanner.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';

import 'image_list.dart';

class EditorProvider with ChangeNotifier {
  ImagesList imagesList = ImagesList();

  Future<PermissionStatus> storagePermissionStatus() async {
    PermissionStatus status;
    if (Platform.isAndroid) {
      if (await Permission.photos.isGranted || await Permission.photos.isLimited) {
        return Permission.photos.status;
      }
      status = await Permission.photos.request();
    } else {
      status = await Permission.photos.request();
    }
    return status;
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

  Future<void> pickGalleryImage() async {
    PermissionStatus status = await requestMediaPermission();
    if (status.isGranted) {
      final ImagePicker picker = ImagePicker();
      final List<XFile> images = await picker.pickMultiImage();
      if (images.isNotEmpty) {
        imagesList.clearImagesList();
        imagesList.imagePaths.addAll(images);
        notifyListeners();
      }
    } else {
      debugPrint("Permission denied: $status");
    }
  }

  Future<PermissionStatus> cameraPermissionStatus() async {
    PermissionStatus cameraPermissionStatus = await Permission.camera.status;
    if (!cameraPermissionStatus.isGranted) {
      await Permission.camera.request();
    }
    cameraPermissionStatus = await Permission.camera.status;
    return cameraPermissionStatus;
  }

  Future<void> captureCameraImages() async {
    PermissionStatus status = await cameraPermissionStatus();
    if (status.isGranted) {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        imagesList.clearImagesList();
        imagesList.imagePaths.add(image);
      }
    }
  }

  ImagesList imagesLists = ImagesList();
  late double progressValue = 0;
  late bool isExporting = false;
  late int convertedImage = 0;

  Future<void> convertImage() async {
    final pathToSave = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOCUMENTS);
    final pdf = pw.Document();
    for (final imagePath in imagesList.imagePaths) {
      final imageBytes = await File(imagePath.path).readAsBytes();
      final image = img.decodeImage(imageBytes);
      if (image != null) {
        final pdfImage = pw.MemoryImage(imageBytes);
        pdf.addPage(
          pw.Page(build: (pw.Context context) {
            return pw.Center(child: pw.Image(pdfImage));
          }),
        );
      }
      convertedImage++;
      progressValue = convertedImage / imagesList.imagePaths.length;
      notifyListeners();
    }
    final outputFile = File('$pathToSave/NewPdf.pdf');
    await outputFile.writeAsBytes(await pdf.save());
    MediaScanner.loadMedia(path: outputFile.path);
  }
}
