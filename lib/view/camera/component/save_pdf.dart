import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/common_button.dart';
import '../provider/camera_provider.dart';

class PdfNameDialog extends StatefulWidget {
  const PdfNameDialog({super.key});

  @override
  State<PdfNameDialog> createState() => _PdfNameDialogState();
}

class _PdfNameDialogState extends State<PdfNameDialog> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Consumer<CameraProvider>(
        builder: (context, v, child) => AlertDialog(
          title: const Text("Enter PDF Name"),
          content: TextField(
            controller: v.nameCon,
            decoration: const InputDecoration(
              hintText: "Enter file name",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            Consumer<CameraProvider>(
              builder: (context, v, child) => CommonButton(
                label: "Save",
                onPressed: () async {
                  final fileName = v.nameCon.text.trim();
                  if (formKey.currentState?.validate() ?? false) {
                    await v.convertToPdfWithName(fileName);
                    Navigator.pop(context);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
