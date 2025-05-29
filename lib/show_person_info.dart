import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'datamodels/datamanager/data_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ShowPersonInfo extends StatefulWidget{
  final String userId;
  @override
  const ShowPersonInfo({super.key, required this.userId});

  @override
  State<ShowPersonInfo> createState() => _ShowPersonInfo();
}

class _ShowPersonInfo extends State<ShowPersonInfo>{
  bool isDataLoading = true;
  Map<String, dynamic>? userInfo;

  @override
  void initState(){
    super.initState();
    _getUserInfo();
  }

  Future<void> _getUserInfo() async{
    try{
      DocumentSnapshot userData = await FirebaseFirestore.instance.collection("users").doc(widget.userId).get();
      userInfo = userData.data() as Map<String, dynamic>?;

      setState(() {
        isDataLoading = false;
      });
    }catch (e){
      setState(() {
        isDataLoading = false;
      });
    }
  }
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back_ios_new_rounded)
        ),
      ),
      body: SafeArea(
        child: isDataLoading ? Center(child: CircularProgressIndicator(),)
            :
        Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [

                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CachedNetworkImage(
                    imageUrl: userInfo?["profilePic"] ?? '',
                    placeholder: (context, url) =>const CircleAvatar(
                        radius: 100,
                        //backgroundImage: uploadedImageUrl != null ? FileImage(_profileImage!) : null,
                        child: Icon(Icons.person, size: 30, color: Color(0xFF666AC6))
                    ),
                    errorWidget: (context, url, error) =>const CircleAvatar(
                      radius: 100,
                      //backgroundImage: _profileImage != null ? FileImage(_profileImage!) : null,
                      child: Icon(Icons.person, size: 30, color: Color(0xFF666AC6)),
                    ),
                    fit: BoxFit.cover,
                    width: 100,
                    height: 100,
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      //GlobalVariables().name.isNotEmpty ? GlobalVariables().name : 'Name',
                      userInfo?["name"] ?? '',
                      style: GoogleFonts.openSans(
                          color: Color(0xFF666AC6),
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          height: 1.3
                      ),
                    ),
                    Text(
                      //GlobalVariables().course.isNotEmpty ? GlobalVariables().course : 'Course' ,
                      userInfo?["fatherName"] ?? '',
                      style: GoogleFonts.poppins(
                        color: Color(0xFF666AC6),
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}