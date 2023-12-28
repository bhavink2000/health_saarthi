import 'package:flutter/material.dart';
import '../../App Helper/Frontend Helper/Font & Color Helper/font_&_color_helper.dart';


class HeaderSignUp extends StatelessWidget {
  HeaderSignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
      child: Row(
        children: [
          IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_rounded)
          ),
          const Text(
            'Sign up',
            style: TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 18),
          ),
        ],
      ),
    );
  }
}
