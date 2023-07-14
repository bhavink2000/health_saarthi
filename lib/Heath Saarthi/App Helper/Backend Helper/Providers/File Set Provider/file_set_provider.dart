import 'dart:io';

import 'package:flutter/material.dart';

class FileState extends ChangeNotifier {
  File? panCardFile;
  File? addressFile;
  File? aadharCardFFile;
  File? aadharCardBFile;
  File? checkFile;

  void setFile(String type, File file) {
    switch (type) {
      case 'panCard':
        panCardFile = file;
        break;
      case 'address':
        addressFile = file;
        break;
      case 'aadhaarF':
        aadharCardFFile = file;
        break;
      case 'aadhaarB':
        aadharCardBFile = file;
        break;
      case 'checkFile':
        checkFile = file;
        break;
    }

    notifyListeners();
  }
}