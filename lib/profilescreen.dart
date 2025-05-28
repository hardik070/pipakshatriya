import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'datamodels/datamanager/data_manager.dart';
import 'createaccount.dart';
import 'editprofile.dart';
import 'package:cached_network_image/cached_network_image.dart';


class ProfileManage extends StatefulWidget{
  const ProfileManage({super.key});
  @override
  ProfileManageState createState() => ProfileManageState();
}

class ProfileManageState extends State<ProfileManage>{

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

  var user;

  @override
  void initState() {
    super.initState();
    user = UserDataManager().currentUser;
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
            const SizedBox(height: 30),
            Row(
              children: [

                ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: CachedNetworkImage(
                    imageUrl: user.profilePic,
                    placeholder: (context, url) =>const CircleAvatar(
                        radius: 60,
                        //backgroundImage: uploadedImageUrl != null ? FileImage(_profileImage!) : null,
                        child: Icon(Icons.person, size: 30, color: Color(0xFF666AC6))
                    ),
                    errorWidget: (context, url, error) =>const CircleAvatar(
                      radius: 60,
                      //backgroundImage: _profileImage != null ? FileImage(_profileImage!) : null,
                      child: Icon(Icons.person, size: 30, color: Color(0xFF666AC6)),
                    ),
                    fit: BoxFit.cover,
                    width: 50,
                    height: 50,
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      //GlobalVariables().name.isNotEmpty ? GlobalVariables().name : 'Name',
                      user.name,
                      style: GoogleFonts.openSans(
                        color: Color(0xFF666AC6),
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        height: 1.3
                      ),
                    ),
                    Text(
                      //GlobalVariables().course.isNotEmpty ? GlobalVariables().course : 'Course' ,
                      user.fatherName,
                      style: GoogleFonts.poppins(
                        color: Color(0xFF666AC6),
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () async{
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => EditProfile()
                        )
                    );
                    setState(() {});
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
                    //about me
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
                          profileTile(user.name, "username", Icons.person),
                          Divider(color: Color(0x4FA6A9E3),thickness: 1, height: 25),
                          profileTile(user.fatherName, "Father Name", Icons.person),
                          Divider(color: Color(0x4FA6A9E3),thickness: 1, height: 25),
                          profileTile(user.email, "E-mail", Icons.email_rounded),
                          Divider(color: Color(0x4FA6A9E3),thickness: 1, height: 25),
                          profileTile(user.gotra, "Gotra", Icons.book_rounded),
                          Divider(color: Color(0x4FA6A9E3),thickness: 1, height: 25),
                          profileTile(user.actualAddress, "Address", Icons.location_city_rounded),
                          Divider(color: Color(0x4FA6A9E3),thickness: 1, height: 25),
                          profileTile(user.currentAddress , "Current Living Address", Icons.location_city_rounded),
                        ],
                      ),
                    ),
                    //contact
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
                              "Contact",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                height: 1,
                              ),
                            ),
                          ),
                          ...user.phoneNumber.asMap().entries.map((item) {
                            int index = item.key;

                            return Column(
                              children: [
                                index == 0 ? Container() : const Divider(color: Color(0x4FA6A9E3),thickness: 1, height: 25),
                                profileTile(item.value, "Contact Number", Icons.call),
                              ],
                            );
                          }
                          ),

                       ],
                      ),
                    ),
                    //relationships
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
                          ...user.relationships.asMap().entries.map((item) {
                            int index = item.key;
                            String relationType = item.value.keys.first;
                            String relative = item.value.values.first;
                            return Column(
                              children: [
                                index == 0 ? Container() : const Divider(color: Color(0x4FA6A9E3),thickness: 1, height: 25),
                                profileTile(relative, relationType, Icons.person),
                              ],
                            );
                          }),
                        ],
                      ),
                    ),
                    //help & support
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
                              "Help & Support",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                height: 1,
                              ),
                            ),
                          ),
                          profileTile("hardikkumar2664@gmail.com", "Email", Icons.email_rounded),
                          Divider(color: Color(0x4FA6A9E3),thickness: 1, height: 25),
                          profileTile("9727264663", "Whatsapp", Icons.call),
                          Divider(color: Color(0x4FA6A9E3),thickness: 1, height: 25),
                          MessageInputWidget()
                        ],
                      ),
                    ),
                    //logout
                    Padding(
                      padding: EdgeInsets.only(top: 50, bottom: 130),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.logout_rounded,
                            size: 35,
                            color: Color(0xFF666AC6),
                          ),
                          SizedBox(width: 10),
                          GestureDetector(
                            onTap: () async {

                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => CreateAccountWidget()
                                  )
                              );

                              await UserDataManager().clearUserData();
                            },
                            child:const Text(
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
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
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
      const SizedBox(width: 10),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.isNotEmpty ? title.split("(S-o)")[0].trim() : subtitle,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 15,
            ),
          ),
          Text(
            subtitle,
            style: GoogleFonts.poppins(
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

class MessageInputWidget extends StatefulWidget {
  const MessageInputWidget({super.key});

  @override
  MessageInputWidgetState createState() => MessageInputWidgetState();
}

class MessageInputWidgetState extends State<MessageInputWidget> {
  TextEditingController? _feedbackController;

  bool isFeedBackFormActive = false;

  void wantsToGiveFeedback(){
    if (_feedbackController != null) return;

    _feedbackController = TextEditingController();

    setState(() {
      isFeedBackFormActive = true;
    });
  }


  void onSubmit(){
    _feedbackController!.dispose();
    _feedbackController = null;

    setState(() {
      isFeedBackFormActive = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isFeedBackFormActive ?
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 37,
          width: 37,
          decoration: BoxDecoration(
              color: Color(0xfffffb00),
              borderRadius: BorderRadius.circular(8)
          ),
          child: Icon(
            Icons.feedback_rounded,
            color: Color(0xff0a0147),
            size: 22,
          ),
        ),
        SizedBox(width: 10,),
        Expanded(
          child: TextField(
            controller: _feedbackController,
            decoration: InputDecoration(
              constraints: BoxConstraints(
                maxWidth: 300, // Maximum width
                maxHeight: 150, // Maximum height
              ),
              hintText: "Give feedback...",
              hintStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                  fontSize: 17),
              filled: true,
              fillColor: const Color(0x7F23255D),
              contentPadding: const EdgeInsets.symmetric(
                  vertical: 5, horizontal: 20),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide.none,
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _feedbackController!.clear();
                  });
                },
                icon: const Icon(Icons.close_rounded),
                color: Colors.white54,
              ),
            ),
            onChanged: (value) {

            },
            keyboardType: TextInputType.multiline,
            maxLines: null,
            style: const TextStyle(
              fontSize: 16,
              fontFamily: 'Inter',
              color: Colors.white,
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.send_rounded, size: 35),
          color: Colors.white,
          onPressed: () {
            onSubmit();
          },
        ),
      ],
    )
        :
    GestureDetector(
      onTap: () {
        wantsToGiveFeedback();
      },
      child: Row(
        children: [
          profileTile("Give Feedback", "Write", Icons.feedback_rounded),
          Spacer(),
          Icon(
            Icons.edit_rounded,
            color: Colors.white,
            size: 20,
          ),
        ],
      )
    );
  }
}