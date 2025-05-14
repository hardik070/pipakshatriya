import 'package:flutter/material.dart';
import 'dashboard.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Pipa());
}

class Pipa extends StatelessWidget {
  const Pipa( {super.key} );

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: "Pipa Kshatriya",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xff001e59)),
        useMaterial3: true,
      ),
      home: Dashboard(),
      debugShowCheckedModeBanner: false,
    );
  }
}

