
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Api%20Future/Cart%20Future/cart_future.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Enums/enums_status.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Providers/Home%20Menu%20Provider/home_menu_provider.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/Loading%20Helper/loading_helper.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/Snack%20Bar%20Msg/getx_snackbar_msg.dart';
import 'package:health_saarthi/Heath%20Saarthi/DashBoard/Bottom%20Menus/Home%20Menu/Test%20List/test_item_details.dart';
import 'package:health_saarthi/Heath%20Saarthi/DashBoard/Notification%20Menu/notification_menu.dart';
import 'package:provider/provider.dart';
import '../../../../App Helper/Backend Helper/Get Access Token/get_access_token.dart';
import '../../../../App Helper/Frontend Helper/Error Helper/token_expired_helper.dart';
import '../../../../App Helper/Frontend Helper/Font & Color Helper/font_&_color_helper.dart';
import '../../../../App Helper/Frontend Helper/Pagination Helper/custom_pagination_widget.dart';
import '../../../Add To Cart/test_cart.dart';

class TestListItems extends StatefulWidget {
  TestListItems({Key? key}) : super(key: key);

  @override
  State<TestListItems> createState() => _TestListItemsState();
}

class _TestListItemsState extends State<TestListItems> {

  GetAccessToken getAccessToken = GetAccessToken();
  HomeMenusProvider homeMenusProvider = HomeMenusProvider();
  int curentindex = 0;
  @override
  void initState() {
    super.initState();
    getAccessToken.checkAuthentication(context, setState);
    Future.delayed(const Duration(seconds: 2),(){
      setState(() {
        homeMenusProvider.fetchTest(1, getAccessToken.access_token, '');
      });
    });
  }

