//@dart=2.9
import 'dart:io';
import 'dart:ui';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import '../../../App Helper/Frontend Helper/Font & Color Helper/font_&_color_helper.dart';
import '../../Bottom Menus/Home Menu/Packages List/package_list.dart';
import '../../Bottom Menus/Home Menu/Test List/test_list_items.dart';
import '../../Add To Cart/test_form_booking.dart';

class BookTestScreen extends StatefulWidget {
  const BookTestScreen({Key key}) : super(key: key);

  @override
  State<BookTestScreen> createState() => _BookTestScreenState();
}

class _BookTestScreenState extends State<BookTestScreen> {
  File fileManger;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: hsPrimeOne,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 20, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back,color: Colors.white,size: 25,),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Text("Book Test",style: TextStyle(fontSize: 20,color: Colors.white,fontFamily: FontType.MontserratMedium,letterSpacing: 1),),
                  //Icon(Icons.circle_notifications_rounded,color: hsColorOne,size: 25,)
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20)),color: Colors.white),
                child: SafeArea(
                  child: Container(
                    width: MediaQuery.of(context).size.width.w,
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>TestListItems()));
                                },
                                child: Card(
                                  elevation: 8,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width / 2.5.w,
                                    height: MediaQuery.of(context).size.height / 8.h,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: hsPrime),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                      child: Container(
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            const Image(image: NetworkImage("https://cdn-icons-png.flaticon.com/512/291/291464.png"),width: 50,),
                                            const SizedBox(height: 10),
                                            Text("Tests",style: TextStyle(fontSize: 14.sp,color: hsPrime,fontFamily: FontType.MontserratMedium,))
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>PackageListItems()));
                                },
                                child: Card(
                                  elevation: 8,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width / 2.5.w,
                                    height: MediaQuery.of(context).size.height / 8.h,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: hsPrimeOne),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                      child: Container(
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            const Image(image: NetworkImage("https://cdn-icons-png.flaticon.com/512/3659/3659032.png"),width: 50),
                                            const SizedBox(height: 10),
                                            Text("Package",style: TextStyle(fontSize: 14.sp,color: hsPrimeOne,fontFamily: FontType.MontserratMedium,))
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: (){
                                  _showFilePick(context);
                                },
                                child: Card(
                                  elevation: 8,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width / 2.5.w,
                                    height: MediaQuery.of(context).size.height / 8.h,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: hsPrimeOne),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                      child: Container(
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            const Image(image: NetworkImage("https://cdn-icons-png.flaticon.com/512/3022/3022387.png"),width: 50),
                                            const SizedBox(height: 10),
                                            Text("Prescription",style: TextStyle(fontSize: 14.sp,color: hsPrimeOne,fontFamily: FontType.MontserratMedium,))
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>TestBookingScreen()));
                                },
                                child: Card(
                                  elevation: 8,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width / 2.5.w,
                                    height: MediaQuery.of(context).size.height / 8.h,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: hsPrime),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                      child: Container(
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.book_rounded,size: 50,color: hsPrimeOne),
                                            const SizedBox(height: 10),
                                            Text("Instant Book",style: TextStyle(fontSize: 14.sp,color: hsPrime,fontFamily: FontType.MontserratMedium,))
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
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
                                  fileOpen(context, setState);
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
                                  cameraOpen(context, setState);
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
