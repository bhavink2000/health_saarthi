import 'dart:io';

import 'package:flutter/material.dart';
import 'package:multiple_image_camera/camera_file.dart';
import 'package:multiple_image_camera/multiple_image_camera.dart';

import '../../App Helper/Frontend Helper/File Picker/file_image_picker.dart';
import '../../App Helper/Frontend Helper/Font & Color Helper/font_&_color_helper.dart';

class MultipleCameraPic extends StatefulWidget {
  const MultipleCameraPic({super.key});

  @override
  State<MultipleCameraPic> createState() => _MultipleCameraPicState();
}

class _MultipleCameraPicState extends State<MultipleCameraPic> {

  List<MediaModel> images = [];
  List<File> prescriptionFiles = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Multiple camera'),
      ),
      body: Column(
        children: [

          Padding(
            padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Text(
                            "Upload prescription",
                            style: TextStyle(fontFamily: FontType.MontserratMedium),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () async {
                              var prescriptionFileManager = await FileImagePicker().pickPrescription();
                              setState(() {
                                prescriptionFiles.addAll(prescriptionFileManager!);
                              });
                            },
                            icon: const Icon(
                              Icons.file_copy_rounded,
                              color: Colors.black,
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              MultipleImageCamera.capture(context: context).then((value) {
                                setState(() {
                                  prescriptionFiles = value.map((media) {
                                    return media.file;
                                  }).toList();

                                  //prescriptionFiles.addAll(value.map((media){return media.file;}).toList());
                                });
                              });

                            },
                            icon: const Icon(
                              Icons.camera_alt_rounded,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 20,
                        child: prescriptionFiles.isNotEmpty
                          ? ListView.builder(
                          itemCount: prescriptionFiles.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index){
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
                              child: Container(
                                // margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                decoration: BoxDecoration(
                                    color: hsPrime,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                child: GestureDetector(
                                  onTap: (){
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context){
                                          return Dialog(
                                            child: Image.file(prescriptionFiles[index]),
                                          );
                                        }
                                    );
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                          prescriptionFiles[index].path.split('/').last,
                                          style: const TextStyle(fontFamily: FontType.MontserratLight,color: Colors.white)
                                      ),
                                      const SizedBox(width: 10),
                                      IconButton(
                                          onPressed: (){
                                            setState(() {
                                              prescriptionFiles.remove(prescriptionFiles[index]);
                                            });
                                          },
                                          icon: const Icon(Icons.delete_rounded,color: Colors.white,)
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ) ;
                          },
                        )
                          : const Center(child: Text('No file chosen'),),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
