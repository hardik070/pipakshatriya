import 'package:flutter/material.dart';
import 'package:pipakshatriya/dashboard.dart';
import'dart:async';
import 'createaccount.dart';
import 'package:flutter/services.dart';
import 'datamodels/datamanager/data_manager.dart';

class SplashScreen extends StatefulWidget{

  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>{

  @override
  void initState() {
    super.initState();

    Timer(Duration(milliseconds: 500), (){
      if(UserDataManager().currentUser?.loginInfo.token != null){
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => Dashboard())
        );
      }else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => CreateAccountWidget())
        );
      }
    });
  }

  @override
  Widget build(BuildContext context){
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // Your splash color
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
                child: Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Image.asset('assets/images/pipa_maharaj.png')
                )),
            CircularProgressIndicator()
          ],
        ),
      )
    );
  }

}