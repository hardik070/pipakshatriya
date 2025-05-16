import 'package:flutter/material.dart';
import 'package:pipakshatriya/dashboard.dart';
import'dart:async';
import 'createaccount.dart';

class SplashScreen extends StatefulWidget{

  const SplashScreen({super.key});

  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>{

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 6), (){
      Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => Dashboard())
      );
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(

          )
        ],
      ),
    );
  }
}