  final testSearch = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Map testData = {
      'search': testSearch.text,
    };
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          child: Row(
                            children: [
                              IconButton(onPressed: (){
                                Navigator.pop(context);
                                }, icon: const Icon(Icons.arrow_back,color: Colors.black,size: 24)),
                              SizedBox(width: 10.w),
                              Text("Test Items",style: TextStyle(fontFamily: FontType.MontserratMedium,color: Colors.black,fontSize: 14.sp,fontWeight: FontWeight.bold),)
                            ],
                          )
                      ),
                      Row(
                        children: [
                          IconButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>const TestCart()));
                          }, icon: Icon(Icons.shopping_cart_outlined,color: hsTestColor,size: 24)),
                          IconButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>const NotificationMenu()));
                          }, icon: Icon(Icons.circle_notifications_rounded,color: hsTestColor,size: 24)),
                        ],
                      )
                    ],
                  ),
                ),
                Divider(color: Colors.grey.withOpacity(0.5),thickness: 1),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Card(
                    elevation: 0,
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4))),
                    child: Container(
                      height: MediaQuery.of(context).size.height / 19.h,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          border: Border.all(color: Colors.grey.withOpacity(1),width: 1),
                          borderRadius: const BorderRadius.all(Radius.circular(4))
                      ),
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: TextFormField(
                        controller: testSearch,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                          border: InputBorder.none,
                          hintText: 'Search for Tests, Package',
                          hintStyle: const TextStyle(fontSize: 12, fontFamily: FontType.MontserratRegular),
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                testSearch.clear();
                              });
                              Map testData = {
                                'search': '',
                              };
                              homeMenusProvider.fetchTest(1, getAccessToken.access_token, testData);
                            },
                            child: const Icon(Icons.close),
                          ),
                          focusColor: hsPrime,
                        ),
                        onChanged: (value) {
                          Map testData = {
                            'search': testSearch.text,
                          };
                          homeMenusProvider.fetchTest(1, getAccessToken.access_token, testData);
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width.w,
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: ChangeNotifierProvider<HomeMenusProvider>(
                  create: (BuildContext context) => homeMenusProvider,
                  child: Consumer<HomeMenusProvider>(
                    builder: (context, value, index){
                      switch(value.testList.status!){
                        case Status.loading:
                          return const CenterLoading();
                        case Status.error:
                          print("status.error test msg-->>${value.testList.message}-------------");
                          print("status.error test status-->>${value.testList.status}-------------");
                          return value.testList.status == '402'
                           ? TokenExpiredHelper(tokenMsg: value.testList.message)
                           : value.testList.message == 'Internet connection problem' ? CenterLoading() : value.testList.data == []
                                ? Container()
                                : const Center(
                                  child: Text(
                                  "Test Not found your branch",
                                  style: TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 16
                                  ),textAlign: TextAlign.center
                              )
                          );
                        case Status.completed:
                          return Column(
                            children: [
                              Expanded(
                                child: Container(
                                  width: MediaQuery.of(context).size.width.w,
                                  //height: MediaQuery.of(context).size.height / 1.1.h,
                                  child: AnimationLimiter(
                                      child: ListView.builder(
                                        physics: const BouncingScrollPhysics(),
                                        itemCount: value.testList.data!.testData!.data!.length,
                                        itemBuilder: (context, index){
                                          var testI = value.testList.data!.testData!.data![index];
                                          return AnimationConfiguration.staggeredList(
                                            position: index,
                                            duration: const Duration(milliseconds: 1000),
                                            child: Column(
                                              children: [
                                                FadeInAnimation(
                                                  child: Container(
                                                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                                    child: InkWell(
                                                      onTap: (){
                                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>TestItemDetails(
                                                          testId: testI.id,
                                                          accessToken: getAccessToken.access_token,
                                                        )));
                                                      },
                                                      child: Card(
                                                        elevation: 5,
                                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                                        shadowColor: Colors.grey.withOpacity(0.5),
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Container(
                                                              width: MediaQuery.of(context).size.width.w,
                                                              decoration: BoxDecoration(
                                                                borderRadius: const BorderRadius.only(
                                                                    topLeft: Radius.circular(10),topRight: Radius.circular(10)
                                                                ),
                                                                color: hsTestColor.withOpacity(0.5),
                                                              ),
                                                              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                                              child: Text(
                                                                  testI.serviceName!,
                                                                  style: TextStyle(
                                                                      fontFamily: FontType.MontserratMedium,
                                                                      fontSize: 15.sp,color: Colors.white
                                                                  )
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                                                              child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  //Divider(color: hsOne,thickness: 1),
                                                                  Container(
                                                                      width: MediaQuery.of(context).size.width / 1.5.w,
                                                                      child: Text("${testI.specimenVolume == null ? 'N/A': testI.specimenVolume}",style: TextStyle(fontFamily: FontType.MontserratRegular,letterSpacing: 0.5,color: Colors.black87,fontSize: 12.sp),)),
                                                                  Row(
                                                                    children: [
                                                                      Text("\u{20B9}${testI.mrpAmount}",style: TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 18.sp,color: hsBlack)),
                                                                      const Spacer(),
                                                                      InkWell(
                                                                        onTap: (){
                                                                          if(testI.bookedStatus == 1){
                                                                            GetXSnackBarMsg.getWarningMsg('Already booked this item');
                                                                          }
                                                                          else{
                                                                            CartFuture().addToCartTest(getAccessToken.access_token, testI.id, context).then((value) {
                                                                              setState(() {
                                                                                testI.bookedStatus = 1;
                                                                              });

                                                                              //homeMenusProvider.fetchTest(curentindex + 1, getAccessToken.access_token,testData);
                                                                            });
                                                                          }
                                                                        },
                                                                        child: Container(
                                                                          decoration: BoxDecoration(borderRadius: const BorderRadius.only(
                                                                              bottomRight: Radius.circular(10),topLeft: Radius.circular(10)
                                                                          ),
                                                                           color: testI.bookedStatus == 1 ? hsTestColor.withOpacity(0.2): hsTestColor
                                                                          ),
                                                                          padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
                                                                          child: Text(
                                                                            testI.bookedStatus == 1 ? "Booked" :"+ Book Now",
                                                                            style: TextStyle(fontFamily: FontType.MontserratRegular,fontSize: 13.sp,color: Colors.white),),
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),

                                                if (value.testList.data!.testData!.data!.length == 10 || index + 1 != value.testList.data!.testData!.data!.length)
                                                  Container()
                                                else
                                                  SizedBox(height: MediaQuery.of(context).size.height / 1.9),

                                                index + 1 == value.testList.data!.testData!.data!.length ? CustomPaginationWidget(
                                                  currentPage: curentindex,
                                                  lastPage: homeMenusProvider.testList.data!.testData!.lastPage!,
                                                  onPageChange: (page) {
                                                    setState(() {
                                                      curentindex = page - 1;
                                                    });
                                                    homeMenusProvider.fetchTest(curentindex + 1, getAccessToken.access_token, testData);
                                                  },
                                                ) : Container(),
                                              ],
                                            ),
                                          );
                                        },
                                      )
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height / 12.h,
                                color: hsTestColor,
                                child: InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const TestCart()));
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(15, 5, 10, 5),
                                        child: Text(
                                            "Total Cart Items [ ${value.testList.data!.cartData!.count} ]",
                                          style: const TextStyle(fontFamily: FontType.MontserratMedium,color: Colors.white),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(0, 8, 10, 8),
                                        child: Container(
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.white),
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                                            child: Row(
                                              children: [
                                                Text(
                                                  "\u{20B9}${value.testList.data!.cartData!.amount}",
                                                  style: TextStyle(fontFamily: FontType.MontserratRegular,color: hsTestColor,fontWeight: FontWeight.bold),
                                                ),
                                                SizedBox(width: 5.w),
                                                Icon(Icons.arrow_forward_ios_rounded,size: 15,color: hsTestColor),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
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
}
