// ignore_for_file: use_build_context_synchronously

import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/Snack%20Bar%20Msg/getx_snackbar_msg.dart';
import 'package:install_plugin/install_plugin.dart';
import '../Font & Color Helper/font_&_color_helper.dart';

class UpdateAppDialog{

  static bool? showLoading = false;
  static double? downloadProgress = 0.0;
  static void showUpdateAppDialog(BuildContext context, var updateMsg, var appVersion){
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: StatefulBuilder(
            builder: (context, setState) {
              return BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                child: AlertDialog(
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25))),
                  contentPadding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                  content: Container(
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Align(alignment: Alignment.center,child: Image(image: AssetImage('assets/health_saarthi_logo_transparent_bg.png'),width: 150,)),
                        Divider(thickness: 0.5,color: Colors.grey.withOpacity(0.5),),
                        const Text(
                          "About update?",
                          style: TextStyle(
                              fontFamily: FontType.MontserratMedium,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5,),
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
                                fontWeight: FontWeight.bold
                            )),
                        const SizedBox(height: 5),
                        const Text("- Make UI attractive, \n- Exit and back functionality, \n- (*) with red color for mandatory field, \n- Notification",
                          style: TextStyle(fontFamily: FontType.MontserratLight),),
                        Divider(thickness: 0.5,color: Colors.grey.withOpacity(0.5),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: ()async {
                                  var url = 'https://hssawpl.com/mobile-app/healthsaarthi.apk';
                                  if(showLoading == true){
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text("Please Wait",style: TextStyle(fontFamily: FontType.MontserratMedium, fontWeight: FontWeight.bold)),
                                          content: const Text("A download is already in progress. Please wait.",style: TextStyle(fontFamily: FontType.MontserratLight)),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text("OK"),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }
                                  else{
                                    FileDownloader.downloadFile(
                                        url: url,
                                        name: 'healthsaarthi.apk',
                                        onProgress: (name, progres) {
                                          print("progress->$progres");
                                          setState(() {
                                            showLoading = true;
                                            downloadProgress = progres;
                                          });
                                        },
                                        onDownloadCompleted: (value) {
                                          print('path  $value ');
                                          setState(() {
                                            downloadProgress = 0;
                                            showLoading = false;
                                          });
                                          _showDownloadCompleteDialog(context);
                                        },
                                        onDownloadError: (String error) {
                                          GetXSnackBarMsg.getWarningMsg('File download error.\n please try again');
                                          Navigator.pop(context);
                                          print('DOWNLOAD ERROR: $error');
                                        });
                                  }
                                },
                                child: Text("Update Now",style: TextStyle(fontFamily: FontType.MontserratMedium,color: hsPrime,fontWeight: FontWeight.bold,fontSize: 16),)
                            ),
                          ],
                        ),
                        showLoading == true ? Text("Downloading : $downloadProgress",textAlign: TextAlign.right,) : Container(),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  static Dio dio = Dio();

  static void _showDownloadCompleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            title: const Text("Download Complete",style: TextStyle(fontFamily: FontType.MontserratMedium,fontWeight: FontWeight.bold)),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            //content: const Text("Download is complete. You can now install the update from the file location.\nDownloaded file :-/storage/emulated/0/Download",style: TextStyle(fontFamily: FontType.MontserratLight)),
            content: const Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Download is complete. You can now install the update from the file location.',style: TextStyle(fontFamily: FontType.MontserratLight)),
                SizedBox(height: 5),
                Text('Location',style: TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 16,fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                Text('/storage/emulated/0/Download',style: TextStyle(fontFamily: FontType.MontserratLight,fontSize: 14))
              ],
            ),
            actions: [
              //TextButton(onPressed: (){Navigator.of(context, rootNavigator: true).pop();}, child: Text('Cancel',style: TextStyle(fontFamily: FontType.MontserratMedium,fontWeight: FontWeight.bold,color: hsPrime),)),
              TextButton(
                onPressed: () async{
                  _localInstallApk();
                },
                child: Text("Install",style: TextStyle(fontFamily: FontType.MontserratMedium,fontWeight: FontWeight.bold,color: hsPrime),),
              ),
            ],
          ),
        );
      },
    );
  }

  static _localInstallApk() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['apk']);
    if (result != null) {
      final res = await InstallPlugin.installApk(result.files.single.path ?? '');
      print("localInstall->${res['isSuccess']}/error ->${res['errorMessage']}");
    } else {
      print('No apk select');
      // Handle case when no file is picked
    }
  }

}

