import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'helper_widgets.dart';

class CommunityDiscovery extends StatefulWidget{
  const CommunityDiscovery({super.key});

  @override
  State<CommunityDiscovery> createState() => _CommunityDiscoveryState();
}

class _CommunityDiscoveryState extends State<CommunityDiscovery>{

  List<Map<String, String>> data = [
    {
      "Name" : "hardik kumar",
      "Village" : "Daspa"
    },
    {
      "Name" : "Reva Ram",
      "Village" : "Daspa"
    },
    {
      "Name": "shayam",
      "Village" : "suru"
    }
  ];

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Color(0xFF666AC6),
          ),
        ),
        title: Text(
          "Community",
          style: GoogleFonts.montserrat(
            //color: Color(0xfffffb00),
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF666AC6),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index){
          return PersonTile(
            name: data[index]["Name"]??'',
            gotra: data[index]["Village"]??'',
            fatherName: "hello", profilePic: "ll",
            userId: data[index]["userId"]??'',);
        },
      ),
    );
  }
}