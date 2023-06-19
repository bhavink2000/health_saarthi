import 'package:flutter/material.dart';
import '../../App Helper/Frontend Helper/Font & Color Helper/font_&_color_helper.dart';
import '../Login Screen/Login Widgets/fade_slide_transition.dart';
import '../Login Screen/login_screen.dart';

class HeaderSignUp extends StatelessWidget {
  var screenH;
  final Animation<double> animation;
  HeaderSignUp({Key? key,required this.animation,this.screenH}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: hsPaddingL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FadeSlideTransition(
                animation: animation,
                additionalOffset: 0.0,
                child: const Text(
                  'Sign Up \nHealth Saarthi',
                  style: TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 18),
                ),
              ),
              /*FadeSlideTransition(
                animation: animation,
                additionalOffset: 0.0,
                child: InkWell(
                  onTap: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => LoginScreen(screenH: screenH),
                      ),
                    );
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 14),
                  ),
                ),
              ),*/
            ],
          ),
          const SizedBox(height: hsSpaceS),
        ],
      ),
    );
  }
}
