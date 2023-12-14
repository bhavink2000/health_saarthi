// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class FileImagePicker{
  Future<File?> pickFileManager(BuildContext context) async {
    try {
      final pickedFile = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        allowedExtensions: ['jpg', 'jpeg', 'png','pdf'],
      );
      if (pickedFile == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No file choose'),
          ),
        );
        return null;
      }
      final originalFile = File(pickedFile.files.single.path!);
      return originalFile;
    } on PlatformException catch (e) {
      print("PlatformException -> $e");
      return null;
    } catch (e) {
      print("Error -> $e");
      return null;
    }
  }

  Future<File?> pickCamera(BuildContext context)async{
    try {
      final pickedFile = await ImagePicker().pickImage(
          source: ImageSource.camera,
          imageQuality: 25
      );
      if (pickedFile == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No image choose'),
          ),
        );
        return null;
      }
      final file = File(pickedFile.path);
      final fileSize = file.lengthSync();
      print("pick camera img size->${formatBytes(fileSize)}");
      return file;
    } on PlatformException catch (e) {
      print("platForm-> $e");
    } catch (e) {
      print("error -> $e");
    }
  }

  String formatBytes(int bytes) {
    double kb = bytes / 1024;
    return kb.toStringAsFixed(2) + ' KB';
  }


}