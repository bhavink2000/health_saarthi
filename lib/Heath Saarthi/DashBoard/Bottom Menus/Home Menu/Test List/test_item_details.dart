
// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/Loading%20Helper/loading_helper.dart';
import '../../../../App Helper/Backend Helper/Api Future/Cart Future/cart_future.dart';
import '../../../../App Helper/Backend Helper/Api Future/Data Future/data_future.dart';
import '../Home Widgets/test_package_items.dart';

class TestItemDetails extends StatefulWidget {
  var testId;
  TestItemDetails({Key? key,this.testId}) : super(key: key);

  @override
  State<TestItemDetails> createState() => _TestItemDetailsState();
}

class _TestItemDetailsState extends State<TestItemDetails> {

  final controller = Get.find<DataFuture>();

  @override
  void initState() {
    super.initState();
    controller.fetchTestItems(widget.testId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(
         ()=>Column(
            children: [
              TestPackageItemAppBar(
                serviceCode: controller.tItemModel.value.data?.serviceCode,
                pItemsLoading: controller.pItemsLoading.value,
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: controller.tItemLoading.value == false
                      ? TestPackageItemsData(
                    serviceName: controller.tItemModel.value.data?.serviceName,
                    specimenVolme: controller.tItemModel.value.data?.specimenVolume,
                    testList: controller.tItemModel.value.data?.testList,
                    mrpAmount: controller.tItemModel.value.data?.mrpAmount,
                    onTap: (){
                      CartFuture().addToCartTest(widget.testId).then((value){
                        controller.fetchTestItems(widget.testId);
                      });
                    },
                    bookedStatus: controller.tItemModel.value.data?.bookedStatus,
                    collect: controller.tItemModel.value.data?.collect,
                    orderInfo: controller.tItemModel.value.data?.orderingInfo,
                    reported: controller.tItemModel.value.data?.reported,
                  ) : Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height / 2),
                      CenterLoading(),
                    ],
                  ),
                ),
              )
            ],
          )
      ),
      ),
    );
  }
}
