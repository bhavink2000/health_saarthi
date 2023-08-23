//@dart=2.9
// ignore_for_file: missing_return

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Models/Drawer%20Menu/faqs_model.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/Font%20&%20Color%20Helper/font_&_color_helper.dart';
import 'package:provider/provider.dart';

import '../../../../App Helper/Backend Helper/Api Urls/api_urls.dart';
import '../../../../App Helper/Backend Helper/Enums/enums_status.dart';
import '../../../../App Helper/Backend Helper/Get Access Token/get_access_token.dart';
import '../../../../App Helper/Backend Helper/Providers/Home Menu Provider/home_menu_provider.dart';
import '../../../../App Helper/Frontend Helper/Loading Helper/loading_helper.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({Key key}) : super(key: key);

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {

  GetAccessToken getAccessToken = GetAccessToken();
  HomeMenusProvider homeMenusProvider = HomeMenusProvider();
  @override
  void initState() {
    super.initState();
    getAccessToken.checkAuthentication(context, setState);
    Future.delayed(const Duration(seconds: 1),(){
      setState(() {
        homeMenusProvider.fetchFaqs(getAccessToken.access_token);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 20, 0),
              child: IconButton(
                icon: const Icon(Icons.arrow_back,color: Colors.black,size: 25,),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: Text("FAQ",style: TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 25,color: hsPrime),)
            ),
            SizedBox(height: 10.h),
            Expanded(
              child: Container(
                child: ChangeNotifierProvider<HomeMenusProvider>(
                  create: (BuildContext context)=> homeMenusProvider,
                  child: Consumer<HomeMenusProvider>(
                    builder: (context, value, __){
                      switch(value.faqsList.status){
                        case Status.loading:
                          return const CenterLoading();
                        case Status.error:
                          return value.faqsList.data == null ? const Center(child: Text('No faq data',style: TextStyle(fontFamily: FontType.MontserratMedium),)) : Center(child: Text(value.faqsList.message));
                        case Status.completed:
                          return value.faqsList.data.data.isNotEmpty ? ListView.builder(
                            itemCount: value.faqsList.data.data.length,
                            itemBuilder: (context, index){
                              var faqs = value.faqsList.data.data[index];
                              return ExpansionTile(
                                collapsedTextColor: hsPrime,
                                tilePadding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                backgroundColor: hsPrime.withOpacity(0.1),
                                title: Text(faqs.question,style: TextStyle(fontFamily: FontType.MontserratMedium,color: hsPrime),),
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 5),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        faqs.answer,
                                        style: const TextStyle(
                                          fontFamily: FontType.MontserratLight,color: Colors.black,fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ) : const Center(child: Text('No data'),);
                      }
                    },
                  ),
                )
              ),
            )
          ],
        ),
      ),
    );
  }

}
