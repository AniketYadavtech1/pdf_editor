import 'package:flutter/cupertino.dart';

class ListProvider with ChangeNotifier {
  List<String> pdfList = [
    "Akash",
    "Dinesh",
    "Suresh",
    "Ramesh",
    "Mahesh",
    "Rajesh",
    "Vikram",
    "Ankit",
    "Prakash",
    "Manish",
    "Sunil",
    "Amit",
    "Deepak",
    "Karan",
    "Arjun",
    "Vivek",
    "Sanjay",
    "Pankaj",
    "Nikhil",
    "Rohit",
  ];

  Future<void> getAllName() async {
    final pdfData = pdfList.toString();
    notifyListeners();
  }
}
