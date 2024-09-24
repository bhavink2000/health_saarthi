import 'package:get/get.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Api%20Future/Data%20Future/data_future.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/Loading%20Helper/loading_helper.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../App Helper/Frontend Helper/Font & Color Helper/font_&_color_helper.dart';


class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {

  final controller = Get.find<DataFuture>();

  @override
  void initState() {
    super.initState();
    controller.fetchContact();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: hsPrimeOne,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 20, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back,color: Colors.white,size: 25,),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Text("Contact Us",style: TextStyle(fontSize: 16,color: Colors.white,fontFamily: FontType.MontserratMedium,letterSpacing: 1),),
                  //Icon(Icons.circle_notifications_rounded,color: hsColorOne,size: 25,)
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20)),color: Colors.white),
                child: Obx(() => SafeArea(
                  child: controller.contactUsLoad.value == true ? Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                        child: Container(
                          color: Colors.white,
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                child: InkWell(
                                  onTap: ()=>launch("tel:// ${controller.salesPersonNo}"),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width / 1.5,
                                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("${controller.salesPersonNM == null || controller.salesPersonNM ==  "" ? 'N/A' : controller.salesPersonNM}",style: TextStyle(fontFamily: FontType.MontserratMedium,color: hsPrime,fontSize: 16,letterSpacing: 0.5),),
                                        const SizedBox(height: 5,),
                                        Text("${controller.salesPersonNo == null || controller.salesPersonNo == "" ? 'N/A' : controller.salesPersonNo}",style: TextStyle(fontFamily: FontType.MontserratRegular,color: hsPrime,fontSize: 14,letterSpacing: 0.5)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              CircleAvatar(
                                radius: 20,backgroundColor: hsPrimeOne,child: const Icon(Icons.call,color: Colors.white,),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                        child: Container(
                          color: Colors.white,
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                child: InkWell(
                                  onTap: ()=>launch("tel://${controller.superiorNo}"),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width / 1.5,
                                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("${controller.superiorNM == null ? 'N/A' : controller.superiorNM}",style: TextStyle(fontFamily: FontType.MontserratMedium,color: hsPrime,fontSize: 16,letterSpacing: 0.5),),
                                        const SizedBox(height: 5,),
                                        Text("${controller.superiorNo == null ? 'N/A' : controller.superiorNo}",style: TextStyle(fontFamily: FontType.MontserratRegular,color: hsPrime,fontSize: 14,letterSpacing: 0.5)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              CircleAvatar(
                                radius: 20,backgroundColor: hsPrimeOne,child: const Icon(Icons.call,color: Colors.white,),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                        child: Container(
                          color: Colors.white,
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                child: InkWell(
                                  onTap: ()=>launch("tel://${controller.customerCareNo}"),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width / 1.5,
                                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("${controller.customerCareNm == null ? 'N/A' : controller.customerCareNm}",style: TextStyle(fontFamily: FontType.MontserratMedium,color: hsPrime,fontSize: 16,letterSpacing: 0.5),),
                                        const SizedBox(height: 5,),
                                        Text("${controller.customerCareNo == null ? 'N/A' : controller.customerCareNo}",style: TextStyle(fontFamily: FontType.MontserratRegular,color: hsPrime,fontSize: 14,letterSpacing: 0.5)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              CircleAvatar(
                                radius: 20,backgroundColor: hsPrimeOne,child: const Icon(Icons.call,color: Colors.white,),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ) : CenterLoading(),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }

}
