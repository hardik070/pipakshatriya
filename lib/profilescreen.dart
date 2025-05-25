import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'datamodels/datamanager/data_manager.dart';
import 'createaccount.dart';
import 'editprofile.dart';
import 'package:cached_network_image/cached_network_image.dart';


class profileManage extends StatefulWidget{

  @override
  _profileManageState createState() => _profileManageState();
}

class _profileManageState extends State<profileManage>{

  // Future<void> handleSignOut(BuildContext context) async {
  //   await FirebaseAuth.instance.signOut();
  //   // Clear all shared preferences data
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.clear();
  //
  //   // Clear screen stack and navigate to login screen
  //   Navigator.pushAndRemoveUntil(
  //     context,
  //     MaterialPageRoute(builder: (context) => CreateAccountWidget()),
  //         (route) => false, // This removes all routes from the stack
  //   );
  // }

  String profilePicUrl = '';

  void initState(){
    super.initState();
    profilePicUrl = UserDataManager().currentUser?.profilePic ?? '';
  }

  Future<void> editProfileStatus() async{
    profilePicUrl = UserDataManager().currentUser?.profilePic ?? '';
  }


  @override
  Widget build(BuildContext context){
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            Row(
              children: [
                profilePicUrl.isNotEmpty ?
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CachedNetworkImage(
                    imageUrl: profilePicUrl,
                    placeholder: (context, url) => CircleAvatar(
                        radius: 60,
                        //backgroundImage: uploadedImageUrl != null ? FileImage(_profileImage!) : null,
                        child: Icon(Icons.person, size: 30, color: Color(0xFF666AC6))
                    ),
                    errorWidget: (context, url, error) => CircleAvatar(
                      radius: 60,
                      child: Icon(Icons.error, size: 30, color: Color(0xFF666AC6)),
                    ),
                    fit: BoxFit.cover,
                    width: 50,
                    height: 50,
                  ),
                )
                    :
                SizedBox(height: 50, width: 50, child: CircleAvatar(
                    radius: 60,
                  //backgroundImage: _profileImage != null ? FileImage(_profileImage!) : null,
                  child: Icon(Icons.person, size: 30, color: Color(0xFF666AC6)),
                ),),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      //GlobalVariables().name.isNotEmpty ? GlobalVariables().name : 'Name',
                      UserDataManager().currentUser?.name ?? "Name",
                      style: GoogleFonts.openSans(
                        color: Color(0xFF666AC6),
                        fontWeight: FontWeight.w600,
                        fontSize: 20,

                      ),
                    ),
                    Text(
                      //GlobalVariables().course.isNotEmpty ? GlobalVariables().course : 'Course' ,
                      UserDataManager().currentUser?.userId ?? "User Id",
                      style: GoogleFonts.poppins(
                        color: Color(0xFF666AC6),
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () async{
                    final bool status = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => EditProfile()
                        )
                    );

                    if(status){
                     await editProfileStatus();
                      setState(() {});
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Color(0xFF23255D),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: const Icon(
                      Icons.edit_rounded,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 15),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(15),
                      margin: EdgeInsets.only(top: 10,bottom: 10),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF4A3274),
                            Color(0xFF4D5CBF),
                            Color(0xFF5C4D91)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x57ff3456),
                            blurRadius: 5,
                            offset: Offset(0, 2),
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: Text(
                              "About Me",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                height: 1,
                              ),
                            ),
                          ),
                          profileTile(UserDataManager().currentUser?.name ?? "Username", "username", Icons.person),
                          Divider(color: Color(0x4FA6A9E3),thickness: 1, height: 25),
                          profileTile(UserDataManager().currentUser?.fatherName ?? "Father name", "Father Name", Icons.person),
                          Divider(color: Color(0x4FA6A9E3),thickness: 1, height: 25),
                          profileTile(UserDataManager().currentUser?.email ?? "Email", "E-mail", Icons.email_rounded),
                          Divider(color: Color(0x4FA6A9E3),thickness: 1, height: 25),
                          profileTile(UserDataManager().currentUser?.phoneNumber.toString() ?? "Contact", "Contact Number", Icons.call),
                          Divider(color: Color(0x4FA6A9E3),thickness: 1, height: 25),
                          profileTile(UserDataManager().currentUser?.gotra ?? "Gotra", "Gotra", Icons.book_rounded),
                          Divider(color: Color(0x4FA6A9E3),thickness: 1, height: 25),
                          profileTile(UserDataManager().currentUser?.actualAddress ?? "City", "Address", Icons.location_city_rounded),
                          Divider(color: Color(0x4FA6A9E3),thickness: 1, height: 25),
                          profileTile(UserDataManager().currentUser?.currentAddress ?? "Current City", "Current Living Address", Icons.location_city_rounded),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(15),
                      margin: EdgeInsets.only(top: 10,bottom: 10),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF4A3274),
                            Color(0xFF4D5CBF),
                            Color(0xFF5C4D91)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x57ff3456),
                            blurRadius: 5,
                            offset: Offset(0, 2),
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: Text(
                              "My Relations",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                height: 1,
                              ),
                            ),
                          ),
                          profileTile(/*GlobalVariables().name*/"Dinesh", "Mama", Icons.person),
                          Divider(color: Color(0x4FA6A9E3),thickness: 1, height: 25),
                          profileTile(/*GlobalVariables().name*/"Mohan Darji", "Fufa", Icons.person),
                          Divider(color: Color(0x4FA6A9E3),thickness: 1, height: 25),
                          profileTile(/*GlobalVariables().name*/"Ashok", "Mama", Icons.person),
                          Divider(color: Color(0x4FA6A9E3),thickness: 1, height: 25),
                          profileTile(/*GlobalVariables().name*/"Babu Ji", "Fufa", Icons.person),
                          Divider(color: Color(0x4FA6A9E3),thickness: 1, height: 25),
                          profileTile(/*GlobalVariables().name*/"Babu Ji", "Mama", Icons.person),
                          Divider(color: Color(0x4FA6A9E3),thickness: 1, height: 25),
                          profileTile(/*GlobalVariables().name*/"Sawla Ji", "Fufa", Icons.person),

                        ],
                      ),
                    ),

                    SizedBox(
                      height: 150,
                      child: Row(
                        children: [
                          Icon(
                            Icons.logout_rounded,
                            size: 35,
                            color: Color(0xFF666AC6),
                          ),
                          SizedBox(width: 10),
                          GestureDetector(
                            onTap: () async {
                              await UserDataManager().clearUserData();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => CreateAccountWidget()
                                )
                              );
                            },
                            child: Text(
                              "Log out",
                              style: TextStyle(
                                color: Color(0xFF666AC6),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget profileTile(String title, String subtitle, final icon){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: 37,
          width: 37,
          decoration: BoxDecoration(
            color: Color(0xfffffb00),
            borderRadius: BorderRadius.circular(8)
          ),
          child: Icon(
            icon,
            color: Color(0xff0a0147),
            size: 22,
          ),
        ),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title.isNotEmpty ? title : subtitle,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 15,
              ),
            ),
            Text(
              subtitle,
              style: TextStyle(
                color: Colors.white60,
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ],
    );
  }
}