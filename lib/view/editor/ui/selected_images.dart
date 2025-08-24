import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/editor_provider.dart';

class SelectedImages extends StatefulWidget {
  const SelectedImages({super.key});

  @override
  State<SelectedImages> createState() => _SelectedImagesState();
}

class _SelectedImagesState extends State<SelectedImages> {
  @override
  Widget build(BuildContext context) {
    return Consumer<EditorProvider>(
      builder: (context, v, child) => Scaffold(
        appBar: AppBar(
          title: const Text("Selected Images"),
          centerTitle: true,
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
        ),
        bottomNavigationBar: MaterialButton(
          color: Colors.teal,
          textColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 20),
          onPressed: v.convertImage,
          child: const Text(
            'Convert',
            style: TextStyle(fontSize: 18),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Visibility(
                visible: v.isExporting,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: LinearProgressIndicator(
                    minHeight: 25,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
                    value: v.progressValue,
                  ),
                ),
              ),
              Visibility(
                visible: !v.isExporting,
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemCount: v.imagesList.imagePaths.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: Image(
                        image: FileImage(
                          File(v.imagesList.imagePaths[index].path),
                        ),
                        fit: BoxFit.contain,
                      ),
                    );
                  },
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: v.imagesLists.imagePaths.length,
                itemBuilder: (context, index) => Column(
                  children: [],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
