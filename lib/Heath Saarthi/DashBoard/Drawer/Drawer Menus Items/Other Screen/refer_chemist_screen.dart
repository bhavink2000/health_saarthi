import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/Snack%20Bar%20Msg/getx_snackbar_msg.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../../../../App Helper/Backend Helper/Api Urls/api_urls.dart';
import '../../../../App Helper/Backend Helper/Get Access Token/get_access_token.dart';
import '../../../../App Helper/Frontend Helper/Font & Color Helper/font_&_color_helper.dart';
import '../../../hs_dashboard.dart';

class ReferChemist extends StatefulWidget {
  const ReferChemist({Key? key}) : super(key: key);

  @override
  State<ReferChemist> createState() => _ReferChemistState();
}

class _ReferChemistState extends State<ReferChemist> {

  final fName = TextEditingController();
  final mobile = TextEditingController();
  final email = TextEditingController();

  final box = GetStorage();

  //GetAccessToken getAccessToken = GetAccessToken();
  @override
  void initState() {
    super.initState();
    //getAccessToken.checkAuthentication(context, setState);
  }
  final _referFormKey = GlobalKey<FormState>();
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
                  child: Form(
                    key: _referFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                          child: Container(
                            //height: MediaQuery.of(context).size.height / 18,
                            child: TextFormField(
                              controller: fName,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'First name',
                                  prefixIcon: Icon(Icons.person,color: Colors.black,size: 24)
                              ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Enter name';
                                  }
                                  return null;
                                }
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                          child: Container(
                            //height: MediaQuery.of(context).size.height / 18,
                            child: TextFormField(
                              controller: mobile,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              keyboardType: TextInputType.phone,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Mobile number',
                                  prefixIcon: Icon(Icons.phone_android_rounded,color: Colors.black,size: 24)
                              ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Enter mobile number';
                                  }
                                  return null;
                                }
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                          child: Container(
                            //height: MediaQuery.of(context).size.height / 18,
                            child: TextFormField(
                              controller: email,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Email id',
                                  prefixIcon: Icon(Icons.email_rounded,color: Colors.black,size: 24)
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter email id';
                                }
                                if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                                  return 'email id must contain at least one special character';
                                }
                                return null;
                              },
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
                                if(_referFormKey.currentState!.validate()){
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
      'Authorization': 'Bearer ${box.read('accessToken')}',
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
          GetXSnackBarMsg.getSuccessMsg('$msg');
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));
        }
      }
      else{
        if(response.statusCode == 400){
          var data = json.decode(response.body);
          var errorMsg = data['error']['email_id'][0];
          if (data['status'] == 400) {
            GetXSnackBarMsg.getWarningMsg('$errorMsg');
          }
        }
      }
    });
  }
}
