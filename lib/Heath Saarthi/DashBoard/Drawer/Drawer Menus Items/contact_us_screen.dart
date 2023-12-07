import 'dart:convert';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Api%20Urls/api_urls.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/Loading%20Helper/loading_helper.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../App Helper/Backend Helper/Get Access Token/get_access_token.dart';
import '../../../App Helper/Frontend Helper/Font & Color Helper/font_&_color_helper.dart';


class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {

  var salesPersonNM,superiorNM,customerCareNm,otherNM;
  var salesPersonNo,superiorNo,customerCareNo,otherNo;


  GetAccessToken getAccessToken = GetAccessToken();
  @override
  void initState() {
    super.initState();
    getAccessToken.checkAuthentication(context, setState);
    Future.delayed(const Duration(seconds: 1),(){
      fetchContact();
    });
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
                  const Text("Contact Us",style: TextStyle(fontSize: 16,color: Colors.white,fontFamily: FontType.MontserratMedium,letterSpacing: 1),),
                  //Icon(Icons.circle_notifications_rounded,color: hsColorOne,size: 25,)
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20)),color: Colors.white),
                child: SafeArea(
                  child: isLoading == true ? Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                        child: Container(
                          color: Colors.white,
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                child: InkWell(
                                  onTap: ()=>launch("tel://$salesPersonNo"),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width / 1.5,
                                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("${salesPersonNM == '' ? 'N/A' : salesPersonNM}",style: TextStyle(fontFamily: FontType.MontserratMedium,color: hsPrime,fontSize: 16,letterSpacing: 0.5),),
                                        const SizedBox(height: 5,),
                                        Text("${salesPersonNo == '' ? 'N/A' : salesPersonNo}",style: TextStyle(fontFamily: FontType.MontserratRegular,color: hsPrime,fontSize: 14,letterSpacing: 0.5)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              CircleAvatar(
                                radius: 20,backgroundColor: hsPrimeOne,child: const Icon(Icons.call,color: Colors.white,),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                        child: Container(
                          color: Colors.white,
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                child: InkWell(
                                  onTap: ()=>launch("tel://$superiorNo"),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width / 1.5,
                                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("${superiorNM == null ? 'N/A' : superiorNM}",style: TextStyle(fontFamily: FontType.MontserratMedium,color: hsPrime,fontSize: 16,letterSpacing: 0.5),),
                                        const SizedBox(height: 5,),
                                        Text("${superiorNo == null ? 'N/A' : superiorNo}",style: TextStyle(fontFamily: FontType.MontserratRegular,color: hsPrime,fontSize: 14,letterSpacing: 0.5)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              CircleAvatar(
                                radius: 20,backgroundColor: hsPrimeOne,child: const Icon(Icons.call,color: Colors.white,),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                        child: Container(
                          color: Colors.white,
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                child: InkWell(
                                  onTap: ()=>launch("tel://$customerCareNo"),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width / 1.5,
                                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("${customerCareNm == null ? 'N/A' : customerCareNm}",style: TextStyle(fontFamily: FontType.MontserratMedium,color: hsPrime,fontSize: 16,letterSpacing: 0.5),),
                                        const SizedBox(height: 5,),
                                        Text("${customerCareNo == null ? 'N/A' : customerCareNo}",style: TextStyle(fontFamily: FontType.MontserratRegular,color: hsPrime,fontSize: 14,letterSpacing: 0.5)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              CircleAvatar(
                                radius: 20,backgroundColor: hsPrimeOne,child: const Icon(Icons.call,color: Colors.white,),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ) : CenterLoading(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  bool? isLoading;
  void fetchContact() async {
    setState(() {
      isLoading = false;
    });
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${getAccessToken.access_token}',
    };
    final response = await http.get(
        headers: headers,
        Uri.parse(ApiUrls.contactUsUrls)
    );
    print("response-$response");
    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'];
      print("data->$data");
      setState(() {
        salesPersonNM = data['name'];
        salesPersonNo = data['mobile_no'];
        superiorNM = data['name_two'];
        superiorNo = data['mobile_no_two'];
        customerCareNm = data['name_three'];
        customerCareNo = data['mobile_no_three'];
        otherNM = data['name_other'];
        otherNo = data['mobile_no_other'];
        isLoading = true;
      });
      final id = data['id'];
      final status = data['status'];
      final encId = data['enc_id'];
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  }
}
