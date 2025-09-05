import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  static const platform = MethodChannel('storage_permission');

  Future<void> requestStoragePermission() async {
    if (await Permission.manageExternalStorage.isGranted || await Permission.storage.isGranted) {
      print("aniket");
    } else {
      if (await Permission.manageExternalStorage.request().isGranted || await Permission.storage.request().isGranted) {
        print("not take permission");
      } else {
        debugPrint("Permission denied");
      }
    }
  }

  Future<void> openAllFileAccessPage() async {
    try {
      await platform.invokeMethod('openAllFileAccess');
    } on PlatformException catch (e) {
      debugPrint("Error: ${e.message}");
    }
  }

  Future<bool> renamePdf(String oldPath, String newName) async {
    try {
      final result = await platform.invokeMethod('renameFile', {
        "oldPath": oldPath,
        "newName": newName,
      });
      return result as bool;
    } on PlatformException catch (e) {
      debugPrint("Rename error: ${e.message}");
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Welcome to MyPdfMaker App",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await requestStoragePermission();
                await openAllFileAccessPage();
              },
              child: const Text("Allow Permission"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Example: rename "Download/old.pdf" to "newfile.pdf"
                const oldPath = "/storage/emulated/0/Download/old.pdf";
                const newName = "newfile.pdf";
                bool success = await renamePdf(oldPath, newName);
                debugPrint(success ? "Rename success" : "Rename failed");
              },
              child: const Text("Rename PDF File"),
            ),
          ],
        ),
      ),
    );
  }
}
