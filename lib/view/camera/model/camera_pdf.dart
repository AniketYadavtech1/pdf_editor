import 'dart:io';
import 'dart:typed_data';

class PdfFileModel {
  final String name;
  final String path;
  final int size;
  final DateTime createdAt;
  int pageCount;
  Uint8List? thumbnail;
  PdfFileModel({
    required this.name,
    required this.path,
    required this.size,
    required this.createdAt,
    this.pageCount = 0,
    this.thumbnail,
  });

  factory PdfFileModel.fromFile(File file) {
    final stat = file.statSync();
    return PdfFileModel(
      name: file.uri.pathSegments.last,
      path: file.path,
      size: stat.size,
      createdAt: stat.modified,
    );
  }
}
