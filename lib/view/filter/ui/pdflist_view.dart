import 'package:flutter/material.dart';
import 'package:pdf_editor/view/utils/indicator.dart';
import 'package:provider/provider.dart';

import '../provider/list_provider.dart';

class PdfListView extends StatefulWidget {
  const PdfListView({super.key});

  @override
  State<PdfListView> createState() => _PdfListViewState();
}

class _PdfListViewState extends State<PdfListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ListProvider>(
        builder: (context, v, child) =>

          Column(
          children: [

          ],
        ),
      ),
    );
  }
}
