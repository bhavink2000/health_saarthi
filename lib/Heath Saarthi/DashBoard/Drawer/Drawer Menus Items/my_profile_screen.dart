
import 'package:health_saarthi/Heath%20Saarthi/DashBoard/Bottom%20Menus/Profile%20Menu/profile_widget.dart';
import 'package:flutter/material.dart';
import '../../../App Helper/Frontend Helper/Font & Color Helper/font_&_color_helper.dart';


class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {

  @override
  void initState(){
    super.initState();
  }
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
                  const Text("Profile",style: TextStyle(fontSize: 16,color: Colors.white,fontFamily: FontType.MontserratMedium,letterSpacing: 1),),
                  //Icon(Icons.circle_notifications_rounded,color: hsColorOne,size: 25,)
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20)),color: Colors.white),
                child: SafeArea(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: ProfileWidgets(),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
