// ignore_for_file: missing_return

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Api%20Future/Data%20Future/home_data_future.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Enums/enums_status.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/Loading%20Helper/loading_helper.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/UI%20Helper/app_icons_helper.dart';
import 'package:health_saarthi/Heath%20Saarthi/DashBoard/Bottom%20Menus/Home%20Menu/Home%20Widgets/Today%20Deal/today_deal_details.dart';
import 'package:provider/provider.dart';
import '../../../../../App Helper/Backend Helper/Get Access Token/get_access_token.dart';
import '../../../../../App Helper/Backend Helper/Providers/Home Menu Provider/home_menu_provider.dart';
import '../../../../../App Helper/Frontend Helper/Font & Color Helper/font_&_color_helper.dart';
import '../../../../../App Helper/Frontend Helper/Loading Helper/shimmer_loading.dart';

class HomeOffers extends StatefulWidget {
  const HomeOffers({Key? key}) : super(key: key);

  @override
  State<HomeOffers> createState() => _HomeOffersState();
}

class _HomeOffersState extends State<HomeOffers> {

  final controller = Get.find<HomeDataFuture>();

  @override
  void initState() {
    super.initState();
    controller.fetchTodayDeal();
  }
  @override
  Widget build(BuildContext context) {
    return Obx(
          () => controller.todayDealLoad.value
          ? Column(
        children: [
          ShimmerHelper(
              child: Container(
                  width: Get.width,
                  height: 90,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: hsPrime.withOpacity(0.5)))),
          const SizedBox(height: 10)
        ],
      )
          : controller.todayDeal.value.todayData!.isEmpty
          ? Container()
          : Container(
        width: Get.width,
        color: Colors.grey[200],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
              child: Text(
                "Today's Deal",
                style: TextStyle(
                    fontFamily: FontType.MontserratMedium,
                    fontSize: 14,
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: Get.width,
                height: 50,
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.todayDeal.value.todayData!.length,
                  itemBuilder: (context, index) {
                    var todayDeal = controller
                        .todayDeal.value.todayData![index];
                    return Padding(
                      padding:
                      const EdgeInsets.fromLTRB(10, 0, 0, 10),
                      child: InkWell(
                        onTap: () {
                          Get.to(() => TodayDealDetails(dealId: todayDeal.id));
                        },
                        child: Container(
                          width: Get.width / 1.35,
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [
                                  hsPrime.withOpacity(1),
                                  hsPrime.withOpacity(0.7)
                                ],
                              ),
                              border: Border.all(
                                  color: hsPrime,
                                  width: 0.2)),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 10, top: 5, bottom: 5),
                                child: Image(
                                  image: AppIcons.discountOffer,
                                  width: 30,
                                ),
                              ),
                              Text(
                                "${todayDeal.title}",
                                style: const TextStyle(
                                    fontFamily:
                                    FontType.MontserratRegular,
                                    fontSize: 13,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
