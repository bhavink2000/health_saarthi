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
import '../../../Add To Cart/cart_screen.dart';
import '../../../Add To Cart/test_cart.dart';
import '../Home Widgets/test_package_data_healper.dart';
import 'test_item_details.dart';

class TestDataNew extends StatefulWidget {
  const TestDataNew({super.key});

  @override
  State<TestDataNew> createState() => _TestDataNewState();
}

class _TestDataNewState extends State<TestDataNew> {

  final controller = Get.find<DataFuture>();

  @override
  void initState() {
    super.initState();
    controller.fetchTest(0);
  }

  @override
  void dispose() {
    controller.testIndex.value = 0;
    controller.testSearch.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            AppBarHelper(appBarLabel: 'Test Items'),
            Divider(color: Colors.grey.withOpacity(0.5),thickness: 1),
            Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: SearchTextField(
                  controller: controller.testSearch,
                  onTap: (){
                    controller.testSearch.clear();
                    controller.fetchTest(1);
                  },
                  onChanged: (value){
                    controller.fetchTest(1);
                  },
                )
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Obx(
                  ()=> controller.testLoading.value
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
                  : controller.testModel.value.testData!.data!.isEmpty
                   ? Container(
                      width: Get.width,
                      height: Get.height / 1.3,
                      alignment: Alignment.center,
                      child: Text("Test Not found your branch",
                          style: TextStyle(fontFamily: FontType.MontserratRegular, fontSize: 16), textAlign: TextAlign.center
                      ),
                    )
                   : AnimationLimiter(
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.testModel.value.testData?.data!.length,
                        itemBuilder: (context, index){
                          var testI = controller.testModel.value.testData?.data![index];
                          return AnimationConfiguration.staggeredList(
                            position: index,
                            duration: Duration(milliseconds: 800),
                            child: Column(
                              children: [
                                FadeInAnimation(
                                  child: TestPackageData(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>TestItemDetails(
                                        testId: testI.id,
                                      )));
                                    },
                                    serviceName: testI!.serviceName,
                                    specimenVolume: testI.specimenVolume,
                                    mrpAmount: testI.mrpAmount,
                                    bookedStatus: testI.bookedStatus.toString(),
                                    bookedOnTap: (){
                                      if (testI.bookedStatus == 1) {
                                        GetXSnackBarMsg.getWarningMsg('Already booked this item');
                                      } else {
                                        CartFuture().addToCartTest(testI.id).then((value) {
                                          controller.fetchTest(controller.testIndex.value + 1);
                                        });
                                      }
                                    },
                                  )
                                ),
                                if (controller.testModel.value.testData?.data!.length == 10 || index + 1 != controller.testModel.value.testData?.data?.length)
                                  Container()
                                else
                                  SizedBox(height: Get.height / 1.9),
                                index + 1 == controller.testModel.value.testData!.data!.length
                                    ? CustomPaginationWidget(
                                  currentPage: controller.testIndex.value,
                                  lastPage: controller.testModel.value.testData!.lastPage!,
                                  onPageChange: (page) {
                                    controller.testIndex.value = page - 1;
                                    controller.fetchTest(controller.testIndex.value + 1);
                                  },
                                ) : Container(),
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
              () => controller.testLoading.value
              ? Container()
              : BottomBarHelper(
                count: controller.testModel.value.cartData?.count,
                amount: controller.testModel.value.cartData?.amount,
                onTap: (){
                  Get.to(()=>TestCart());
                  //Get.to(()=>CartScreen());
                },
              )
            )
          ],
        ),
      ),
    );
  }
}
