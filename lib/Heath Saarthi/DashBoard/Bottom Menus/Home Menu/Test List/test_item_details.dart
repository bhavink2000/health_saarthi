import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Api%20Urls/api_urls.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/Loading%20Helper/loading_helper.dart';
import 'package:http/http.dart' as http;

import '../../../../App Helper/Backend Helper/Api Future/Cart Future/cart_future.dart';
import '../../../../App Helper/Frontend Helper/Font & Color Helper/font_&_color_helper.dart';

class TestItemDetails extends StatefulWidget {
  var testId,accessToken;
  TestItemDetails({Key? key,this.testId,this.accessToken}) : super(key: key);

  @override
  State<TestItemDetails> createState() => _TestItemDetailsState();
}

class _TestItemDetailsState extends State<TestItemDetails> {

  @override
  void initState() {
    super.initState();
    testById();
  }

  List<dynamic> testDetailsData = [];
  bool? isLoading;
  Future<void> testById() async {
    setState(() {
      isLoading = true;
    });
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${widget.accessToken}',
    };
    try {
      final response = await http.get(
        Uri.parse("${ApiUrls.testItemDetailsUrls}${widget.testId}"),
        headers: headers,
      ).timeout(const Duration(seconds: 30));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        setState(() {
          testDetailsData.add(data['data']);
          isLoading = false;
        });
        print("booked status->${testDetailsData[0]['booked_status']}");
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      print("e->$e");
      throw Exception("Failed to load data $e");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: isLoading == false ? Column(
          children: [
            Container(
              color: hsTestColor,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 10, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,size: 30,color: Colors.white,
                      ),
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width / 1.5,
                        child: Text("${testDetailsData[0]['service_code']}",style: const TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),textAlign: TextAlign.right,))
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 10, 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${testDetailsData[0]['service_name']}",style: const TextStyle(fontFamily: FontType.MontserratMedium,letterSpacing: 0.5,fontSize: 16,fontWeight: FontWeight.bold)),
                          const SizedBox(height: 10),
                          Text("${testDetailsData[0]['specimen_volume'] == null ? 'N/A': testDetailsData[0]['specimen_volume']}",style: TextStyle(fontFamily: FontType.MontserratRegular,letterSpacing: 0.5,color: Colors.black87,fontSize: 12),),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 10, 10),
                      child: Row(
                        children: [
                          Text("\u{20B9}${testDetailsData[0]['mrp']}",style: TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 18,color: hsTestColor)),
                          const Spacer(),
                          InkWell(
                            onTap: (){
                              CartFuture().addToCartTest(widget.accessToken, widget.testId, context).then((value){
                                setState(() {
                                  testDetailsData.clear();
                                });
                                testById();
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: hsTestColor),
                              padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
                              child: Text(testDetailsData[0]['booked_status'] == 1 ? "Booked": "+ Book Now",style: TextStyle(fontFamily: FontType.MontserratRegular,fontSize: 13,color: Colors.white),),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                      child: Container(
                          width: MediaQuery.of(context).size.width / 1.5.w,
                          child: Text(
                              "${testDetailsData[0]['collect'] == null ? 'N/A': testDetailsData[0]['collect']}",
                              style: const TextStyle(
                                fontFamily: FontType.MontserratRegular,
                                letterSpacing: 0.5,fontSize: 14,
                              )
                          )
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 10, 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "${testDetailsData[0]['ordering_info'] == null ? 'N/A': testDetailsData[0]['ordering_info']}",
                              style: const TextStyle(
                                  fontFamily: FontType.MontserratRegular,
                                  letterSpacing: 0.5,fontSize: 14
                              )
                          ),
                          const SizedBox(height: 10),
                          Text("${testDetailsData[0]['reported'] == null ? 'N/A': testDetailsData[0]['reported']}",style: TextStyle(fontFamily: FontType.MontserratRegular,letterSpacing: 0.5,color: Colors.black87,fontSize: 12),),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ) : CenterLoading(),
      ),
    );
  }
}
