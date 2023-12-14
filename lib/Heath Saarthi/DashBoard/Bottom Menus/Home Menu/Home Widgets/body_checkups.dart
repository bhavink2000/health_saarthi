import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/Loading%20Helper/loading_helper.dart';
import '../../../../App Helper/Backend Helper/Api Future/Cart Future/cart_future.dart';
import '../../../../App Helper/Backend Helper/Api Repo/Home Menu Repo/home_menu_repo.dart';
import '../../../../App Helper/Backend Helper/Get Access Token/get_access_token.dart';
import '../../../../App Helper/Frontend Helper/Font & Color Helper/font_&_color_helper.dart';
import '../Packages List/package_item_details.dart';

class HomeBodyCheckups extends StatefulWidget {
  const HomeBodyCheckups({Key? key}) : super(key: key);

  @override
  State<HomeBodyCheckups> createState() => _HomeBodyCheckupsState();
}

class _HomeBodyCheckupsState extends State<HomeBodyCheckups> {

  GetAccessToken getAccessToken = GetAccessToken();
  List<Map<String, dynamic>> popularPackage = [];
  @override
  void initState() {
    super.initState();
    getAccessToken.checkAuthentication(context, setState);
    Future.delayed(const Duration(seconds: 1),(){
      setState(() {
        popularPack();
      });
    });
  }

  bool? isLoading;
  void popularPack() async {
    setState(() {
      isLoading = false;
    });
    try {
      Map<String, dynamic> popularP = await HomeMenuRepo().popularPackageData(0, getAccessToken.access_token, '');
      if (popularP != null && popularP.containsKey('data')) {
        List<dynamic> dataList = popularP['data'];
        if (dataList.isNotEmpty) {
          List<Map<String, dynamic>> packageList = dataList.cast<Map<String, dynamic>>();
          setState(() {
            popularPackage = packageList;
            isLoading = true;
          });
        } else {
          setState(() {
            isLoading = true;
          });
        }
      } else {
        setState(() {
          isLoading = true;
        });
      }
    } catch (e) {
      print("Error fetching popular package data: $e");
      setState(() {
        isLoading = true;
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 15, 0, 0),
            child: Text("Popular package's",style: TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 14.sp,letterSpacing: 0.5,fontWeight: FontWeight.bold),),
          ),
          Container(
            width: MediaQuery.of(context).size.width.w,
            height: MediaQuery.of(context).size.height / 2.7.h,
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: isLoading == true ? popularPackage.isNotEmpty ? ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: popularPackage.length,
              itemBuilder: (context, index){
                return Padding(
                  padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    child: InkWell(
                      onTap: (){
                        //Navigator.push(context, MaterialPageRoute(builder: (context)=>TestListItems()));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 1.2.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: AssetImage("assets/Home/box-bg.png"),
                            fit: BoxFit.fill
                          )
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(25, 60, 10, 5),
                              child: Text(
                                "${popularPackage[index]['max_service_name']}",
                                style: TextStyle(
                                    fontFamily: FontType.MontserratMedium,
                                    fontSize: 16.sp,
                                    color: Colors.black,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(25, 5, 10, 10),
                              child: Text("${popularPackage[index]['test_management']['service_classification']}", style: TextStyle(fontFamily: FontType.MontserratRegular,color: Colors.black,fontSize: 12.sp),),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(25, 5, 10, 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Colors.white
                                    ),
                                    padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                                    child: Text("\u{20B9}${popularPackage[index]['test_management']['mrp']}", style: TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 12.sp,fontWeight: FontWeight.bold,color: hsPrime,)),
                                  ),
                                  InkWell(
                                      onTap: (){
                                        print('id ->${popularPackage[index]['test_management']['id']}');
                                        print('access ->${getAccessToken.access_token}');
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>PackageItemDetails(
                                          packageId: popularPackage[index]['test_management']['id'],
                                          accessToken: getAccessToken.access_token,
                                        )));
                                      },
                                      child: Row(
                                        children: [
                                          Text("Know More", style: TextStyle(fontFamily: FontType.MontserratMedium,fontWeight: FontWeight.bold,color: hsPrime,fontSize: 12.sp)),
                                          SizedBox(width: 10.w),
                                          CircleAvatar(
                                            radius: 20,
                                            backgroundColor: hsPrime,
                                            child: Icon(Icons.add,color: Colors.white,size: 20),
                                          )
                                        ],
                                      )
                                  ),                                ],
                              ),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: (){
                                CartFuture().addToCartTest(getAccessToken.access_token, popularPackage[index]['test_management_id'], context).then((value) {});
                                setState(() {
                                  popularPackage[index]['test_management']['booked_status'] = 1;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(10),bottomLeft: Radius.circular(10)
                                    ),
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      hsPrime.withOpacity(1),
                                      Color(0xff603d83),
                                    ],
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                      child: Text(popularPackage[index]['test_management']['booked_status'] == 0 ? "Book Now" : "Booked",style: TextStyle(fontFamily: FontType.MontserratMedium,color: Colors.white,fontWeight: FontWeight.bold)),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.fromLTRB(6, 3, 6, 3),
                                      child: Icon(Icons.shopping_cart_rounded,color: Colors.white,size: 20,)
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ): Center(child: Text('No popular package available'),) : CenterLoading(),
          ),
        ],
      ),
    );
  }
}
