import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../App Helper/Check Internet Helper/Bindings/dependency_injection.dart';
import '../../App Helper/Frontend Helper/Font & Color Helper/font_&_color_helper.dart';
import '../../App Helper/Getx Helper/Auth Getx/login_auth_getx.dart';
import 'Login Widgets/custom_clippers/blue_top_clipper.dart';
import 'Login Widgets/custom_clippers/grey_top_clipper.dart';
import 'Login Widgets/custom_clippers/white_top_clipper.dart';
import 'Login Widgets/header.dart';
import 'Login Widgets/login_form.dart';

class LoginScreen extends StatefulWidget {
  var screenH;
  LoginScreen({Key? key,this.screenH}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin{
  AnimationController? _animationController;
  late Animation<double> _headerTextAnimation;
  late Animation<double> _formElementAnimation;
  late Animation<double> _whiteTopClipperAnimation;
  late Animation<double> _blueTopClipperAnimation;
  late Animation<double> _greyTopClipperAnimation;


  final controller = Get.put(LoginController());

  @override
  void initState() {
    super.initState();
    CheckNetworkDependencyInjection.init();
    _animationController = AnimationController(
      vsync: this,
      duration: hsLoginAnimationD,
    );

    final fadeSlideTween = Tween<double>(begin: 0.0, end: 1.0);
    _headerTextAnimation = fadeSlideTween.animate(CurvedAnimation(
      parent: _animationController!,
      curve: const Interval(
        0.0,
        0.6,
        curve: Curves.easeInOut,
      ),
    ));
    _formElementAnimation = fadeSlideTween.animate(CurvedAnimation(
      parent: _animationController!,
      curve: const Interval(
        0.7,
        1.0,
        curve: Curves.easeInOut,
      ),
    ));

    final double defaultScreenH = 600.0; // Provide a default value here
    final clipperOffsetTween = Tween<double>(
      begin: widget.screenH ?? defaultScreenH,
      end: 0.0,
    );
    _blueTopClipperAnimation = clipperOffsetTween.animate(
      CurvedAnimation(
        parent: _animationController!,
        curve: const Interval(
          0.2,
          0.7,
          curve: Curves.easeInOut,
        ),
      ),
    );
    _greyTopClipperAnimation = clipperOffsetTween.animate(
      CurvedAnimation(
        parent: _animationController!,
        curve: const Interval(
          0.35,
          0.7,
          curve: Curves.easeInOut,
        ),
      ),
    );
    _whiteTopClipperAnimation = clipperOffsetTween.animate(
      CurvedAnimation(
        parent: _animationController!,
        curve: const Interval(
          0.5,
          0.7,
          curve: Curves.easeInOut,
        ),
      ),
    );
    _animationController!.forward();
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: hsWhite,
      body: Stack(
        children: <Widget>[
          AnimatedBuilder(
            animation: _whiteTopClipperAnimation,
            builder: (_, Widget? child) {
              return ClipPath(
                clipper: WhiteTopClipper(
                  yOffset: _whiteTopClipperAnimation.value,
                ),
                child: child,
              );
            },
            child: Container(color: hsGrey),
          ),
          AnimatedBuilder(
            animation: _greyTopClipperAnimation,
            builder: (_, Widget? child) {
              return ClipPath(
                clipper: GreyTopClipper(
                  yOffset: _greyTopClipperAnimation.value,
                ),
                child: child,
              );
            },
            child: Container(color: hsPrime),
          ),
          AnimatedBuilder(
            animation: _blueTopClipperAnimation,
            builder: (_, Widget? child) {
              return ClipPath(
                clipper: BlueTopClipper(
                  yOffset: _blueTopClipperAnimation.value,
                ),
                child: child,
              );
            },
            child: Container(color: hsWhite),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: hsPaddingL),
              child: Column(
                children: <Widget>[
                  Header(animation: _headerTextAnimation),
                  SizedBox(height: 170.h),
                  LoginForm(animation: _formElementAnimation,screenH: widget.screenH),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
