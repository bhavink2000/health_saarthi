//@dart=2.9
// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../Font & Color Helper/font_&_color_helper.dart';

class FileImagePicker{
  Future<File> pickFileManger(BuildContext context) async {
    try {
      final pickedFile = await FilePicker.platform.pickFiles(type: FileType.image);
      if (pickedFile == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: hsOne,
            content: const Text(
              'File picker canceled',
              style: TextStyle(fontFamily: FontType.MontserratRegular, color: Colors.white),
            ),
          ),
        );
      }
      final file = File(pickedFile.files.single.path);
      return file;
    } on PlatformException catch (e) {
      print("PlatformException -> $e");
    } catch (e) {
      print("Error -> $e");
    }
  }

  Future<File> pickCamera(BuildContext context)async{
    try {
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
      if (pickedFile == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: hsOne,
            content: const Text(
              'File picker canceled',
              style: TextStyle(fontFamily: FontType.MontserratRegular, color: Colors.white),
            ),
          ),
        );
      }
      final file = File(pickedFile.path);
      return file;
    } on PlatformException catch (e) {
      print("platForm-> $e");
    } catch (e) {
      print("error -> $e");
    }
  }
}