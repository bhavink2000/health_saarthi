//@dart=2.9
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../../../../App Helper/Backend Helper/Api Urls/api_urls.dart';
import '../../../../App Helper/Backend Helper/Get Access Token/get_access_token.dart';
import '../../../../App Helper/Frontend Helper/Font & Color Helper/font_&_color_helper.dart';
import '../../../../App Helper/Frontend Helper/Snack Bar Msg/snackbar_msg_show.dart';
import '../../../hs_dashboard.dart';

class ReferChemist extends StatefulWidget {
  const ReferChemist({Key key}) : super(key: key);

  @override
  State<ReferChemist> createState() => _ReferChemistState();
}

class _ReferChemistState extends State<ReferChemist> {

  final fName = TextEditingController();
  final mobile = TextEditingController();
  final email = TextEditingController();

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
      resizeToAvoidBottomInset: false,
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
                  const Text("Refer Chemist",style: TextStyle(fontSize: 16,color: Colors.white,fontFamily: FontType.MontserratMedium,letterSpacing: 1),),
                  //Icon(Icons.circle_notifications_rounded,color: hsColorOne,size: 25,)
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20)),color: Colors.white),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                        child: Container(
                          height: MediaQuery.of(context).size.height / 18,
                          child: TextField(
                            controller: fName,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'First Name',
                                prefixIcon: Icon(Icons.person,color: Colors.black,size: 24)
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                        child: Container(
                          height: MediaQuery.of(context).size.height / 18,
                          child: TextField(
                            controller: mobile,
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Mobile Number',
                                prefixIcon: Icon(Icons.phone_android_rounded,color: Colors.black,size: 24)
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                        child: Container(
                          height: MediaQuery.of(context).size.height / 18,
                          child: TextField(
                            controller: email,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Email Id',
                                prefixIcon: Icon(Icons.email_rounded,color: Colors.black,size: 24)
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: (){
                              fName.clear();
                              mobile.clear();
                              email.clear();
                              Navigator.pop(context);
                            },
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: hsPrime),
                              child: const Text("Cancel",style: TextStyle(fontFamily: FontType.MontserratMedium,color: Colors.white),),
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              if(fName.text.isEmpty || mobile.text.isEmpty || email.text.isEmpty){
                                SnackBarMessageShow.warningMSG('Please Fill All Field', context);
                              }
                              else{
                                sendReferralPharmacy();
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: hsPrime),
                              child: const Text("Submit",style: TextStyle(fontFamily: FontType.MontserratMedium,color: Colors.white),),
                            ),
                          ),
                        ],
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

  void sendReferralPharmacy() async {
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${getAccessToken.access_token}',
    };

    await http.post(
        Uri.parse(ApiUrls.referralPharmacyUrls),
        headers: headers,
        body: {
          'name': fName?.text ?? '',
          'mobile_no': mobile?.text ?? '',
          'email_id': email?.text ?? '',
        }
    ).then((response) {
      print(response.body);
      if(response.statusCode == 200){
        var data = json.decode(response.body);
        var msg = data['message'];
        if (data['status'] == 200) {
          SnackBarMessageShow.successsMSG("$msg", context);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));
        }
      }
      else{
        if(response.statusCode == 400){
          var data = json.decode(response.body);
          var errorMsg = data['error']['email_id'][0];
          if (data['status'] == 400) {
            SnackBarMessageShow.errorMSG("$errorMsg", context);
          }
        }
      }
    });
  }
}
