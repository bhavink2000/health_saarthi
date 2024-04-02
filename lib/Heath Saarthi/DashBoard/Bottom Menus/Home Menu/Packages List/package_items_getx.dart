import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import '../../../../App Helper/Backend Helper/Api Future/Cart Future/cart_future.dart';
import '../../../../App Helper/Backend Helper/Api Future/Data Future/data_future.dart';
import '../../../../App Helper/Frontend Helper/Font & Color Helper/font_&_color_helper.dart';
import '../../../../App Helper/Frontend Helper/Loading Helper/shimmer_loading.dart';
import '../../../../App Helper/Frontend Helper/Pagination Helper/custom_pagination_widget.dart';
import '../../../../App Helper/Frontend Helper/Snack Bar Msg/getx_snackbar_msg.dart';
import '../../../../App Helper/Widget Helper/appbar_helper.dart';
import '../../../../App Helper/Widget Helper/search_textfield.dart';
import '../../../Add To Cart/test_cart.dart';
import '../Home Widgets/test_package_data_healper.dart';
import 'package_item_details.dart';

class PackageDataNew extends StatefulWidget {
  const PackageDataNew({super.key});

  @override
  State<PackageDataNew> createState() => _PackageDataNewState();
}

class _PackageDataNewState extends State<PackageDataNew> {

  final controller = Get.find<DataFuture>();

  @override
  void initState() {
    super.initState();
    controller.fetchPackage(0);
  }

  @override
  void dispose() {
    controller.packageIndex.value = 0;
    controller.packageSearch.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset:  false,
      body: SafeArea(
        child: Column(
          children: [
            AppBarHelper(appBarLabel: 'Package Items'),
            Divider(color: Colors.grey.withOpacity(0.5),thickness: 1),
            Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: SearchTextField(
                  controller: controller.packageSearch,
                  onTap: (){
                    controller.packageSearch.clear();
                    controller.fetchPackage(1);
                  },
                  onChanged: (value){
                    controller.fetchPackage(1);
                  },
                )
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Obx(
                  ()=> controller.packageLoading.value
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: ShimmerHelper(
                          child: ListView.builder(
                            itemCount: 10,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Container(
                                  width: Get.width,
                                  decoration: BoxDecoration(color: hsPrime.withOpacity(0.5), borderRadius: BorderRadius.circular(5)),
                                  margin: const EdgeInsets.symmetric(vertical: 5), height: 100
                              );
                            },
                          )),
                    )
                  : controller.packageModel.value.packageData!.data!.isEmpty
                  ? Container(
                      width: Get.width,
                      height: Get.height / 1.3,
                      alignment: Alignment.center,
                      child: const Text("Package Not found your branch",
                          style: TextStyle(fontFamily: FontType.MontserratRegular, fontSize: 16), textAlign: TextAlign.center
                      ),
                    )
                  : AnimationLimiter(
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.packageModel.value.packageData?.data!.length,
                        itemBuilder: (context, index){
                          var packageI = controller.packageModel.value.packageData?.data![index];
                          return AnimationConfiguration.staggeredList(
                            position: index,
                            duration: Duration(milliseconds: 800),
                            child: Column(
                              children: [
                                FadeInAnimation(
                                    child: TestPackageData(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>PackageItemDetails(
                                          packageId: packageI.id,
                                        )));
                                      },
                                      serviceName: packageI!.serviceName,
                                      specimenVolume: packageI.specimenVolume,
                                      mrpAmount: packageI.mrpAmount,
                                      bookedStatus: packageI.bookedStatus.toString(),
                                      bookedOnTap: (){
                                        if (packageI.bookedStatus == 1) {
                                          GetXSnackBarMsg.getWarningMsg('Already booked this item');
                                        } else {
                                          CartFuture().addToCartTest(packageI.id).then((value) {
                                            controller.fetchPackage(controller.packageIndex.value + 1);
                                          });
                                        }
                                      },
                                    )),
                                if (controller.packageModel.value.packageData?.data!.length == 10 ||
                                    index + 1 != controller.packageModel.value.packageData?.data?.length)
                                  Container()
                                else
                                  SizedBox(height: Get.height / 1.9),
                                index + 1 ==
                                    controller.packageModel.value.packageData!.data!.length
                                    ? CustomPaginationWidget(
                                  currentPage: controller.packageIndex.value,
                                  lastPage: controller.packageModel.value.packageData!.lastPage!,
                                  onPageChange: (page) {
                                    controller.packageIndex.value = page - 1;
                                    controller.fetchPackage(controller.packageIndex.value + 1);
                                  },
                                )
                                    : Container(),
                              ],
                            ),
                          );
                        },
                      ),
                    )
                ),
              ),
            ),
            Obx(
              () => controller.packageLoading.value
              ? Container()
              : BottomBarHelper(
                count: controller.packageModel.value.cartData?.count,
                amount: controller.packageModel.value.cartData?.amount,
                onTap: (){
                  Get.to(() => TestCart());
                },
              )
            )
          ],
        ),
      ),
    );
  }
}
