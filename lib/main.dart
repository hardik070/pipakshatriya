import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pipakshatriya/dashboard.dart';
import 'datamodels/contact.dart';
import 'datamodels/login_info.dart';
import 'datamodels/relationship.dart';
import 'datamodels/user_model.dart';

import 'package:firebase_core/firebase_core.dart';
import 'splashscreen.dart';
import 'datamodels/datamanager/data_manager.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();

  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(RelationshipAdapter());
  Hive.registerAdapter(LoginInfoAdapter());
  Hive.registerAdapter(ContactAdapter());

  await UserDataManager().init(); // 🔥 load user once
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
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

