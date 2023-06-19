//@dart=2.9

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:search_choices/search_choices.dart';
import '../../App Helper/Frontend Helper/Font & Color Helper/font_&_color_helper.dart';
import 'test_cart.dart';

class TestPatientForm extends StatefulWidget {

  const TestPatientForm({Key key}) : super(key: key);

  @override
  State<TestPatientForm> createState() => _TestPatientFormState();
}

class _TestPatientFormState extends State<TestPatientForm> {

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  String selectedGender;
 // final pMobile = TextEditingController();
  final pAge = TextEditingController();
  final pDob = TextEditingController();
  final pName = TextEditingController();
  String selectedFamilyMember;
  List<String> familyMembers = [
    'Mother',
    'Father',
    'Brother',
    'Sister',
    'Grandmother',
    'Grandfather',
  ];
  String selectedHospital;
  List<String> hospitalName = [
    'Pristyn',
    'Sterling',
    'Apollo',
    'SAL',
    'Shelby',
    'Zydus',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 10, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.arrow_back,size: 30,)
                  ),
                  Text("Patient Details",style: TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 18.sp,letterSpacing: 0.5),)
                ],
              ),
            ),
            Divider(color: hsTwo,thickness: 1),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Card(
                elevation: 5,
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Container(
                  height: MediaQuery.of(context).size.height / 12.h,
                  decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(10))),
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
                  child: SearchChoices.single(
                    dropDownDialogPadding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    items: hospitalName.map((member) {
                      return DropdownMenuItem<String>(
                        value: member,
                        child: Text(member),
                      );
                    }).toList(),
                    value: selectedHospital,
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    style: const TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 15,letterSpacing: 1,color: Colors.black87),
                    hint: "Select One",
                    searchHint: "Select Hospitals",
                    onChanged: (value) {
                      setState(() {
                        selectedHospital = value;
                      });
                    },
                    isExpanded: true,
                  ),
                ),
              ),
            ),
            showTextField('Patient Name', pName,Icons.person),
            showTextField('Patient Age', pAge,Icons.view_agenda),
            showTextField('DOB', pAge,Icons.calendar_month_rounded),
            Row(
              children: [
                Flexible(
                  child: RadioListTile(
                    contentPadding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
                    title: const Text('Female',style: TextStyle(fontFamily: FontType.MontserratRegular)),
                    value: 'Female',
                    groupValue: selectedGender,
                    onChanged: (value) {
                      setState(() {
                        selectedGender = value;
                      });
                    },
                  ),
                ),
                Flexible(
                  child: RadioListTile(
                    contentPadding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
                    title: const Text('Male',style: TextStyle(fontFamily: FontType.MontserratRegular)),
                    value: 'Male',
                    groupValue: selectedGender,
                    onChanged: (value) {
                      setState(() {
                        selectedGender = value;
                      });
                    },
                  ),
                ),
                Flexible(
                  child: RadioListTile(
                    contentPadding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
                    title: const Text('Other',style: TextStyle(fontFamily: FontType.MontserratRegular),),
                    value: 'Other',
                    groupValue: selectedGender,
                    onChanged: (value) {
                      setState(() {
                        setState((){
                          selectedGender = value;
                        });
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  child: InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: hsOne),
                      padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                      child: const Text('Cancel',style: TextStyle(fontFamily: FontType.MontserratMedium,color: Colors.white),),
                    ),
                  ),
                ),
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  child: InkWell(
                    onTap: (){
                      FamilyMember newMember = FamilyMember(name: pName.text);
                      Navigator.pop(context, newMember);
                    },
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: hsOne),
                      padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                      child: const Text('Save',style: TextStyle(fontFamily: FontType.MontserratMedium,color: Colors.white),),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  Widget showTextField(var lebal, TextEditingController controller, IconData iconData){
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(hsPaddingM),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
              borderRadius: BorderRadius.circular(15)
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
              borderRadius: BorderRadius.circular(15)
          ),
          hintText: '$lebal',
          hintStyle: const TextStyle(
              color: Colors.black54,
              fontFamily: FontType.MontserratRegular,
              fontSize: 14
          ),
          prefixIcon: Icon(iconData, color: hsBlack,size: 20),
        ),
      ),
    );
  }
}
