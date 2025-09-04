import 'package:flutter/material.dart';

import '../../editor/ui/main_page.dart';
import '../../pdf/ui/getpdf_List.dart';
import '../../pdf/ui/pdf_screen.dart';

class AuthProvider with ChangeNotifier {
  int myCurrentIndex = 0;

  onTabChange(int index) {
    myCurrentIndex = index;
    notifyListeners();
  }

  changePage(int index) {
    if (index != myCurrentIndex) myCurrentIndex = index;
    notifyListeners();
  }

  List pages = [ImagePdfScreen(), MainPage(), PdfViewScreen()];
}
