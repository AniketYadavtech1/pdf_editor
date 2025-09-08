import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pdf_editor/view/camera/component/save_pdf.dart';
import 'package:provider/provider.dart';
import 'package:reorderables/reorderables.dart';

import '../provider/camera_provider.dart';

class ImageGridScreen extends StatefulWidget {
  const ImageGridScreen({super.key});

  @override
  State<ImageGridScreen> createState() => _ImageGridScreenState();
}

class _ImageGridScreenState extends State<ImageGridScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    context.read<CameraProvider>().loadImages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("All Photos")),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            Consumer<CameraProvider>(
              builder: (context, v, child) {
                if (v.selectedPhotos.isNotEmpty) {
                  return IconButton(
                    icon: const Icon(Icons.picture_as_pdf, color: Colors.red),
                    onPressed: () => showDialog(
                      context: context,
                      builder: (context) => const PdfNameDialog(),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
            Expanded(
              child: Consumer<CameraProvider>(
                builder: (context, v, child) {
                  if (v.allPhoto.isEmpty) {
                    return const Center(child: Text("No image found"));
                  }

                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(8),
                    child: ReorderableWrap(
                      spacing: 6,
                      runSpacing: 6,
                      needsLongPressDraggable: true, // drag with long press
                      children: v.allPhoto.map((photo) {
                        return GestureDetector(
                          key: ValueKey(photo.path), // important for reorder
                          onTap: () => v.toggleSelection(photo),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.file(
                                  File(photo.path),
                                  fit: BoxFit.cover,
                                  width: 100,
                                  height: 100,
                                ),
                              ),
                              if (v.selectedPhotos.contains(photo))
                                const Positioned(
                                  top: 5,
                                  right: 5,
                                  child: Icon(Icons.check_circle, color: Colors.green, size: 28),
                                ),
                              Positioned(
                                bottom: 5,
                                right: 5,
                                child: IconButton(
                                  onPressed: () => v.deleteImage(photo),
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                      onReorder: (oldIndex, newIndex) {
                        v.reorderPhotos(oldIndex, newIndex);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
