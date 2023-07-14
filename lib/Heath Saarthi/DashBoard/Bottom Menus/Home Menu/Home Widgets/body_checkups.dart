//@dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../App Helper/Frontend Helper/Font & Color Helper/font_&_color_helper.dart';
import '../../../Add To Cart/test_cart.dart';
import '../Test List/test_list_item_details.dart';
import '../Test List/test_list_items.dart';

class HomeBodyCheckups extends StatefulWidget {
  const HomeBodyCheckups({Key key}) : super(key: key);

  @override
  State<HomeBodyCheckups> createState() => _HomeBodyCheckupsState();
}

class _HomeBodyCheckupsState extends State<HomeBodyCheckups> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 15, 0, 0),
            child: Text("Health Checkup",style: TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 14.sp,letterSpacing: 0.5,fontWeight: FontWeight.bold),),
          ),
          Container(
            width: MediaQuery.of(context).size.width.w,
            height: MediaQuery.of(context).size.height / 2.7.h,
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index){
                return Padding(
                  padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>TestListItems()));
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
                                "Health Saarthi Platinum Full Body Checkups",
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
                              child: Text("Include 8 Test", style: TextStyle(fontFamily: FontType.MontserratRegular,color: Colors.black,fontSize: 12.sp),),
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
                                    child: Text("\u{20B9}2555", style: TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 12.sp,fontWeight: FontWeight.bold,color: hsPrime,)),
                                  ),
                                  InkWell(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>TestListItems()));
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
                                final snackBar = SnackBar(
                                  content: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text("Item Booked Successfully",style: TextStyle(color: Colors.white,fontFamily: FontType.MontserratRegular),),
                                      Container(
                                        child: Row(
                                          children: [
                                            Text("\u{20B9}2555",style: TextStyle(color: Colors.white,fontFamily: FontType.MontserratRegular),),
                                            SizedBox(width: 10.w),
                                            InkWell(
                                              onTap: (){
                                                Navigator.push(context, MaterialPageRoute(builder: (context)=>const TestCart()));
                                              },
                                              child: Container(
                                                  padding: const EdgeInsets.fromLTRB(6, 3, 6, 3),
                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.white),
                                                  child: Icon(Icons.shopping_cart_rounded,color: hsPrime)
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  backgroundColor: hsPrime,
                                );
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
                                      child: Text("Book Now",style: TextStyle(fontFamily: FontType.MontserratMedium,color: Colors.white,fontWeight: FontWeight.bold)),
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
            ),
          ),
        ],
      ),
    );
  }
}
//bhavsina khunt  bhavin khunt