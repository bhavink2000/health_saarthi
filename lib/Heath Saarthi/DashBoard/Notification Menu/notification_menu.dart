// ignore_for_file: missing_return

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Enums/enums_status.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/Loading%20Helper/loading_helper.dart';
import 'package:provider/provider.dart';
import '../../App Helper/Backend Helper/Get Access Token/get_access_token.dart';
import '../../App Helper/Backend Helper/Providers/Home Menu Provider/home_menu_provider.dart';
import '../../App Helper/Frontend Helper/Font & Color Helper/font_&_color_helper.dart';

class NotificationMenu extends StatefulWidget {
  const NotificationMenu({Key? key}) : super(key: key);

  @override
  State<NotificationMenu> createState() => _NotificationMenuState();
}

class _NotificationMenuState extends State<NotificationMenu> {

  //GetAccessToken getAccessToken = GetAccessToken();
  HomeMenusProvider homeMenusProvider = HomeMenusProvider();
  int curentindex = 0;
  @override
  void initState() {
    super.initState();
    //getAccessToken.checkAuthentication(context, setState);
    Future.delayed(const Duration(seconds: 2),(){
      setState(() {
        homeMenusProvider.fetchNotification();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                  Text("Notification",style: TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 16.sp,letterSpacing: 0.5),)
                ],
              ),
            ),
            const Divider(color: Colors.grey,thickness: 1),
            Expanded(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ChangeNotifierProvider<HomeMenusProvider>(
                  create: (BuildContext context) => homeMenusProvider,
                  child: Consumer<HomeMenusProvider>(
                    builder: (context, value, __){
                      switch(value.notificationist.status!){
                        case Status.loading:
                          return const CenterLoading();
                        case Status.error:
                          return const CenterLoading();
                        case Status.completed:
                          return value.notificationist.data!.data!.isEmpty ? const Center(child: Text("Notification is not available"),) : AnimationLimiter(
                            child: ListView.builder(
                              itemCount: value.notificationist.data!.data!.length,
                              itemBuilder: (context, index){
                                var notiFi = value.notificationist.data!.data![index];
                                return Padding(
                                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  child: Card(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius: const BorderRadius.only(
                                                      topLeft: Radius.circular(10),topRight: Radius.circular(10),
                                                    ),
                                                    color: hsPrime
                                                  ),
                                                  //width: MediaQuery.of(context).size.width.w,
                                                  child: Padding(
                                                    padding: const EdgeInsets.fromLTRB(10, 8, 0, 8),
                                                    child: Text(
                                                      '${notiFi.title}',
                                                      style: const TextStyle(
                                                          fontFamily: FontType.MontserratRegular,color: Colors.white,
                                                          fontSize: 14,fontWeight: FontWeight.bold
                                                      )
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                                            child: Text(
                                              '${notiFi.message == null ? 'N/A': notiFi.message}',
                                              style: const TextStyle(fontFamily: FontType.MontserratRegular,fontSize: 12),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              const Spacer(),
                                              Container(
                                                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                                decoration: BoxDecoration(borderRadius: const BorderRadius.only(
                                                    bottomLeft: Radius.circular(0),
                                                    topLeft: Radius.circular(10),
                                                    bottomRight: Radius.circular(10)
                                                ),color: hsPrimeOne),
                                                child: Text(
                                                  '${notiFi.createAt}',
                                                  style: const TextStyle(fontFamily: FontType.MontserratRegular,color: Colors.white,fontSize: 12),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
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
