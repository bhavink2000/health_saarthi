import 'dart:io';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_install_apk_silently/flutter_install_apk_silently.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../Font & Color Helper/font_&_color_helper.dart';

class UpdateAppDialog{

  static bool? showLoading = false;
  static void showUpdateAppDialog(BuildContext context, var updateMsg, var appVersion){
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
              child: AlertDialog(
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25))),
                contentPadding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                content: Container(
                  width: MediaQuery.of(context).size.width / 1.5,
                  height: MediaQuery.of(context).size.height / 2.8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "About update?",
                        style: TextStyle(
                            fontFamily: FontType.MontserratMedium,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "$updateMsg Version $appVersion is now available - \nYour current app version 1.0",
                        style: const TextStyle(
                            fontFamily: FontType.MontserratLight),
                      ),
                      const SizedBox(height: 10,),
                      const Text("Would you like to update it now?",
                          style: TextStyle(fontFamily: FontType.MontserratLight)),
                      const SizedBox(height: 10),
                      const Text("Release Notes:",
                          style: TextStyle(
                              fontFamily: FontType.MontserratMedium,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(height: 5),
                      const Text("Minor update and \nimprovement",
                        style: TextStyle(fontFamily: FontType.MontserratLight),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              onPressed: (){
                                Navigator.pop(context);
                              },
                              child: const Text("Later")
                          ),
                          TextButton(
                              onPressed: ()async {
                                if (showLoading == true) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text("Please Wait",style: TextStyle(fontFamily: FontType.MontserratMedium, fontWeight: FontWeight.bold)),
                                        content: Text("A download is already in progress. Please wait.",style: TextStyle(fontFamily: FontType.MontserratLight)),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text("OK"),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                } else {
                                  setState(() {
                                    progress = 0.0;
                                    showLoading = true;
                                  });

                                  await startDownloading(setState, context, () {
                                    Navigator.pop(context);
                                    _showDownloadCompleteDialog(context);
                                  }, (double newProgress) {
                                    setState(() {
                                      progress = newProgress;
                                    });
                                  });

                                  // After download is complete or if an error occurs, reset the state
                                  setState(() {
                                    showLoading = false;
                                    progress = 0.0;
                                  });
                                }
                              },
                              child: const Text("Update Now")
                          ),
                        ],
                      ),
                      showLoading == true ? LinearProgressIndicator(value: progress) : Container(),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  static double progress = 0.0;
  static Dio dio = Dio();

  static Future<void> startDownloading(Function setState, BuildContext context, VoidCallback onComplete, Function(double) onProgress,) async {
    const String url = 'https://healthsaarthi.windzoon.in/app-release.apk';
    const String fileName = "HealthSaarthi.apk";
    String path = await _getFilePath(fileName);

    await dio.download(
      url,
      path,
      onReceiveProgress: (receivedBytes, totalBytes) {
        double newProgress = receivedBytes / totalBytes;
        print(newProgress);
        onProgress(newProgress); // Update the progress state
      },
      deleteOnError: true,
    ).then((_) {
      onComplete(); // Call the completion callback when the download is complete
    });
  }
  static Future<String> _getFilePath(String filename) async {
    Directory? downloadsDirectory = await getExternalStorageDirectory();
    if (downloadsDirectory != null) {
      return File('/storage/emulated/0/Download/$filename').path;
    } else {
      throw Exception("Could not access downloads directory");
    }
  }

  static String _status = "idle";
  static String _message = 'Please browse APK.';
  static void _showDownloadCompleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Download Complete",style: TextStyle(fontFamily: FontType.MontserratMedium,fontWeight: FontWeight.bold)),
          content: const Text("Download is complete. You can now install the update from the file location.\nDownloaded file :-/storage/emulated/0/Download",style: TextStyle(fontFamily: FontType.MontserratLight)),
          actions: [
            TextButton(
              onPressed: () async{
                // var status = await Permission.storage.request();
                // print("permission status-> ${status.isGranted}");
                // print("permission status-> ${status.isDenied}");
                // if (status.isGranted) {
                //   print("in if");
                //   FilePickerResult? result = await FilePicker.platform.pickFiles(
                //     type: FileType.custom,
                //     allowedExtensions: ['apk'],
                //   );
                //   if (result != null && result.files.isNotEmpty) {
                //     PlatformFile file = result.files.first;
                //     try {
                //       final apkFile = File(file.path!);
                //       bool? isInstalled = await FlutterInstallApkSilently.installAPK(file: apkFile);
                //       if (isInstalled!) {
                //         _status = "success";
                //         _message = "The APK is installed successfully.";
                //         print('in if->$_status $_message');
                //       } else {
                //         _status = "failed";
                //         _message = "The APK installation failed.";
                //         print('in else->$_status $_message');
                //       }
                //     } catch (e) {
                //       print("Error installing APK: $e");
                //       _status = "failed";
                //       _message = "An error occurred during installation.";
                //     }
                //   }
                // } else {
                //   print("in else");
                //   print("where the user didn't grant permission");
                // }
                Navigator.pop(context);
              },
              child: const Text("Ok"),
            ),
          ],
        );
      },
    );
  }
}