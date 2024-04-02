// import 'dart:convert';
// import 'dart:developer';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Models/Home%20Menu/test_model.dart';
// import 'package:http/http.dart' as http;
//
// import '../../../Backend Helper/Api Urls/api_urls.dart';
//
// class BottomMenuGetX extends GetxController {
//   var box = GetStorage();
//
//   RxBool testLoading = false.obs;
//   TestModel? testModel;
//   var index = 1;
//   Map? data;
//
//   @override
//   void onInit() async {
//     super.onInit();
//     fetchTest();
//   }
//
//   fetchTest() async {
//     try {
//       testLoading(true);
//       http.Response response =
//           await http.post(Uri.parse("${ApiUrls.testListUrls}?page=$index"),
//               headers: {
//                 'Accept': 'application/json',
//                 'Authorization': 'Bearer ${box.read('accessToken')}',
//               },
//               body: data
//           );
//
//       log("Test Response code-> ${response.statusCode}");
//       log("Test Response -> ${response.body}");
//
//       var responseBody = jsonDecode(response.body);
//       if (response.statusCode == 200) {
//         testModel = TestModel.fromJson(responseBody);
//         testLoading(false);
//         update();
//       } else {}
//     } catch (error) {
//       log("Test catch Error -> $error");
//     }
//   }
// }
