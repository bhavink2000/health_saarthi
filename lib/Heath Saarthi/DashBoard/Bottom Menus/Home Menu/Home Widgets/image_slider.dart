//@dart=2.9
// ignore_for_file: missing_return

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Enums/enums_status.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/Loading%20Helper/loading_helper.dart';
import 'package:provider/provider.dart';
import '../../../../App Helper/Backend Helper/Get Access Token/get_access_token.dart';
import '../../../../App Helper/Backend Helper/Providers/Home Menu Provider/home_menu_provider.dart';
import '../../../../App Helper/Frontend Helper/Font & Color Helper/font_&_color_helper.dart';
import '../Test List/test_list_items.dart';

class HomeImageSlider extends StatefulWidget {
  const HomeImageSlider({Key key}) : super(key: key);

  @override
  State<HomeImageSlider> createState() => _HomeImageSliderState();
}

class _HomeImageSliderState extends State<HomeImageSlider> {

  GetAccessToken getAccessToken = GetAccessToken();
  HomeMenusProvider homeMenusProvider = HomeMenusProvider();
  int curentindex = 0;
  @override
  void initState() {
    super.initState();
    getAccessToken.checkAuthentication(context, setState);
    Future.delayed(const Duration(seconds: 2),(){
      setState(() {
        homeMenusProvider.fetchBanner(1, getAccessToken.access_token);
      });
    });
  }
  @override
  Widget build(BuildContext context) {  
    return ChangeNotifierProvider<HomeMenusProvider>(
      create: (BuildContext context)=>homeMenusProvider,
      child: Consumer<HomeMenusProvider>(
        builder: (context, value, __){
          switch(value.bannerList.status){
            case Status.loading:
              return const CenterLoading();
            case Status.error:
              return Center(child: Text(value.bannerList.message));
            case Status.completed:
              return value.bannerList.data.data.isEmpty ? Container() :Container(
                width: MediaQuery.of(context).size.width.w,
                height: MediaQuery.of(context).size.height / 6.h,
                child: value.bannerList.data.data.isEmpty
                    ? const Center(child: Text("No Banner Available",style: TextStyle(fontFamily: FontType.MontserratMedium),),)
                    : CarouselSlider.builder(
                  options: CarouselOptions(
                    viewportFraction: 0.8,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration: const Duration(milliseconds: 2000),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.1,
                    scrollDirection: Axis.horizontal,
                  ),
                  itemCount: value.bannerList.data.data.length,
                  itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex){
                    var bannerI = value.bannerList.data.data[itemIndex];
                    return Container(
                      width: MediaQuery.of(context).size.width.w,
                      height: MediaQuery.of(context).size.height / 7.h,
                      child: InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>TestListItems()));
                          },
                          child: Image(image: NetworkImage(bannerI.image),fit: BoxFit.fill,)),
                    );
                  },
                ),
              );
          }
        },
      ),
    );
  }
}
