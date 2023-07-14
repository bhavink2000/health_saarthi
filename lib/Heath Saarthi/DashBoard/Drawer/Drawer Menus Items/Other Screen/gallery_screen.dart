//@dart=2.9
import 'package:flutter/material.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Frontend%20Helper/Font%20&%20Color%20Helper/font_&_color_helper.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({Key key}) : super(key: key);

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {

  List<String> images = [
    "https://img.freepik.com/free-vector/hand-drawn-urology-illustration_23-2149707560.jpg?size=626&ext=jpg&ga=GA1.1.1309629864.1683635266&semt=sph",
    "https://img.freepik.com/free-vector/hand-drawn-flat-design-fatty-liver-illustration_23-2149279484.jpg?size=626&ext=jpg&ga=GA1.1.1309629864.1683635266&semt=sph",
    "https://img.freepik.com/free-vector/brain-chemistry-concept-illustration_114360-10136.jpg?size=626&ext=jpg&ga=GA1.1.1309629864.1683635266&semt=sph",
    "https://img.freepik.com/free-vector/danger-smoking-landing-page_23-2148705675.jpg?size=626&ext=jpg&ga=GA1.1.1309629864.1683635266&semt=sph"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: hsPrimeOne,
      resizeToAvoidBottomInset: false,
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
                  const Text("Gallery",style: TextStyle(fontSize: 16,color: Colors.white,fontFamily: FontType.MontserratMedium,letterSpacing: 1),),
                  //Icon(Icons.circle_notifications_rounded,color: hsColorOne,size: 25,)
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20)),color: Colors.white),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 4.0,
                      mainAxisSpacing: 4.0
                  ),
                  itemCount: images.length,
                  itemBuilder: (BuildContext context, int index){
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        child: Image.network(images[index],fit: BoxFit.fill,)
                      ),
                    );
                  },
                )),
              ),
          ],
        ),
      ),
    );
  }
}
