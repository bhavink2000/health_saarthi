import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;

import '../../../../App Helper/Backend Helper/Api Future/Cart Future/cart_future.dart';
import '../../../../App Helper/Backend Helper/Api Urls/api_urls.dart';
import '../../../../App Helper/Frontend Helper/Font & Color Helper/font_&_color_helper.dart';
import '../../../../App Helper/Frontend Helper/Loading Helper/loading_helper.dart';

class PackageItemDetails extends StatefulWidget {
  var packageId,accessToken;
  PackageItemDetails({Key? key,this.packageId,this.accessToken}) : super(key: key);

  @override
  State<PackageItemDetails> createState() => _PackageItemDetailsState();
}

class _PackageItemDetailsState extends State<PackageItemDetails> {

  @override
  void initState() {
    super.initState();
    packageById();
  }

  List<dynamic> packageDetailsData = [];
  bool? isLoading;
  Future<void> packageById() async {
    setState(() {
      isLoading = true;
    });
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${widget.accessToken}',
    };
    try {
      final response = await http.get(
        Uri.parse("${ApiUrls.packageItemDetailsUrls}${widget.packageId}"),
        headers: headers,
      ).timeout(const Duration(seconds: 30));
      print('response--->${response.body}');
      print('response--->${response.statusCode}');
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        setState(() {
          packageDetailsData.add(data['data']);
          isLoading = false;
        });
        print("booked status->${packageDetailsData[0]['booked_status']}");
      } else {
        isLoading = false;
        throw Exception("Failed to load data");
      }
    } catch (e) {
      print("e->$e");
      isLoading = false;
      throw Exception("Failed to load data $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
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
                        child: Text(isLoading == false ? "${packageDetailsData[0]['service_code']}" : '',
                          style: const TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),textAlign: TextAlign.right,)
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: isLoading == false ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 10, 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${packageDetailsData[0]['service_name']}",style: const TextStyle(fontFamily: FontType.MontserratMedium,letterSpacing: 0.5,fontSize: 16,fontWeight: FontWeight.bold)),
                          const SizedBox(height: 10),
                          Text("${packageDetailsData[0]['specimen_volume'] == null ? 'N/A': packageDetailsData[0]['specimen_volume']}",style: TextStyle(fontFamily: FontType.MontserratRegular,letterSpacing: 0.5,color: Colors.black87,fontSize: 12),),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 10, 10),
                      child: Row(
                        children: [
                          Text("\u{20B9}${packageDetailsData[0]['mrp']}",style: TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 18,color: hsTestColor)),
                          const Spacer(),
                          InkWell(
                            onTap: (){
                              CartFuture().addToCartTest(widget.accessToken, widget.packageId, context).then((value){
                                setState(() {
                                  packageDetailsData.clear();
                                });
                                packageById();
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: hsTestColor),
                              padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
                              child: Text(packageDetailsData[0]['booked_status'] == 1 ? "Booked": "+ Book Now",style: TextStyle(fontFamily: FontType.MontserratRegular,fontSize: 13,color: Colors.white),),
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
                              "${packageDetailsData[0]['collect'] == null ? 'N/A': packageDetailsData[0]['collect']}",
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
                              "${packageDetailsData[0]['ordering_info'] == null ? 'N/A': packageDetailsData[0]['ordering_info']}",
                              style: const TextStyle(
                                  fontFamily: FontType.MontserratRegular,
                                  letterSpacing: 0.5,fontSize: 14
                              )
                          ),
                          const SizedBox(height: 10),
                          Text("${packageDetailsData[0]['reported'] == null ? 'N/A': packageDetailsData[0]['reported']}",style: TextStyle(fontFamily: FontType.MontserratRegular,letterSpacing: 0.5,color: Colors.black87,fontSize: 12),),
                        ],
                      ),
                    ),
                  ],
                ) : Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height / 2),
                    CenterLoading(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
