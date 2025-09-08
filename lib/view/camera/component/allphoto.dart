import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pdf_editor/view/camera/component/save_pdf.dart';
import 'package:provider/provider.dart';

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
      appBar: AppBar(
        title: const Text("All Photos"),
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            Consumer<CameraProvider>(
              builder: (context, v, child) {
                if (v.selectedPhotos.isNotEmpty) ;
                return IconButton(
                  icon: const Icon(
                    Icons.picture_as_pdf,
                    color: Colors.red,
                  ),
                  onPressed: () => showDialog(
                    context: context,
                    builder: (context) => const PdfNameDialog(),
                  ),
                );
              },
            ),
            Expanded(
              child: Consumer<CameraProvider>(
                builder: (context, v, child) => v.allPhoto.isEmpty
                    ? const Center(child: Text("No image found"))
                    : GridView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(8),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 6,
                          mainAxisSpacing: 6,
                        ),
                        itemCount: v.allPhoto.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () => v.toggleSelection(v.allPhoto[index]),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.file(
                                    File(v.allPhoto[index].path),
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: double.infinity,
                                  ),
                                ),
                                if (v.selectedPhotos.contains(v.allPhoto[index]))
                                  const Positioned(
                                    top: 5,
                                    right: 5,
                                    child: Icon(
                                      Icons.check_circle,
                                      color: Colors.green,
                                      size: 28,
                                    ),
                                  ),
                                Positioned(
                                  bottom: 5,
                                  right: 5,
                                  child: IconButton(
                                    onPressed: () => v.deleteImage(v.allPhoto[index]),
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
