import 'package:flutter/material.dart';
import 'package:pdf_editor/view/pdf/provider/pdfprovider.dart';
import 'package:pdf_editor/view/utils/app_colors.dart';
import 'package:provider/provider.dart';

import '../../utils/app_padding.dart';

class PdfViewScreen extends StatefulWidget {
  const PdfViewScreen({super.key});

  @override
  State<PdfViewScreen> createState() => _PdfViewScreenState();
}

class _PdfViewScreenState extends State<PdfViewScreen> {
  @override
  void initState() {
    context.read<ImagePdfProvider>().getPdf();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.red,
      body: Consumer<ImagePdfProvider>(
        builder: (context, v, child) => ListView.builder(
          padding: AppPaddings.h8v4,
          shrinkWrap: true,
          itemCount: v.pdfList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [Text("ram")]),
            );
          },
        ),
      ),
    );
  }
}
