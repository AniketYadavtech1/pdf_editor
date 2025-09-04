import 'dart:io';

import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf_editor/view/pdf/ui/getpdf_List.dart';
import 'package:provider/provider.dart';

import '../../components/common_button.dart';
import '../../drower/drower.dart';
import '../../settings/component/app_colorss.dart';
import '../../settings/component/app_texts.dart';
import '../../utils/app_padding.dart';
import '../provider/pdfprovider.dart';

class ImagePdfScreen extends StatefulWidget {
  const ImagePdfScreen({super.key});

  @override
  State<ImagePdfScreen> createState() => _ImagePdfScreenState();
}

class _ImagePdfScreenState extends State<ImagePdfScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      extendBody: true,
      endDrawer: DrawerScreen(),
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              scaffoldKey.currentState?.openEndDrawer();
            },
          ),
        ],
        title: Text("Converter", style: AppTextStyles.kSmall18SemiBoldTextStyle),
        backgroundColor: AppColorss.highlightColor,
      ),
      body: Column(
        children: [
          CommonButton(
            label: "pdfList",
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => PdfViewScreen()));
            },
          ),
          AppHeights.h4,
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Consumer<ImagePdfProvider>(
                  builder: (context, v, child) => Expanded(
                    child: CommonButton(
                      buttonBorderColor: AppColorss.white,
                      buttonColor: AppColorss.error20,
                      label: "Pick Image",
                      onPressed: () => v.chooseImages(),
                      labelColor: AppColorss.primary,
                    ),
                  ),
                ),
                AppWidths.w5,
                Consumer<ImagePdfProvider>(
                  builder: (context, v, child) => Expanded(
                    child: CommonButton(
                      buttonBorderColor: AppColorss.white,
                      label: "Convert to PDF",
                      load: v.load,
                      buttonColor: AppColorss.error20,
                      onPressed: v.selectedImages.isEmpty
                          ? null
                          : () async {
                              v.nameController;
                              final String? fileName = await showDialog<String>(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text("Save PDF"),
                                    content: TextField(
                                      controller: v.nameController,
                                      decoration: const InputDecoration(
                                        labelText: "Enter PDF file name",
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        child: const Text("Cancel"),
                                        onPressed: () => Navigator.pop(context, null),
                                      ),
                                      TextButton(
                                        child: const Text("Save"),
                                        onPressed: () => Navigator.pop(context, v.nameController.text.trim()),
                                      ),
                                    ],
                                  );
                                },
                              );
                              if (fileName != null && fileName.isNotEmpty) {
                                final pdfFile = await v.convertToPdf(v.selectedImages, fileName);
                                if (pdfFile != null) {
                                  OpenFile.open(pdfFile.path);
                                }
                              }
                            },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Consumer<ImagePdfProvider>(
            builder: (context, v, child) => v.selectedImages.isEmpty
                ? const Center(child: Text("select image to convert pdf"))
                : Expanded(
                    child: ListView.builder(
                      padding: AppPaddings.h8v4,
                      shrinkWrap: true,
                      itemCount: v.selectedImages.length,
                      itemBuilder: (context, index) {
                        File file = v.selectedImages[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(children: [Image.file(file)]),
                        );
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
