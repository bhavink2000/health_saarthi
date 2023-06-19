// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Blocs/Internet%20Bloc/internet_bloc.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Blocs/Internet%20Bloc/internet_state.dart';
import '../../App Helper/Backend Helper/Models/Authentication Models/login_model.dart';
import '../../App Helper/Backend Helper/Providers/Authentication Provider/user_data_auth_session.dart';
import '../../App Helper/Frontend Helper/Font & Color Helper/font_&_color_helper.dart';
import '../../DashBoard/hs_dashboard.dart';
import '../Login Screen/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  bool internetCheck = false;

  Future<LoginModel> getUserData() => UserDataSession().getUserData();

  @override
  void initState() {
    super.initState();
    checkAuthentication(context);
  }

  void checkAuthentication(BuildContext context)async{

    getUserData().then((value)async{
      print("Access Token => ${value.accessToken}");
      if(value.accessToken == "null"){
        await Future.delayed(const Duration(seconds: 3));
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()),);
      }
      else{
        await Future.delayed(const Duration(seconds: 3));
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()),);
      }
    }).onError((error, stackTrace){
      print(error);
    });
  }
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    print("Mobile Screen Width -> $screenWidth and Height -> $screenHeight");
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<InternetBloc, InternetState>(
        listener: (context, state){
          if(state is InternetGainedState){
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: Colors.green,
                content: Text("Internet Connected",style: TextStyle(fontFamily: FontType.MontserratMedium,color: Colors.white),)
              )
            );
          }
          else if(state is InternetLostState){
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    backgroundColor: Colors.red,
                    content: Text("Internet Not Connected",style: TextStyle(fontFamily: FontType.MontserratMedium,color: Colors.white),)
                )
            );
          }
          else{
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    backgroundColor: Colors.orange,
                    content: Text("Internet Loading",style: TextStyle(fontFamily: FontType.MontserratMedium,color: Colors.white),)
                )
            );
          }
        },
        builder: (context, state){
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: const Padding(
              padding: EdgeInsets.all(15),
              child: Image(
                image: AssetImage("assets/Gif/HS_Blood test_GIF.gif"),
              ),
            ),
          );
        },
      ),
    );
  }
}
