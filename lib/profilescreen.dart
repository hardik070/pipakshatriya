import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'editprofile.dart';
// import 'globalvariables.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'createaccount.dart';

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
                SizedBox(
                  width: 45,
                  height: 45,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      "https://imgs.search.brave.com/ek_J28ierOL93E0C7btwCHh1V0nZyPAKISxj654meLg/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9pbWcu/ZnJlZXBpay5jb20v/cHJlbWl1bS1waG90/by9jYXJ0b29uLWdp/cmwtd2l0aC1sb25n/LWhhaXItYm9vdHMt/c3RhbmRpbmctZnJv/bnQtd2hpdGUtYmFj/a2dyb3VuZC1nZW5l/cmF0aXZlLWFpXzkw/MDgzMy0zODA0My5q/cGc_c2VtdD1haXNf/aHlicmlk",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      //GlobalVariables().name.isNotEmpty ? GlobalVariables().name : 'Name',
                      "Hardik kumar",
                      style: GoogleFonts.openSans(
                        color: Color(0xFF666AC6),
                        fontWeight: FontWeight.w600,
                        fontSize: 20,

                      ),
                    ),
                    Text(
                      //GlobalVariables().course.isNotEmpty ? GlobalVariables().course : 'Course' ,
                      "Parmar",
                      style: GoogleFonts.poppins(
                        color: Color(0xFF666AC6),
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Container(
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
                          profileTile(/*GlobalVariables().name*/"Hardik kumar", "username", Icons.person),
                          Divider(color: Color(0x4FA6A9E3),thickness: 1, height: 25),
                          profileTile(/*GlobalVariables().name*/"Reva Ram", "Father Name", Icons.person),
                          Divider(color: Color(0x4FA6A9E3),thickness: 1, height: 25),
                          profileTile(/*GlobalVariables().email*/"hardikkumar2664@gmail.com", "E-mail", Icons.email_rounded),
                          Divider(color: Color(0x4FA6A9E3),thickness: 1, height: 25),
                          profileTile(/*GlobalVariables().number*/"9727264663", "Contact Number", Icons.call),
                          Divider(color: Color(0x4FA6A9E3),thickness: 1, height: 25),
                          profileTile(/*GlobalVariables().course*/"Parmar", "Gotra", Icons.book_rounded),
                          Divider(color: Color(0x4FA6A9E3),thickness: 1, height: 25),
                          profileTile(/*GlobalVariables().city*/"Daspa", "City", Icons.location_city_rounded),

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
                    // Container(
                    //   padding: EdgeInsets.all(15),
                    //   margin: EdgeInsets.only(top: 10,bottom: 10),
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(15),
                    //     color: Color(0xFF666AC6),
                    //   ),
                    //   child: Column(
                    //     children: [
                    //       SizedBox(
                    //         width: double.infinity,
                    //         height: 50,
                    //         child: Text(
                    //           "About Me",
                    //           style: GoogleFonts.poppins(
                    //             color: Colors.white,
                    //             fontWeight: FontWeight.w600,
                    //             fontSize: 18,
                    //             height: 1,
                    //           ),
                    //         ),
                    //       ),
                    //       profileTile(/*GlobalVariables().name*/"Hardik kumar", "username", Icons.person),
                    //       Divider(color: Color(0x4FA6A9E3),thickness: 1, height: 25),
                    //       profileTile(/*GlobalVariables().name*/"Reva Ram", "Father Name", Icons.person),
                    //       Divider(color: Color(0x4FA6A9E3),thickness: 1, height: 25),
                    //       profileTile(/*GlobalVariables().email*/"hardikkumar2664@gmail.com", "E-mail", Icons.email_rounded),
                    //       Divider(color: Color(0x4FA6A9E3),thickness: 1, height: 25),
                    //       profileTile(/*GlobalVariables().number*/"9727264663", "Contact Number", Icons.call),
                    //       Divider(color: Color(0x4FA6A9E3),thickness: 1, height: 25),
                    //       profileTile(/*GlobalVariables().course*/"Parmar", "Gotra", Icons.book_rounded),
                    //       Divider(color: Color(0x4FA6A9E3),thickness: 1, height: 25),
                    //       profileTile(/*GlobalVariables().city*/"Daspa", "City", Icons.location_city_rounded),
                    //
                    //     ],
                    //   ),
                    // ),
                    // Container(
                    //   padding: EdgeInsets.all(15),
                    //   margin: EdgeInsets.only(top: 10,bottom: 10),
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(15),
                    //     color: Color(0xFF666AC6),
                    //   ),
                    //   child: Column(
                    //     children: [
                    //       SizedBox(
                    //         width: double.infinity,
                    //         height: 50,
                    //         child: Text(
                    //           "My Relations",
                    //           style: GoogleFonts.poppins(
                    //             color: Colors.white,
                    //             fontWeight: FontWeight.w600,
                    //             fontSize: 18,
                    //             height: 1,
                    //           ),
                    //         ),
                    //       ),
                    //       profileTile(/*GlobalVariables().name*/"Dinesh", "Mama", Icons.person),
                    //       Divider(color: Color(0x4FA6A9E3),thickness: 1, height: 25),
                    //       profileTile(/*GlobalVariables().name*/"Mohan Darji", "Fufa", Icons.person),
                    //       Divider(color: Color(0x4FA6A9E3),thickness: 1, height: 25),
                    //       profileTile(/*GlobalVariables().name*/"Ashok", "Mama", Icons.person),
                    //       Divider(color: Color(0x4FA6A9E3),thickness: 1, height: 25),
                    //       profileTile(/*GlobalVariables().name*/"Babu Ji", "Fufa", Icons.person),
                    //       Divider(color: Color(0x4FA6A9E3),thickness: 1, height: 25),
                    //       profileTile(/*GlobalVariables().name*/"Babu Ji", "Mama", Icons.person),
                    //       Divider(color: Color(0x4FA6A9E3),thickness: 1, height: 25),
                    //       profileTile(/*GlobalVariables().name*/"Sawla Ji", "Fufa", Icons.person),
                    //       Divider(color: Color(0x4FA6A9E3),thickness: 1, height: 25),
                    //
                    //     ],
                    //   ),
                    // ),

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
                              //handleSignOut(context);
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