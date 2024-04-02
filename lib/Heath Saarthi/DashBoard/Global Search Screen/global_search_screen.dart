import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/Font%20&%20Color%20Helper/font_&_color_helper.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/Snack%20Bar%20Msg/getx_snackbar_msg.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/Text%20Helper/test_helper.dart';
import 'package:health_saarthi/Heath%20Saarthi/DashBoard/Bottom%20Menus/Home%20Menu/Packages%20List/package_item_details.dart';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Api%20Urls/api_urls.dart';

import '../Bottom Menus/Home Menu/Test List/test_item_details.dart';

class GlobalSearch extends SearchDelegate{
  GlobalSearch({Key? key});

  final box = GetStorage();

  var jsonData;
  int curentindex = 0;
  Future<List<dynamic>?> getGlobalData(var index) async {

    final url = Uri.parse(ApiUrls.globalSearchUrls);
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${box.read('accessToken')}',
    };
    final body = {'search': query};
    final response = await http.post(url, headers: headers, body: body);
    var jsonResponse = json.decode(response.body);
    var bodyStatus = jsonResponse['status'];

    if(bodyStatus == 400){
      var bodyMsg = jsonResponse['massage'];
      GetXSnackBarMsg.getWarningMsg('$bodyMsg');
    }
    else{
      if (response.statusCode == 200) {
        jsonData = jsonDecode(response.body) as Map<String, dynamic>;
        final itemList = jsonData['data']['data'] as List<dynamic>;
        return itemList;
      }
      else {
        throw Exception('Failed to load items');
      }
    }
  }

  @override
  Widget buildLeading(BuildContext context) => IconButton(
    icon: const Icon(Icons.arrow_back),
    onPressed: (){
      close(context, null);
    },
  );

  @override
  List<Widget> buildActions(BuildContext context) => [
    IconButton(
      icon: const Icon(Icons.clear),
      onPressed: (){
        if(query.isEmpty) {
          close(context, null);
        }
        else{
          query = '';
        }
      },
    ),
  ];

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<dynamic>?>(
      future: getGlobalData(curentindex + 1),
      builder: (BuildContext? context, AsyncSnapshot<List<dynamic>?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator(color: hsPrime));
        } else if (snapshot.hasError) {
          final error = snapshot.error;
          return Center(child: Text('Error: $error'));
        } else if (snapshot.hasData && snapshot.data != null) {
          final items = snapshot.data;
          return ListView.builder(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            itemCount: items!.length,
            itemBuilder: (BuildContext context, int index) {
              final item = items[index];
              return Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  shadowColor: Colors.grey.withOpacity(0.5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width.w,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),topRight: Radius.circular(10)
                          ),
                          color: item['is_package'] == 1 ? hsPrime.withOpacity(0.5) : hsPrime.withOpacity(0.5),
                        ),
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: Text(
                            "${item['service_name']}",
                            style: TextStyle(
                                fontFamily: FontType.MontserratMedium,
                                fontSize: 15.sp,color: Colors.white
                            )
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //Divider(color: hsOne,thickness: 1),
                            Container(
                                width: MediaQuery.of(context).size.width / 1.5.w,
                                child: Text("${item['specimen_volume']}",style: TextStyle(fontFamily: FontType.MontserratRegular,letterSpacing: 0.5,color: Colors.black87,fontSize: 12.sp),)),
                            Row(
                              children: [
                                Text("\u{20B9}${item['mrp_amount']}",style: TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 18.sp,color: hsBlack)),
                                const Spacer(),
                                InkWell(
                                  onTap: (){
                                    if(item['is_package'] == 1){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>PackageItemDetails(
                                        packageId: item['id'],
                                      )));
                                    }
                                    else{
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>TestItemDetails(
                                        testId: item['id'],
                                      )));
                                    }
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
                                        color: item['is_package'] == 1 ? hsPrime : hsPrime
                                    ),
                                    padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
                                    child: Text("+ Know More",style: TextStyle(fontFamily: FontType.MontserratRegular,fontSize: 13.sp,color: Colors.white)),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        }
        else {
          return Center(child: Text('No data available',style: TextStyle(fontFamily: FontType.MontserratMedium,fontWeight: FontWeight.bold),));
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }

}