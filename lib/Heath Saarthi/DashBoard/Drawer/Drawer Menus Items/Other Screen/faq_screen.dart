// ignore_for_file: missing_return

import 'package:get/get.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Api%20Future/Data%20Future/data_future.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/Font%20&%20Color%20Helper/font_&_color_helper.dart';
import '../../../../App Helper/Frontend Helper/Loading Helper/loading_helper.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({Key? key}) : super(key: key);

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {

  final controller = Get.find<DataFuture>();

  @override
  void initState() {
    super.initState();
    controller.fetchFaqs();
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
                child: Obx(() => controller.faqLoad.value
                    ? const CenterLoading()
                    : controller.faqModel.value.data!.isNotEmpty
                    ? ListView.builder(
                  itemCount: controller.faqModel.value.data!.length,
                  itemBuilder: (context, index) {
                    var faqs = controller.faqModel.value.data![index];
                    return ExpansionTile(
                      collapsedTextColor: hsPrime,
                      tilePadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      backgroundColor: hsPrime.withOpacity(0.1),
                      title: Text(
                        faqs.question!,
                        style: TextStyle(
                            fontFamily: FontType.MontserratMedium,
                            color: hsPrime),
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 5),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              faqs.answer!,
                              style: const TextStyle(
                                  fontFamily:FontType.MontserratLight,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                )
                    : const Center(
                  child: Text('No FAQ data'),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }

}
