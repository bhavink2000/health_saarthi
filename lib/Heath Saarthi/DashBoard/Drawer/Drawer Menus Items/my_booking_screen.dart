// ignore_for_file: missing_return, null_aware_in_condition

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/Loading%20Helper/loading_helper.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../App Helper/Backend Helper/Enums/enums_status.dart';
import '../../../App Helper/Backend Helper/Get Access Token/get_access_token.dart';
import '../../../App Helper/Backend Helper/Providers/Home Menu Provider/home_menu_provider.dart';
import '../../../App Helper/Frontend Helper/Error Helper/token_expired_helper.dart';
import '../../../App Helper/Frontend Helper/Font & Color Helper/font_&_color_helper.dart';
import '../../../App Helper/Frontend Helper/Snack Bar Msg/getx_snackbar_msg.dart';

class MyBookingScreen extends StatefulWidget {
  const MyBookingScreen({Key? key}) : super(key: key);

  @override
  State<MyBookingScreen> createState() => _MyBookingScreenState();
}

class _MyBookingScreenState extends State<MyBookingScreen> {

  final fromDate = TextEditingController();
  final toDate = TextEditingController();

  GetAccessToken getAccessToken = GetAccessToken();
  HomeMenusProvider homeMenusProvider = HomeMenusProvider();
  @override
  void initState() {
    super.initState();
    getAccessToken.checkAuthentication(context, setState);
    Map data = {
      'from_date': fromDate.text,
      'to_date': toDate.text,
    };
    print("data->$data");
    Future.delayed(const Duration(seconds: 1),(){
      setState(() {
        homeMenusProvider.fetchBookingHistory(getAccessToken.access_token, data);
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: hsPrimeOne,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back,color: Colors.white,size: 25,),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Text("My Booking",style: TextStyle(fontSize: 16,color: Colors.white,fontFamily: FontType.MontserratMedium,letterSpacing: 1),),
                  //Icon(Icons.circle_notifications_rounded,color: hsColorOne,size: 25,)
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width.w,
              height: MediaQuery.of(context).size.height / 18.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 3.w,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.white
                    ),
                    child: TextField(
                      controller: fromDate,
                      readOnly: true,
                      style: const TextStyle(fontFamily: FontType.MontserratRegular,color: Colors.black,fontSize: 14),
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                          border: InputBorder.none,
                          labelText: "Start Date",
                        labelStyle: TextStyle(fontFamily: FontType.MontserratLight,color: Colors.black,fontWeight: FontWeight.bold,fontSize: 12)
                      ),
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101)
                        );
                        if(pickedDate != null ){
                          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                          setState(() {
                            fromDate.text = formattedDate;
                          });
                        }else{

                        }
                      },
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 3.w,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.white
                    ),
                    child: TextField(
                      controller: toDate,
                      readOnly: true,
                      style: const TextStyle(fontFamily: FontType.MontserratRegular,color: Colors.black,fontSize: 14),
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                          border: InputBorder.none,
                          labelText: "To Date",
                          labelStyle: TextStyle(fontFamily: FontType.MontserratLight,color: Colors.black,fontWeight: FontWeight.bold,fontSize: 12)
                      ),
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime.now()
                        );
                        if(pickedDate != null ){
                          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                          setState(() {
                            toDate.text = formattedDate;
                          });
                        }else{

                        }
                      },
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      if(fromDate.text.isEmpty || toDate.text.isEmpty){
                        GetXSnackBarMsg.getWarningMsg('Please enter dates');
                      }
                      else{
                        Map data = {
                          'from_date': fromDate.text,
                          'to_date': toDate.text,
                        };
                        print("Map ->$data");
                        homeMenusProvider.fetchBookingHistory(getAccessToken.access_token, data);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.white
                      ),
                      child: Text("Apply",style: TextStyle(fontFamily: FontType.MontserratMedium,color: hsPrime,fontWeight: FontWeight.bold,fontSize: 12  ),),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 10.h),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20)),color: Colors.white),
                child: ChangeNotifierProvider<HomeMenusProvider>(
                  create: (BuildContext context) => homeMenusProvider,
                  child: Consumer<HomeMenusProvider>(
                    builder: (context, value, __){
                      switch(value.bookingList.status!){
                        case Status.loading:
                          return const CenterLoading();
                        case Status.error:
                          return value.bookingList.message == '402'
                              ? TokenExpiredHelper()
                              : Center(
                            child: Text("No Data",style: TextStyle(fontFamily: FontType.MontserratMedium,fontWeight: FontWeight.bold,color: hsPrime,letterSpacing: 1),),
                          );
                        case Status.completed:
                          return value.bookingList.data!.bookingData!.bookingItems!.isNotEmpty ? ListView.builder(
                            itemCount: value.bookingList.data!.bookingData?.bookingItems?.length,
                            itemBuilder: (context, index){
                              var bookingH = value.bookingList.data!.bookingData?.bookingItems![index];
                              return Padding(
                                padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                                child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  shadowColor: hsGrey.withOpacity(0.5),
                                  child: Theme(
                                    data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                                    child: ExpansionTile(
                                      title: Text(bookingH!.pharmacyPatient!.name!,style: const TextStyle(fontFamily: FontType.MontserratMedium,letterSpacing: 1,fontSize: 16)),
                                      subtitle: Text("Booking No :- ${bookingH.bookingCode!}",style: const TextStyle(fontFamily: FontType.MontserratRegular,letterSpacing: 1,fontSize: 12)),
                                      childrenPadding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                                      children: [
                                        showRowContent('Mobile Number', '${bookingH!.pharmacyPatient!.mobileNo}'),
                                        const SizedBox(height: 5),
                                        showRowContent('Gross Amount', '\u{20B9}${bookingH!.grossAmount == null ? 0 : bookingH!.grossAmount}'),
                                        const SizedBox(height: 5),
                                        showRowContent('Net Amount', '\u{20B9}${bookingH.netAmount == null ? 0 : bookingH.netAmount}'),
                                        const SizedBox(height: 5),
                                        showRowContent('Earning Amount', '\u{20B9}${bookingH.pharmacyDiscountAmount == null ? 0 : bookingH.pharmacyDiscountAmount}'),
                                        const SizedBox(height: 5),
                                        showRowContent('Date', '${bookingH.createAt}'),
                                        const SizedBox(height: 5),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text("Booking Status ",style: TextStyle(fontFamily: FontType.MontserratMedium,letterSpacing: 1,fontSize: 14),),
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(15),
                                                color: hsPrime
                                              ),
                                              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                              child: Text(
                                                  bookingH.status == 0
                                                      ? '${bookingH.bookingStatus!.s0}'
                                                      : bookingH.status == 1
                                                        ? '${bookingH.bookingStatus!.s1}'
                                                        : bookingH.status == 2
                                                          ? '${bookingH.bookingStatus!.s2}'
                                                          : bookingH.status == 3
                                                            ? '${bookingH.bookingStatus!.s3}'
                                                            : '${bookingH.bookingStatus!.s4}',
                                                  style: const TextStyle(fontFamily: FontType.MontserratRegular,fontSize: 12,fontWeight: FontWeight.bold,color: Colors.white)
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
                          ) : Center(
                            child: Text("No booking data",style: TextStyle(fontFamily: FontType.MontserratMedium,fontWeight: FontWeight.bold,color: hsPrime,letterSpacing: 1),),
                          );
                      }
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  Widget showRowContent(var lebal, var value){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("$lebal ",style: TextStyle(fontFamily: FontType.MontserratMedium,letterSpacing: 1,fontSize: 14),),
        Text('$value',style: const TextStyle(fontFamily: FontType.MontserratRegular,letterSpacing: 1,fontSize: 12)),
      ],
    );
  }
}
