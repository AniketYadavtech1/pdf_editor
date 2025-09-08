import 'package:flutter/material.dart';
import 'package:pdf_editor/view/camera/provider/camera_provider.dart';
import 'package:provider/provider.dart';

class PdfViewScreen extends StatefulWidget {
  const PdfViewScreen({super.key});

  @override
  State<PdfViewScreen> createState() => _PdfViewScreenState();
}

class _PdfViewScreenState extends State<PdfViewScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CameraProvider>().getAllPdfFile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My PDFs")),
      body: Consumer<CameraProvider>(
        builder: (context, v, child) {
          if (v.allPdfs.isEmpty) {
            return const Center(child: Text("No PDF found"));
          }
          return ListView.builder(
            itemCount: v.allPdfs.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: const Icon(Icons.picture_as_pdf, color: Colors.red),
                title: Text(v.allPdfs[index].name),
                subtitle: Text(
                  "Size: ${(v.allPdfs[index].size / 1024).toStringAsFixed(2)} KB\n"
                  "Created: ${v.allPdfs[index].createdAt}",
                ),
                onTap: () {
                  // later: open PDF viewer
                },
              );
            },
          );
        },
      ),
    );
  }
}

// /// Bottom Sheet with options
//   void showOptionsBottomSheet() {
//     final pdfProvider = Provider.of<CameraProvider>(context, listen: false);
//
//     showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//       ),
//       builder: (context) {
//         return Wrap(
//           children: [
//             ListTile(
//               leading: const Icon(Icons.delete, color: Colors.red),
//               title: const Text("Delete File"),
//               onTap: () async {
//                 Navigator.pop(context);
//                 await pdfProvider.deletePdf(file);
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.drive_file_rename_outline),
//               title: const Text("Rename File"),
//               onTap: () async {
//                 Navigator.pop(context);
//
//                 _showRenameDialog(context, file, pdfProvider);
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.folder_open),
//               title: const Text("Move to Folder"),
//               onTap: () async {
//                 Navigator.pop(context);
//                 await pdfProvider.movePdf(file);
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.share, color: Colors.blue),
//               title: const Text("Share File"),
//               onTap: () async {
//                 Navigator.pop(context);
//                 await pdfProvider.sharePdf(file);
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   /// Rename dialog
//   void _showRenameDialog(BuildContext context, PdfFileModel file, CameraProvider provider) {
//     final controller = TextEditingController(text: file.name.replaceAll(".pdf", ""));
//
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text("Rename PDF"),
//           content: TextField(
//             controller: controller,
//             decoration: const InputDecoration(
//               labelText: "New name",
//               border: OutlineInputBorder(),
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: const Text("Cancel"),
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 Navigator.pop(context);
//                 await provider.renamePdf(file, controller.text.trim());
//               },
//               child: const Text("Rename"),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
