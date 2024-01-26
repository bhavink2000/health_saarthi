
import 'package:flutter/material.dart';
import '../../../App Helper/Backend Helper/Get Access Token/get_access_token.dart';
import '../../../App Helper/Frontend Helper/Custom Ui/show_box_helper.dart';
import '../../../App Helper/Frontend Helper/Font & Color Helper/font_&_color_helper.dart';
import '../../Bottom Menus/Home Menu/Home Widgets/attach_prescription.dart';
import '../../Bottom Menus/Home Menu/Home Widgets/instant_booking.dart';
import '../../Bottom Menus/Home Menu/Packages List/package_list.dart';
import '../../Bottom Menus/Home Menu/Test List/test_list_items.dart';

class BookTestScreen extends StatefulWidget {
  const BookTestScreen({Key? key}) : super(key: key);

  @override
  State<BookTestScreen> createState() => _BookTestScreenState();
}

class _BookTestScreenState extends State<BookTestScreen> {

  GetAccessToken getAccessToken = GetAccessToken();

  @override
  void initState() {
    super.initState();
    getAccessToken.checkAuthentication(context, setState);
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
              padding: const EdgeInsets.fromLTRB(10, 5, 20, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back,color: Colors.white,size: 25,),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Text("Book Test",style: TextStyle(fontSize: 16,color: Colors.white,fontFamily: FontType.MontserratMedium,letterSpacing: 1),),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20)),color: Colors.white),
                child: SafeArea(
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      ShowBoxHelper(
                        onTapForTest: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>TestListItems()));
                        },
                        onTapForPackage: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>const PackageListItems()));
                        },
                        onTapForPrescription: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>const AttachPrescription()));
                        },
                        onTapForBooking: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>const InstantBooking()));
                        },
                      ),
                    ],
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
