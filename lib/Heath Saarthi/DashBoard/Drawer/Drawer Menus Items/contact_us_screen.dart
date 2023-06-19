import 'package:flutter/material.dart';

import '../../../App Helper/Frontend Helper/Font & Color Helper/font_&_color_helper.dart';


class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
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
                  const Text("Contact Us",style: TextStyle(fontSize: 20,color: Colors.white,fontFamily: FontType.MontserratMedium,letterSpacing: 1),),
                  //Icon(Icons.circle_notifications_rounded,color: hsColorOne,size: 25,)
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20)),color: Colors.white),
                child: SafeArea(
                  child: Column(
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
                                child: Container(
                                  width: MediaQuery.of(context).size.width / 1.5,
                                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("sales Person Name",style: TextStyle(fontFamily: FontType.MontserratMedium,color: hsOne,fontSize: 16,letterSpacing: 0.5),),
                                      const SizedBox(height: 5,),
                                      Text("1234567890",style: TextStyle(fontFamily: FontType.MontserratRegular,color: hsOne,fontSize: 14,letterSpacing: 0.5)),
                                    ],
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
                                child: Container(
                                  width: MediaQuery.of(context).size.width / 1.5,
                                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Superior Name",style: TextStyle(fontFamily: FontType.MontserratMedium,color: hsOne,fontSize: 16,letterSpacing: 0.5),),
                                      const SizedBox(height: 5,),
                                      Text("1234567890",style: TextStyle(fontFamily: FontType.MontserratRegular,color: hsOne,fontSize: 14,letterSpacing: 0.5)),
                                    ],
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
                                child: Container(
                                  width: MediaQuery.of(context).size.width / 1.5,
                                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Customer care",style: TextStyle(fontFamily: FontType.MontserratMedium,color: hsOne,fontSize: 16,letterSpacing: 0.5),),
                                      const SizedBox(height: 5,),
                                      Text("1234567890",style: TextStyle(fontFamily: FontType.MontserratRegular,color: hsOne,fontSize: 14,letterSpacing: 0.5)),
                                    ],
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
