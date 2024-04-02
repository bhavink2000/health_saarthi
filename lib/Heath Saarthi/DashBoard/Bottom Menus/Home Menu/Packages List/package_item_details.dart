
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_saarthi/Heath%20Saarthi/DashBoard/Bottom%20Menus/Home%20Menu/Home%20Widgets/test_package_items.dart';
import '../../../../App Helper/Backend Helper/Api Future/Cart Future/cart_future.dart';
import '../../../../App Helper/Backend Helper/Api Future/Data Future/data_future.dart';
import '../../../../App Helper/Frontend Helper/Loading Helper/loading_helper.dart';

class PackageItemDetails extends StatefulWidget {
  var packageId;
  PackageItemDetails({Key? key,this.packageId}) : super(key: key);

  @override
  State<PackageItemDetails> createState() => _PackageItemDetailsState();
}

class _PackageItemDetailsState extends State<PackageItemDetails> {

  final controller = Get.find<DataFuture>();

  @override
  void initState() {
    super.initState();
    controller.fetchPackageItems(widget.packageId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(
            ()=>Column(
              children: [
                TestPackageItemAppBar(
                  serviceCode: controller.pItemModel.value.data?.serviceCode,
                  pItemsLoading: controller.pItemsLoading.value,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: controller.pItemsLoading.value == false
                        ? TestPackageItemsData(
                      serviceName: controller.pItemModel.value.data?.serviceName,
                      specimenVolme: controller.pItemModel.value.data?.specimenVolume,
                      testList: controller.pItemModel.value.data?.testList,
                      mrpAmount: controller.pItemModel.value.data?.mrpAmount,
                      onTap: (){
                        CartFuture().addToCartTest(widget.packageId).then((value){
                          controller.fetchPackageItems(widget.packageId);
                        });
                      },
                      bookedStatus: controller.pItemModel.value.data?.bookedStatus,
                      collect: controller.pItemModel.value.data?.collect,
                      orderInfo: controller.pItemModel.value.data?.orderingInfo,
                      reported: controller.pItemModel.value.data?.reported,
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
