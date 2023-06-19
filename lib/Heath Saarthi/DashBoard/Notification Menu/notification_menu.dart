import 'package:flutter/material.dart';
import '../../App Helper/Frontend Helper/Font & Color Helper/font_&_color_helper.dart';

class NotificationMenu extends StatefulWidget {
  const NotificationMenu({Key? key}) : super(key: key);

  @override
  State<NotificationMenu> createState() => _NotificationMenuState();
}

class _NotificationMenuState extends State<NotificationMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(onTap: (){Navigator.pop(context);}, child: Icon(Icons.arrow_back,color: hsPrime,size: 30,)),
                  const Image(image: AssetImage("assets/health_saarthi_logo.png"),width: 150),
                ],
              ),
            ),
            Expanded(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  itemCount: 15,
                  itemBuilder: (context, index){
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          //height: MediaQuery.of(context).size.height / 8,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
                                    child: Text("Subject",style: TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 16)),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.fromLTRB(10, 3, 10, 3),
                                    decoration: BoxDecoration(borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(15)
                                    ),color: hsPrimeOne),
                                    child: const Text("10 May 2023,4:05PM",style: TextStyle(fontFamily: FontType.MontserratRegular,color: Colors.white,fontSize: 12),),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                child: Text(
                                """Lorem ipsum dolor sit amet, consectetur adipiscing elit.Ut feugiat velit consectetur nisi ultricies, nec pulvinar velit porta.""",
                                  style: TextStyle(fontFamily: FontType.MontserratRegular,fontSize: 12),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}
