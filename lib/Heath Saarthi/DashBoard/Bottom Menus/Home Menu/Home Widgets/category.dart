import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/category_model.dart';
import '../../../../App Helper/Frontend Helper/Font & Color Helper/font_&_color_helper.dart';
import '../Packages List/package_list.dart';

class HomeCategory extends StatefulWidget {
  const HomeCategory({Key? key}) : super(key: key);

  @override
  State<HomeCategory> createState() => _HomeCategoryState();
}

class _HomeCategoryState extends State<HomeCategory> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
            child: Text("Package Disease",style: TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 14.sp,letterSpacing: 0.5,fontWeight: FontWeight.bold),),
          ),
          Container(
            width: MediaQuery.of(context).size.width.w,
            height: MediaQuery.of(context).size.height / 5.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: categoryItems.length,
              itemBuilder: (context, index){
                return Padding(
                  padding: const EdgeInsets.fromLTRB(15, 10, 10, 10),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>const PackageListItems()));
                        },
                        child: Container(
                          //color: Colors.green,
                          child: Image(
                            image: AssetImage(categoryItems[index].imageUrl),
                            width: 80,
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(categoryItems[index].title,style: TextStyle(fontSize: 15.sp,fontFamily: FontType.MontserratRegular,fontWeight: FontWeight.bold),)
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
