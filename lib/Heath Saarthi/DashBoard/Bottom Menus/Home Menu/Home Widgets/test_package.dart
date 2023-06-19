//@dart=2.9
import 'dart:io';
import 'dart:ui';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../App Helper/Frontend Helper/Font & Color Helper/font_&_color_helper.dart';
import '../../../Add To Cart/test_form_booking.dart';
import '../Packages List/package_list.dart';
import '../Test List/test_list_items.dart';
import 'attach_prescription.dart';
import 'instant_booking.dart';

class HomeTestPackage extends StatefulWidget {
  const HomeTestPackage({Key key}) : super(key: key);

  @override
  State<HomeTestPackage> createState() => _HomeTestPackageState();
}

class _HomeTestPackageState extends State<HomeTestPackage> {
  File fileManger;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width.w,
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 10, 0, 10),
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>TestListItems()));
                  },
                  child: Card(
                    elevation: 5,
                    shadowColor: Color(0xff396fff).withOpacity(0.3),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2.3.w,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(width: 10),
                                  const Image(image: AssetImage("assets/Home/test.png"),width: 30),
                                  const SizedBox(width: 10),
                                  Text("Lab Test",style: TextStyle(fontSize: 13.sp,color: Colors.black,fontFamily: FontType.MontserratMedium,)),
                                  SizedBox(width: 1.w),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 3, 0, 0),
                                    child: Icon(Icons.arrow_forward_ios_rounded,size: 10),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                            child: Container(
                              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Color(0xff396fff).withOpacity(0.1)
                              ),
                              child: Row(
                                children: [
                                  Image(image: AssetImage("assets/Home/test_sub.png"),width: 12),
                                  SizedBox(width: 10.w,),
                                  Text("View Test",style: TextStyle(fontFamily: FontType.MontserratRegular,fontSize: 10),)
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 5, 10),
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const PackageListItems()));
                  },
                  child: Card(
                    elevation: 5,
                    shadowColor: Color(0xffe2791b).withOpacity(0.3),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2.3.w,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                            child: Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(width: 10),
                                  const Image(image: AssetImage("assets/Home/package.png"),width: 30),
                                  const SizedBox(width: 10),
                                  Text("Package",style: TextStyle(fontSize: 13.sp,color: Colors.black,fontFamily: FontType.MontserratMedium,)),
                                  SizedBox(width: 1.w),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 3, 0, 0),
                                    child: Icon(Icons.arrow_forward_ios_rounded,size: 10),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                            child: Container(
                              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Color(0xffe2791b).withOpacity(0.1)
                              ),
                              child: Row(
                                children: [
                                  Image(image: AssetImage("assets/Home/package_sub.png"),width: 12),
                                  SizedBox(width: 10.w,),
                                  Text("View Package",style: TextStyle(fontFamily: FontType.MontserratRegular,fontSize: 10),)
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 5, 0, 10),
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>AttachPrescription()));
                    //_showFilePick(context);
                  },
                  child: Card(
                    elevation: 5,
                    shadowColor: Color(0xff4aa4f5).withOpacity(0.3),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2.3.w,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(width: 10),
                                  const Image(image: AssetImage("assets/Home/prescription.png"),width: 30),
                                  const SizedBox(width: 10),
                                  Text("Prescription",style: TextStyle(fontSize: 13.sp,color: Colors.black,fontFamily: FontType.MontserratMedium,)),
                                  SizedBox(width: 1.w),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 3, 0, 0),
                                    child: Icon(Icons.arrow_forward_ios_rounded,size: 10),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                            child: Container(
                              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Color(0xff4aa4f5).withOpacity(0.1)
                              ),
                              child: Row(
                                children: [
                                  Image(image: AssetImage("assets/Home/prescription_sub.png"),width: 12),
                                  SizedBox(width: 10.w,),
                                  Text("Attach File",style: TextStyle(fontFamily: FontType.MontserratRegular,fontSize: 10),)
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 5, 10),
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>InstantBooking()));
                  },
                  child: Card(
                    elevation: 5,
                    shadowColor: Color(0xff002860).withOpacity(0.3),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2.3.w,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(width: 10),
                                  const Image(image: AssetImage("assets/Home/booking.png"),width: 30),
                                  SizedBox(width: 10.w),
                                  Text("Instant Book",style: TextStyle(fontSize: 13.sp,color: Colors.black,fontFamily: FontType.MontserratMedium,)),
                                  SizedBox(width: 1.w),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 3, 0, 0),
                                    child: Icon(Icons.arrow_forward_ios_rounded,size: 10),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                            child: Container(
                              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Color(0xff002860).withOpacity(0.1)
                              ),
                              child: Row(
                                children: [
                                  Image(image: AssetImage("assets/Home/booking_sub.png"),width: 12),
                                  SizedBox(width: 10.w,),
                                  Text("Book Now!",style: TextStyle(fontFamily: FontType.MontserratRegular,fontSize: 10),)
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  _showFilePick(BuildContext context){
    return showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25.0),),),
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState){
              return BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 3,
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
                          child: Text("Attach File",style: TextStyle(fontFamily: FontType.MontserratMedium,color: hsOne,fontSize: 20),),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                              color: hsTwo,
                              child: InkWell(
                                onTap: () async {
                                  fileOpen(context,setState);
                                },
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width / 2.5,
                                  height: MediaQuery.of(context).size.height / 8,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(Icons.file_copy_rounded,color: Colors.white,size: 30,),
                                      SizedBox(height: 10),
                                      Text("File Manger",style: TextStyle(fontFamily: FontType.MontserratRegular,color: Colors.white),)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                              color: hsTwo,
                              child: InkWell(
                                onTap: ()async{
                                  cameraOpen(context,setState);
                                },
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width / 2.5,
                                  height: MediaQuery.of(context).size.height / 8,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(Icons.camera_alt_rounded,color: Colors.white,size: 30,),
                                      SizedBox(height: 10),
                                      Text("Camera",style: TextStyle(fontFamily: FontType.MontserratRegular,color: Colors.white),)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                          child: Expanded(
                            child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: fileManger == null ? const Text("No File Chosen",style: TextStyle(fontSize: 12),) : Text(fileManger.path.split('/').last,style: const TextStyle(fontSize: 9),)
                            ),
                          ),
                        )
                      ],
                    ),
                  )
              );
            },
          );
        }
    );
  }

  void fileOpen(BuildContext context,setState)async{
    try {
      final pickedFile = await FilePicker.platform.pickFiles(type: FileType.any);
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
        return;
      }
      final file = File(pickedFile.files.single.path);
      setState(() {
        fileManger = file;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: hsOne,
          content: Text('Selected file: ${file.path}', style: const TextStyle(fontFamily: FontType.MontserratRegular, color: Colors.white)),
        ),
      );
    } on PlatformException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: hsOne,
        content: Text('Failed to pick file: ${e.message}', style: const TextStyle(fontFamily: FontType.MontserratRegular, color: Colors.white),),
      ),);
      print("platForm-> $e");
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: hsOne,
          content: Text('Unknown error: $e', style: const TextStyle(fontFamily: FontType.MontserratRegular, color: Colors.white),),
        ),
      );
      print("error -> $e");
    }
  }
  void cameraOpen(BuildContext context,setState)async{
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
        return;
      }
      final file = File(pickedFile.path);
      setState(() {
        fileManger = file;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: hsOne,
          content: Text('Selected file: ${file.path}', style: const TextStyle(fontFamily: FontType.MontserratRegular, color: Colors.white)),
        ),
      );
    } on PlatformException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: hsOne,
        content: Text('Failed to pick file: ${e.message}', style: const TextStyle(fontFamily: FontType.MontserratRegular, color: Colors.white),),
      ),);
      print("platForm-> $e");
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: hsOne,
          content: Text('Unknown error: $e', style: const TextStyle(fontFamily: FontType.MontserratRegular, color: Colors.white),),
        ),
      );
      print("error -> $e");
    }
  }
}
