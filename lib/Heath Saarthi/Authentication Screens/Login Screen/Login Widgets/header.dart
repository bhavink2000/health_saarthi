import 'package:flutter/material.dart';
import '../../../App Helper/Frontend Helper/Font & Color Helper/font_&_color_helper.dart';
import 'fade_slide_transition.dart';

class Header extends StatelessWidget {
  final Animation<double> animation;

  const Header({Key? key, 
    required this.animation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: hsPaddingL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FadeSlideTransition(
            animation: animation,
            additionalOffset: 0.0,
            child: const Text(
              'Welcome to \nHealth Saarthi',
              style: TextStyle(fontFamily: FontType.MontserratMedium,fontSize: 25)
            ),
          ),
          const SizedBox(height: hsSpaceS),
          FadeSlideTransition(
            animation: animation,
            additionalOffset: 16.0,
            child: const Text(
              'Declare the past, diagnose the present, foretell the future.',
              style: TextStyle(fontFamily: FontType.MontserratRegular,fontSize: 16)
            ),
          ),
        ],
      ),
    );
  }
}
