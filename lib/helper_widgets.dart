import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'show_person_info.dart';
class CityTile extends StatelessWidget{
  final String city;
  final String state;

  const CityTile({
    super.key,
    required this.city,
    required this.state,
  });

  @override
  Widget build(BuildContext context){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              city,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 18,
                color: Color(0xFF23255D),
              )
          ),
          Text(
              state,
              style: GoogleFonts.poppins(
                //fontWeight: FontWeight.w400,
                fontSize: 12,
                color: Color(0xDF23255D),
              )
          ),
        ],
      ),
    );
  }
}

class PersonTile extends StatelessWidget {
  final String name;
  final String gotra;
  final String fatherName;
  final String profilePic;
  final String userId;

  const PersonTile({
    required this.name,
    required this.gotra,
    required this.fatherName,
    required this.profilePic,
    required this.userId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ShowPersonInfo(userId: userId)
          )
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 7),
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xE2FFFFFF), Color(0xFFFFFFFF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: Colors.white24),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 20,
              offset: const Offset(0, 10),
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => showImageFullScreen(context, profilePic),
              child: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: profilePic,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                    const CircleAvatar(child: Icon(Icons.person)),
                    errorWidget: (context, url, error) =>
                    const CircleAvatar(child: Icon(Icons.error)),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10), // space for image overlap
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF23255D),
                    ),
                  ),

                  Text(
                    '$fatherName • $gotra',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Color(0xFF23255D),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                // add message tap here
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF666AC6), // soft purple-blue
                      Color(0xFF23255D), // deep navy
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: const Text(
                  "Message",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class FloatButton extends StatefulWidget {
  //final VoidCallback onRefresh; // Add callback parameter

 // FloatButton({required this.onRefresh}); // Constructor to accept the callback

  const FloatButton({super.key});

  @override
  State<FloatButton> createState() => _FloatButtonState();
}
class _FloatButtonState extends State<FloatButton> {
  bool floatButton = false;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(0.85, 0.93),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (floatButton) ...[
            GestureDetector(
              // onTap: () async {
              //   if(GlobalVariables().name.isNotEmpty){
              //     bool? updated = await Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (context) => createPostPoll()),
              //     );
              //
              //     // Rebuild the screen if profile was updated
              //     if (updated == true) {
              //       widget.onRefresh(); // Call the refresh callback
              //     }
              //   } else {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (context) => EditProfile()),
              //     );
              //     ScaffoldMessenger.of(context).showSnackBar(
              //       const SnackBar(
              //         content: Text('Before posting anything, first complete your profile'),
              //         backgroundColor: Color(0xe70b0378),
              //         duration: Duration(milliseconds: 1500),
              //       ),
              //     );
              //   }
              // },
              child: const Card(
                color: Color(0xFF23255D),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                  child: Text("Poll", style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
            GestureDetector(
              // onTap: () async {
              //   if(GlobalVariables().name.isNotEmpty){
              //     bool? updated = await Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (context) => CreateQuiz()),
              //     );
              //
              //     // Rebuild the screen if profile was updated
              //     if (updated == true) {
              //       widget.onRefresh(); // Call the refresh callback
              //     }
              //   } else {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (context) => EditProfile()),
              //     );
              //     ScaffoldMessenger.of(context).showSnackBar(
              //       const SnackBar(
              //         content: Text('Before posting anything, first complete your profile'),
              //         backgroundColor: Color(0xe70b0378),
              //         duration: Duration(milliseconds: 1500),
              //       ),
              //     );
              //   }
              // },
              child: const Card(
                color: Color(0xFF23255D),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                  child: Text("Question", style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
            GestureDetector(
              // onTap: () async {
              //   await Navigator.push(
              //     context,
              //     MaterialPageRoute(builder: (context) => MyActivity()),
              //   );
              //   widget.onRefresh(); // Call the refresh callback
              //
              // },
              child: const Card(
                color: Color(0xFF23255D),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                  child: Text("My Activity", style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
          ],
          FloatingActionButton(
            onPressed: (){
              setState(() {
                floatButton = !floatButton;
              });
            },
            backgroundColor: Color(0xFF23255D),
            child: const Icon(
              Icons.add_rounded,
              color: Colors.white,
              size: 40,
            ),
          )
        ],
      ),
    );
  }
}


class QuizWidget extends StatefulWidget {
  final Function updatedShared;
  final bool identityIsShow;
  final String question;
  final List<String> options;
  final int correctAnswerIndex;
  final String image;
  final String name;
  final String course;
  final String quizID;
  final int mySelection;
  final bool singleTime;
  final String userid;
  final bool viewResult;
  final bool delete;
  final String time;
  const QuizWidget({
    super.key,
    required this.updatedShared,
    required this.image,
    required this.name,
    required this.course,
    required this.identityIsShow,
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
    required this.quizID,
    required this.mySelection,
    required this.singleTime,
    required this.userid,
    required this.viewResult,
    required this.delete,
    required this.time
  }) ;

  @override
  State<QuizWidget> createState() => _QuizWidgetState();
}
class _QuizWidgetState extends State<QuizWidget> {

  bool showAnswer = false;
  int lastSelection = -1;

  @override
  void initState() {
    super.initState();
    lastSelection = widget.mySelection;
  }

  // void _storeUserAnswer(int idx, int lastSelection) async{
  //
  //
  //   await FirebaseFirestore.instance.collection('shared')
  //       .doc(widget.quizID)
  //       .update(
  //       {
  //         'answers'+'.'+GlobalVariables().userid : idx
  //       }
  //   );
  //
  //
  //   await FirebaseFirestore.instance.collection('shared')
  //       .doc(widget.quizID)
  //       .collection('response')
  //       .doc('$idx')
  //       .update(
  //       {
  //         GlobalVariables().userid : {
  //           'responseTime' : FieldValue.serverTimestamp(),
  //           'selection' : idx,
  //           'name' : GlobalVariables().name,
  //           'course' : GlobalVariables().course
  //         },
  //       }
  //   );
  //
  //   if(lastSelection != -1){
  //     await FirebaseFirestore.instance.collection('shared')
  //         .doc(widget.quizID)
  //         .collection('response')
  //         .doc('$lastSelection')
  //         .update(
  //         {
  //           GlobalVariables().userid : FieldValue.delete()
  //         }
  //     );
  //   }
  //
  //   await FirebaseFirestore.instance.collection('users')
  //       .doc(GlobalVariables().userid)
  //       .collection('myActivity')
  //       .doc('response')
  //       .update(
  //       {
  //         widget.quizID : {
  //           'responseTime' : FieldValue.serverTimestamp(),
  //           'selection' : idx
  //         },
  //       }
  //   );
  // }
  //
  // void _showDeleteConfirmationDialog(BuildContext context) {
  //   showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: Text("Delete Post"),
  //           content: Text("Are you sure you want to delete this post?"),
  //           actions: <Widget>[
  //             TextButton(
  //               child: Text("Cancel"),
  //               onPressed: () {
  //                 Navigator.of(context).pop(); // Close the dialog
  //               },
  //             ),
  //             TextButton(
  //               child: Text("Delete"),
  //               onPressed: () {
  //                 deletePost(widget.quizID); // Call your delete function
  //                 widget.updatedShared(widget.quizID);
  //                 Navigator.of(context).pop(); // Close the dialog after deletion
  //               },
  //             ),
  //           ],
  //         );
  //       }
  //   );
  // }


  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 12,left: 7, right: 7, bottom: 2),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 5),
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
              const BoxShadow(
                color: Color(0x57ff3456),
                blurRadius: 5,
                offset: Offset(0, 2),
              )
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if(!widget.identityIsShow || widget.delete)
                GestureDetector(
                  // onTap: () {
                  //   GlobalVariables().name.isNotEmpty ? GlobalVariables().userid != widget.userid ? Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (context) => MessageWidget(receiverId: widget.userid, receiverName: widget.name, newMessage: '',)
                  //       )
                  //   ) : null
                  //       : {
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => EditProfile()
                  //         )
                  //     ),
                  //     ScaffoldMessenger.of(context).showSnackBar(
                  //       const SnackBar(
                  //         content: Text('To message anyone, frist complet your profile.'),
                  //         backgroundColor: Color(0xe70b0378),
                  //         duration: Duration(milliseconds: 1500),
                  //       ),
                  //     )
                  //   };
                  // },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Container(
                      //   width: 45.0,
                      //   height: 45.0,
                      //   clipBehavior: Clip.antiAlias,
                      //   decoration: BoxDecoration(
                      //     shape: BoxShape.circle,
                      //   ),
                      //   child: CachedNetworkImage(
                      //     imageUrl: GlobalVariables().gender?
                      //     "https://imgs.search.brave.com/ek_J28ierOL93E0C7btwCHh1V0nZyPAKISxj654meLg/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9pbWcu/ZnJlZXBpay5jb20v/cHJlbWl1bS1waG90/by9jYXJ0b29uLWdp/cmwtd2l0aC1sb25n/LWhhaXItYm9vdHMt/c3RhbmRpbmctZnJv/bnQtd2hpdGUtYmFj/a2dyb3VuZC1nZW5l/cmF0aXZlLWFpXzkw/MDgzMy0zODA0My5q/cGc_c2VtdD1haXNf/aHlicmlk"
                      //         :
                      //     "https://imgs.search.brave.com/Zz7rIOCJbxFVbkrRHGPdpNUfsyd6wne8UTisdu-3pV0/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9pbWcu/ZnJlZXBpay5jb20v/cHJlbWl1bS1waG90/by9jYXJ0b29uLWJv/eS13aXRoLWdyZWVu/LWV5ZXMtYmx1ZS1z/aGlydF8xMDI4ODgy/LTEwNjI2MC5qcGc_/c2VtdD1haXNfaHli/cmlk",
                      //
                      //
                      //     // Loading indicator
                      //     placeholder: (context, url) => CircularProgressIndicator(),
                      //
                      //     // Error widget
                      //     errorWidget: (context, url, error) => Icon(Icons.error, color: Colors.red),
                      //
                      //     // Custom cache key (optional)
                      //     cacheKey: GlobalVariables().gender?
                      //     "https://imgs.search.brave.com/ek_J28ierOL93E0C7btwCHh1V0nZyPAKISxj654meLg/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9pbWcu/ZnJlZXBpay5jb20v/cHJlbWl1bS1waG90/by9jYXJ0b29uLWdp/cmwtd2l0aC1sb25n/LWhhaXItYm9vdHMt/c3RhbmRpbmctZnJv/bnQtd2hpdGUtYmFj/a2dyb3VuZC1nZW5l/cmF0aXZlLWFpXzkw/MDgzMy0zODA0My5q/cGc_c2VtdD1haXNf/aHlicmlk"
                      //         :
                      //     "https://imgs.search.brave.com/Zz7rIOCJbxFVbkrRHGPdpNUfsyd6wne8UTisdu-3pV0/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9pbWcu/ZnJlZXBpay5jb20v/cHJlbWl1bS1waG90/by9jYXJ0b29uLWJv/eS13aXRoLWdyZWVu/LWV5ZXMtYmx1ZS1z/aGlydF8xMDI4ODgy/LTEwNjI2MC5qcGc_/c2VtdD1haXNfaHli/cmlk",
                      //
                      //
                      //     // Image properties
                      //     fit: BoxFit.cover,
                      //   ),
                      // ),
                      SizedBox(width: 7),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.name,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 20.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                height: 1,
                              ),
                            ),
                            Text(
                              widget.course,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12.0,
                                color: Colors.white54,
                              ),
                            ),
                          ],
                        ),
                      ),
                      widget.delete ?
                      IconButton(
                        onPressed: () {
                          //_showDeleteConfirmationDialog(context);
                          },
                        icon: Icon(Icons.delete),
                        color: Colors.white,
                      ) :
                      Text(
                          "Quiz",
                          style: TextStyle(
                              fontSize: 24,
                              color: Colors.white54,
                              fontWeight: FontWeight.w600
                          )
                      ),

                    ],
                  ),
                ),
              if(!widget.identityIsShow || widget.delete)
                Divider(
                  thickness: 3.0,
                  // indent: 30.0,
                  // endIndent: 30.0,
                  height: 30,
                  color: Color(0x86805CBD),
                ),
              // Question Text
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "🙋‍♀️ ",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Expanded(child: Text(
                    widget.question,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  )),
                ],
              ),
              const SizedBox(height: 12),
              // Options List
              ...widget.options.asMap().entries.map((entry) {
                int index = entry.key;
                String option = entry.value;


                Color backgroundColor = widget.mySelection != index ? Colors.white.withAlpha((0.15 * 255).toInt()) :
                widget.mySelection == widget.correctAnswerIndex ?
                Colors.green : const Color(0xFFFE854F);



                if(showAnswer){
                  if(index == widget.correctAnswerIndex){
                    backgroundColor = Colors.green;
                  }
                }

                // if (showAnswer) {
                //   backgroundColor = index == widget.correctAnswerIndex
                //       ? Colors.green
                //       : (index == selectedOptionIndex ? const Color(0xFFFE854F) : backgroundColor);
                // } else if ((index == selectedOptionIndex) && (widget.correctAnswerIndex == selectedOptionIndex)) {
                //   backgroundColor = Colors.green;
                // }

                return GestureDetector(
                  // onTap: () {
                  //   widget.singleTime == false ?
                  //   GlobalVariables().name.isNotEmpty ?
                  //   setState(() {
                  //     lastSelection = widget.mySelection;
                  //     widget.mySelection = index;
                  //     lastSelection != index ?  _storeUserAnswer(index, lastSelection) : null;
                  //     //widget.correctAnswerIndex != -1 ? showAnswer = true : showAnswer = false;// Automatically show the answer on selection
                  //   })
                  //       :
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //       SnackBar(
                  //         backgroundColor: Color(0xe70b0378),
                  //         content: Text("Frist complet your profile"),
                  //         duration: Duration(milliseconds: 500),
                  //       )
                  //   )
                  //       :
                  //   null;
                  //   (widget.singleTime == true) && (widget.mySelection == -1) ?
                  //   GlobalVariables().name.isNotEmpty ?
                  //   setState(() {
                  //     lastSelection = widget.mySelection;
                  //     widget.mySelection = index;
                  //     _storeUserAnswer(index, lastSelection);
                  //     //widget.correctAnswerIndex != -1 ? showAnswer = true : showAnswer = false;// Automatically show the answer on selection
                  //   }) : ScaffoldMessenger.of(context).showSnackBar(
                  //       SnackBar(
                  //         backgroundColor: Color(0xe70b0378),
                  //         content: Text("Frist complet your profile"),
                  //         duration: Duration(milliseconds: 500),
                  //       )
                  //   ) : null;
                  // },
                  child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${index + 1}. ",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                                Flexible(
                                    child: Text(
                                      option,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                      ),
                                    )
                                ),
                              ],
                            ),
                          ),
                          // Flexible(
                          //   child: Text(
                          //     "${index + 1}. $option",
                          //     style: const TextStyle(
                          //       fontSize: 14,
                          //       color: Colors.white,
                          //     ),
                          //   )
                          // ),
                          widget.viewResult ? GestureDetector(
                            // onTap: () {
                            //   Navigator.push(
                            //       context,
                            //       MaterialPageRoute(
                            //           builder: (context) => viewUserSelection(
                            //             quizID: widget.quizID,
                            //             indexNumber: index,
                            //           )
                            //       )
                            //   );
                            // } ,
                            child: Container(
                                width: 70,
                                padding: EdgeInsets.symmetric( vertical: 3),
                                margin: EdgeInsets.symmetric(vertical: 2),
                                decoration: BoxDecoration(
                                    color: Colors.white12,
                                    borderRadius: BorderRadius.circular(25)
                                ),
                                child: Center(
                                  child: Text("View",style: TextStyle(color: Color(0xFFFFFFFF), fontWeight: FontWeight.bold)),
                                )
                            ),
                          ) : Text(
                            widget.correctAnswerIndex == index && widget.mySelection == widget.correctAnswerIndex ?
                            "🎉" :
                            index == widget.mySelection && widget.correctAnswerIndex != -1  ? "😔" : "",

                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),

                        ],
                      )
                  ),
                );
              }),

              widget.correctAnswerIndex == -1 ? const SizedBox(height: 0) : const SizedBox(height: 16),
              // Show/Hide Answer Button
              widget.correctAnswerIndex == -1 ? Container() : Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        showAnswer = !showAnswer;
                      });
                    },
                    child: Row(
                      children: [
                        Icon(
                          showAnswer ? Icons.remove_red_eye : Icons.visibility_off,
                          color: Colors.white,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          showAnswer ? "Hide answer" : "Show answer",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withAlpha((0.9 * 255).toInt()),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment(1, 0),
                child: Text(
                  "Posted on :  ${widget.time}",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 10.0,
                    color: Colors.white54,
                  ),
                ),
              )
            ],
          ),
        )
    );
  }
}


class TextQuizWidget extends StatefulWidget {
  final Function updatedShared;
  final bool identityIsShow;
  final String question;
  final String image;
  final String name;
  final String course;
  final String quizID;
  final String userid;
  final bool alreadyAnswered;
  final String answerText;
  final bool viewreplay;
  final bool delete;
  final String time;
  const TextQuizWidget({
    super.key,
    required this.updatedShared,
    required this.image,
    required this.name,
    required this.course,
    required this.identityIsShow,
    required this.question,
    required this.quizID,
    required this.userid,
    required this.alreadyAnswered,
    required this.answerText,
    required this.viewreplay,
    required this.delete,
    required this.time
  });

  @override
  State<TextQuizWidget> createState() => _TextQuizWidgetState();
}
class _TextQuizWidgetState extends State<TextQuizWidget> {
  final TextEditingController _textAnswerController = TextEditingController();

  final FocusNode _focusNode = FocusNode();
  bool isloading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _textAnswerController.text = widget.answerText;
  }

  @override
  void dispose() {
    // Dispose the controller and the focus node
    _textAnswerController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  // void _storeUserAnswer() async{
  //
  //   await FirebaseFirestore.instance.collection('shared')
  //       .doc(widget.quizID)
  //       .update(
  //       {
  //         'answers'+'.'+GlobalVariables().userid : _textAnswerController.text
  //       }
  //   );
  //
  //   await FirebaseFirestore.instance.collection('shared')
  //       .doc(widget.quizID)
  //       .collection('response')
  //       .doc('answers')
  //       .update(
  //       {
  //         GlobalVariables().userid : {
  //           'responseTime' : FieldValue.serverTimestamp(),
  //           'answerText' : _textAnswerController.text,
  //           'name' : GlobalVariables().name,
  //           'course' : GlobalVariables().course,
  //         },
  //       }
  //   );
  //
  //   await FirebaseFirestore.instance.collection('users')
  //       .doc(GlobalVariables().userid)
  //       .collection('myActivity')
  //       .doc('response')
  //       .update(
  //       {
  //         widget.quizID : {
  //           'responseTime' : FieldValue.serverTimestamp(),
  //           'answerText' : _textAnswerController.text
  //         },
  //       }
  //   );
  //   setState(() {
  //     widget.alreadyAnswered = true;
  //     isloading = false;
  //   });
  // }

  void _unfocusTextField() {
    _focusNode.unfocus();
  }


  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Delete Post"),
            content: Text("Are you sure you want to delete this post?"),
            actions: <Widget>[
              TextButton(
                child: Text("Cancel"),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
              TextButton(
                child: Text("Delete"),
                onPressed: () {
                  //deletePost(widget.quizID); // Call your delete function
                  widget.updatedShared(widget.quizID);
                  Navigator.of(context).pop(); // Close the dialog after deletion
                },
              ),
            ],
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _unfocusTextField,
      child: Padding(
          padding: EdgeInsets.only(top: 12,left: 7, right: 7, bottom: 2),
          child: Container(
            width: double.infinity,
            // padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 5),
            padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 5),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF4A3274), Color(0xFF5C4D91)],
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
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                if(!widget.identityIsShow || widget.delete)
                  GestureDetector(
                    // onTap: () {
                    //   _focusNode.unfocus();
                    //   GlobalVariables().name.isNotEmpty ? GlobalVariables().userid != widget.userid ? Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //           builder: (context) => MessageWidget(receiverId: widget.userid, receiverName: widget.name, newMessage: '',)
                    //       )
                    //   ) : null
                    //       : {
                    //     Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) => EditProfile()
                    //         )
                    //     ),
                    //     ScaffoldMessenger.of(context).showSnackBar(
                    //       const SnackBar(
                    //         content: Text('To message anyone, frist complet your profile.'),
                    //         backgroundColor: Color(0xe70b0378),
                    //         duration: Duration(milliseconds: 1500),
                    //       ),
                    //     )
                    //   };
                    // },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Container(
                        //   width: 45.0,
                        //   height: 45.0,
                        //   clipBehavior: Clip.antiAlias,
                        //   decoration: BoxDecoration(
                        //     shape: BoxShape.circle,
                        //   ),
                        //   child: CachedNetworkImage(
                        //     imageUrl: GlobalVariables().gender?
                        //     "https://imgs.search.brave.com/ek_J28ierOL93E0C7btwCHh1V0nZyPAKISxj654meLg/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9pbWcu/ZnJlZXBpay5jb20v/cHJlbWl1bS1waG90/by9jYXJ0b29uLWdp/cmwtd2l0aC1sb25n/LWhhaXItYm9vdHMt/c3RhbmRpbmctZnJv/bnQtd2hpdGUtYmFj/a2dyb3VuZC1nZW5l/cmF0aXZlLWFpXzkw/MDgzMy0zODA0My5q/cGc_c2VtdD1haXNf/aHlicmlk"
                        //         :
                        //     "https://imgs.search.brave.com/Zz7rIOCJbxFVbkrRHGPdpNUfsyd6wne8UTisdu-3pV0/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9pbWcu/ZnJlZXBpay5jb20v/cHJlbWl1bS1waG90/by9jYXJ0b29uLWJv/eS13aXRoLWdyZWVu/LWV5ZXMtYmx1ZS1z/aGlydF8xMDI4ODgy/LTEwNjI2MC5qcGc_/c2VtdD1haXNfaHli/cmlk",
                        //
                        //
                        //     // Loading indicator
                        //     placeholder: (context, url) => CircularProgressIndicator(),
                        //
                        //     // Error widget
                        //     errorWidget: (context, url, error) => Icon(Icons.error, color: Colors.red),
                        //
                        //     // Custom cache key (optional)
                        //     cacheKey: GlobalVariables().gender?
                        //     "https://imgs.search.brave.com/ek_J28ierOL93E0C7btwCHh1V0nZyPAKISxj654meLg/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9pbWcu/ZnJlZXBpay5jb20v/cHJlbWl1bS1waG90/by9jYXJ0b29uLWdp/cmwtd2l0aC1sb25n/LWhhaXItYm9vdHMt/c3RhbmRpbmctZnJv/bnQtd2hpdGUtYmFj/a2dyb3VuZC1nZW5l/cmF0aXZlLWFpXzkw/MDgzMy0zODA0My5q/cGc_c2VtdD1haXNf/aHlicmlk"
                        //         :
                        //     "https://imgs.search.brave.com/Zz7rIOCJbxFVbkrRHGPdpNUfsyd6wne8UTisdu-3pV0/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9pbWcu/ZnJlZXBpay5jb20v/cHJlbWl1bS1waG90/by9jYXJ0b29uLWJv/eS13aXRoLWdyZWVu/LWV5ZXMtYmx1ZS1z/aGlydF8xMDI4ODgy/LTEwNjI2MC5qcGc_/c2VtdD1haXNfaHli/cmlk",
                        //
                        //
                        //     // Image properties
                        //     fit: BoxFit.cover,
                        //   ),
                        // ),
                        SizedBox(width: 7),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.name,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 20.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  height: 1,
                                ),
                              ),
                              Text(
                                widget.course,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 12.0,
                                  color: Colors.white54,
                                ),
                              ),
                            ],
                          ),
                        ),
                        widget.delete ?
                        IconButton(
                          onPressed: () {_showDeleteConfirmationDialog(context);},
                          icon: Icon(Icons.delete),
                          color: Colors.white,
                        ) :
                        Text(
                            "Quiz",
                            style: TextStyle(
                                fontSize: 24,
                                color: Colors.white54,
                                fontWeight: FontWeight.w600
                            )
                        ),

                      ],
                    ),
                  ),
                if(!widget.identityIsShow || widget.delete)
                  Divider(
                    thickness: 3.0,
                    // indent: 30.0,
                    // endIndent: 30.0,
                    height: 30,
                    color: Color(0x86805CBD),
                  ),
                // Question Text
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "🙋‍♀️ ",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Expanded(child: Text(
                      widget.question,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    )),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextField(
                          focusNode: _focusNode,
                          controller: _textAnswerController,
                          //focusNode: _textFieldFocusNode,
                          decoration: InputDecoration(
                            constraints: BoxConstraints(
                              maxWidth: double.infinity,  // Maximum width
                              maxHeight: 150, // Maximum height
                            ),
                            hintText: "write answer...",
                            hintStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.w300,fontSize: 17),
                            filled: true,
                            fillColor: const Color(0x1D9091B1),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 20),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide.none,

                            ),
                          ),
                          /// textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          style: const TextStyle(
                            fontSize: 16,
                            fontFamily: 'Inter',
                            color: Colors.white,
                          ),
                          readOnly: widget.alreadyAnswered ? true : false
                      ),
                    ),
                    const SizedBox(width: 10),
                    widget.alreadyAnswered ? Icon(
                      Icons.check_rounded,
                      size: 35,
                      color: Colors.white,
                    ) : isloading ? CircularProgressIndicator() : IconButton(
                      icon: const Icon(Icons.send_rounded, size: 35),
                      color: Colors.white,
                      onPressed: (){
                        // if(GlobalVariables().name.isNotEmpty){
                        //   if(_textAnswerController.text.isNotEmpty){
                        //     setState(() {
                        //       isloading = true;
                        //       _storeUserAnswer();
                        //     });
                        //   }
                        // }else {
                        //   ScaffoldMessenger.of(context).showSnackBar(
                        //       SnackBar(
                        //         backgroundColor: Color(0xe70b0378),
                        //         content: Text("Frist complet your profile"),
                        //         duration: Duration(milliseconds: 500),
                        //       )
                        //   );
                        // }
                      },
                    ),
                  ],
                ),
                SizedBox(height: 10),
                widget.viewreplay ? GestureDetector(
                  // onTap: () {
                  //   Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (context) => viewResponses(
                  //             quizID: widget.quizID,
                  //           )
                  //       )
                  //   );
                  // },
                  child: Align(
                    alignment: Alignment(-1, 0),
                    child: Text(
                      "View replay",
                      style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFF9091B1),
                          fontWeight: FontWeight.w300
                      ),
                    ),
                  ),
                ) : Container(),
                // SizedBox(height: 5),
                Align(
                  alignment: Alignment(1, 0),
                  child: Text(
                    'Posted on : $widget.time',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 10.0,
                      color: Colors.white54,
                    ),
                  ),
                )
              ],
            ),
          )
      ),
    );
  }
}

// ignore: must_be_immutable
class BuildPoll extends StatefulWidget{
  final Function updatedShared;
  final String image;
  final String name;
  final String course;
  final bool identityIsShow;
  final String pollText;
  int yesCount;
  int noCount;
  final String pollId;
  bool isYesChecked;
  bool isNoChecked;
  final String userid;
  final bool resultType;
  final bool delete;
  String time;
  BuildPoll({
    super.key,
    required this.image,
    required this.name,
    required this.course,
    required this.identityIsShow,
    required this.pollText,
    required this.yesCount,
    required this.noCount,
    required this.pollId,
    required this.isYesChecked,
    required this.isNoChecked,
    required this.userid,
    required this.resultType,
    required this.delete,
    required this.updatedShared,
    required this.time
  });
  @override
  State<BuildPoll> createState() => _BuildPollState();
}
class _BuildPollState extends State<BuildPoll>{
  late int yesTriger;
  late int noTriger;
  //String myID = GlobalVariables().userid;
  bool lastSelection = false;
  @override
  void initState() {
    super.initState();
    widget.isYesChecked ? yesTriger = 1 : yesTriger = 0;
    widget.isNoChecked ? noTriger = 1 : noTriger = 0;
  }

  // // void pollResponceCount() async{
  // //   try{
  // //     if(yesSelected){
  // //
  // //       yesTriger == noTriger ? widget.yesCount += 1 : yesSelected ? {widget.noCount -=1, widget.yesCount += 1} : null;
  // //       yesTriger = 1;
  // //       noTriger = 0;
  // //       setState(() {});
  // //       await FirebaseFirestore.instance.collection('shared').doc(widget.pollId)
  // //           .update(
  // //           {
  // //             'no.$myID' : FieldValue.delete(),
  // //             'yes.$myID' : 'yes',
  // //           });
  // //
  // //       await FirebaseFirestore.instance.collection('users')
  // //           .doc(GlobalVariables().userid)
  // //           .collection('myActivity')
  // //           .doc('response')
  // //           .update(
  // //           {
  // //             widget.pollId : {
  // //               'responseTime' : FieldValue.serverTimestamp(),
  // //               'vote' : 'yes'
  // //             },
  // //           }
  // //       );
  // //
  // //       await FirebaseFirestore.instance.collection('shared')
  // //           .doc(widget.pollId)
  // //           .collection('response')
  // //           .doc('1')
  // //           .update(
  // //           {
  // //             GlobalVariables().userid : {
  // //               'responseTime' : FieldValue.serverTimestamp(),
  // //               'vote' : 'yes',
  // //               'name' : GlobalVariables().name,
  // //               'course' : GlobalVariables().course
  // //             }
  // //           }
  // //       );
  // //       await FirebaseFirestore.instance.collection('shared')
  // //           .doc(widget.pollId)
  // //           .collection('response')
  // //           .doc('0')
  // //           .update(
  // //           {
  // //             GlobalVariables().userid : FieldValue.delete()
  // //           }
  // //       );
  // //     }
  // //     else if(noSelected){
  // //       yesTriger == noTriger ? widget.noCount += 1 : noSelected ? {widget.noCount += 1, widget.yesCount -= 1}
  // //           : null ;
  // //       noTriger = 1;
  // //       yesTriger = 0;
  // //       setState(() {});
  // //       await FirebaseFirestore.instance.collection('shared').doc(widget.pollId)
  // //           .update(
  // //           {
  // //             'yes.$myID' : FieldValue.delete(),
  // //             'no.$myID' : 'no',
  // //           });
  // //
  // //       await FirebaseFirestore.instance.collection('users')
  // //           .doc(GlobalVariables().userid)
  // //           .collection('myActivity')
  // //           .doc('response')
  // //           .update(
  // //           {
  // //             widget.pollId : {
  // //               'responseTime' : FieldValue.serverTimestamp(),
  // //               'vote' : 'no'
  // //             },
  // //           }
  // //       );
  // //       await FirebaseFirestore.instance.collection('shared')
  // //           .doc(widget.pollId)
  // //           .collection('response')
  // //           .doc('1')
  // //           .update(
  // //           {
  // //             GlobalVariables().userid : FieldValue.delete()
  // //           }
  // //       );
  // //
  // //       await FirebaseFirestore.instance.collection('shared')
  // //           .doc(widget.pollId)
  // //           .collection('response')
  // //           .doc('0')
  // //           .update(
  // //           {
  // //             GlobalVariables().userid : {
  // //               'responseTime' : FieldValue.serverTimestamp(),
  // //               'vote' : 'no',
  // //               'name' : GlobalVariables().name,
  // //               'course' : GlobalVariables().course
  // //             }
  // //           }
  // //       );
  // //     }
  // //     else
  // //     {
  // //       yesTriger == 1 ? widget.yesCount -= 1 : null;
  // //       noTriger == 1? widget.noCount -= 1 : null;
  // //       yesTriger = 0;
  // //       noTriger = 0;
  // //       setState(() {});
  // //       await FirebaseFirestore.instance.collection('shared').doc(widget.pollId)
  // //           .update(
  // //           {
  // //             'yes.$myID' : FieldValue.delete(),
  // //             'no.$myID' : FieldValue.delete()
  // //           });
  // //
  // //       await FirebaseFirestore.instance.collection('users')
  // //           .doc(GlobalVariables().userid)
  // //           .collection('myActivity')
  // //           .doc('response')
  // //           .update(
  // //           {
  // //             widget.pollId : FieldValue.delete(),
  // //           }
  // //       );
  // //
  // //       await FirebaseFirestore.instance.collection('shared')
  // //           .doc(widget.pollId)
  // //           .collection('response')
  // //           .doc('1')
  // //           .update(
  // //           {
  // //             GlobalVariables().userid : FieldValue.delete()
  // //           }
  // //       );
  // //
  // //       await FirebaseFirestore.instance.collection('shared')
  // //           .doc(widget.pollId)
  // //           .collection('response')
  // //           .doc('0')
  // //           .update(
  // //           {
  // //             GlobalVariables().userid : FieldValue.delete()
  // //           }
  // //       );
  // //     }
  // //
  // //   }catch (e) {
  // //     print("error");
  // //   }
  // // }
  // void pollResponceCount() async{
  //   try{
  //     if(widget.isYesChecked){
  //
  //       yesTriger == noTriger ? widget.yesCount += 1 :  {widget.noCount -=1, widget.yesCount += 1} ;
  //       yesTriger = 1;
  //       noTriger = 0;
  //       setState(() {});
  //       await FirebaseFirestore.instance.collection('shared').doc(widget.pollId)
  //           .update(
  //           {
  //             'no.$myID' : FieldValue.delete(),
  //             'yes.$myID' : 'yes',
  //           });
  //
  //       await FirebaseFirestore.instance.collection('users')
  //           .doc(GlobalVariables().userid)
  //           .collection('myActivity')
  //           .doc('response')
  //           .update(
  //           {
  //             widget.pollId : {
  //               'responseTime' : FieldValue.serverTimestamp(),
  //               'vote' : 'yes'
  //             },
  //           }
  //       );
  //
  //       await FirebaseFirestore.instance.collection('shared')
  //           .doc(widget.pollId)
  //           .collection('response')
  //           .doc('1')
  //           .update(
  //           {
  //             GlobalVariables().userid : {
  //               'responseTime' : FieldValue.serverTimestamp(),
  //               'vote' : 'yes',
  //               'name' : GlobalVariables().name,
  //               'course' : GlobalVariables().course
  //             }
  //           }
  //       );
  //       await FirebaseFirestore.instance.collection('shared')
  //           .doc(widget.pollId)
  //           .collection('response')
  //           .doc('0')
  //           .update(
  //           {
  //             GlobalVariables().userid : FieldValue.delete()
  //           }
  //       );
  //     }
  //     else if(widget.isNoChecked){
  //       yesTriger == noTriger ? widget.noCount += 1 : {widget.noCount += 1, widget.yesCount -= 1};
  //       noTriger = 1;
  //       yesTriger = 0;
  //       setState(() {});
  //       await FirebaseFirestore.instance.collection('shared').doc(widget.pollId)
  //           .update(
  //           {
  //             'yes.$myID' : FieldValue.delete(),
  //             'no.$myID' : 'no',
  //           });
  //
  //       await FirebaseFirestore.instance.collection('users')
  //           .doc(GlobalVariables().userid)
  //           .collection('myActivity')
  //           .doc('response')
  //           .update(
  //           {
  //             widget.pollId : {
  //               'responseTime' : FieldValue.serverTimestamp(),
  //               'vote' : 'no'
  //             },
  //           }
  //       );
  //       await FirebaseFirestore.instance.collection('shared')
  //           .doc(widget.pollId)
  //           .collection('response')
  //           .doc('1')
  //           .update(
  //           {
  //             GlobalVariables().userid : FieldValue.delete()
  //           }
  //       );
  //
  //       await FirebaseFirestore.instance.collection('shared')
  //           .doc(widget.pollId)
  //           .collection('response')
  //           .doc('0')
  //           .update(
  //           {
  //             GlobalVariables().userid : {
  //               'responseTime' : FieldValue.serverTimestamp(),
  //               'vote' : 'no',
  //               'name' : GlobalVariables().name,
  //               'course' : GlobalVariables().course
  //             }
  //           }
  //       );
  //     }
  //     else
  //     {
  //       yesTriger == 1 ? widget.yesCount -= 1 : null;
  //       noTriger == 1? widget.noCount -= 1 : null;
  //       yesTriger = 0;
  //       noTriger = 0;
  //       setState(() {});
  //       await FirebaseFirestore.instance.collection('shared').doc(widget.pollId)
  //           .update(
  //           {
  //             'yes.$myID' : FieldValue.delete(),
  //             'no.$myID' : FieldValue.delete()
  //           });
  //
  //       await FirebaseFirestore.instance.collection('users')
  //           .doc(GlobalVariables().userid)
  //           .collection('myActivity')
  //           .doc('response')
  //           .update(
  //           {
  //             widget.pollId : FieldValue.delete(),
  //           }
  //       );
  //
  //       await FirebaseFirestore.instance.collection('shared')
  //           .doc(widget.pollId)
  //           .collection('response')
  //           .doc('1')
  //           .update(
  //           {
  //             GlobalVariables().userid : FieldValue.delete()
  //           }
  //       );
  //
  //       await FirebaseFirestore.instance.collection('shared')
  //           .doc(widget.pollId)
  //           .collection('response')
  //           .doc('0')
  //           .update(
  //           {
  //             GlobalVariables().userid : FieldValue.delete()
  //           }
  //       );
  //     }
  //
  //   }catch (e) {
  //     print("error");
  //   }
  // }
  //
  // void _showDeleteConfirmationDialog(BuildContext context) {
  //   showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: Text("Delete Post"),
  //           content: Text("Are you sure you want to delete this post?"),
  //           actions: <Widget>[
  //             TextButton(
  //               child: Text("Cancel"),
  //               onPressed: () {
  //                 Navigator.of(context).pop(); // Close the dialog
  //               },
  //             ),
  //             TextButton(
  //               child: Text("Delete"),
  //               onPressed: () {
  //                 deletePost(widget.pollId); // Call your delete function
  //                 widget.updatedShared(widget.pollId);
  //                 Navigator.of(context).pop(); // Close the dialog after deletion
  //               },
  //             ),
  //           ],
  //         );
  //       }
  //   );
  // }
  @override
  Widget build(BuildContext context){
    return Padding(
      padding: EdgeInsets.only(top: 12,left: 7, right: 7, bottom: 2),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 5),
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
              color: Color(0x670015ff),
              blurRadius: 5,
              offset: Offset(0, 2),
            )
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if(!widget.identityIsShow || widget.delete)
              GestureDetector(
                // onTap: () {
                //   GlobalVariables().name.isNotEmpty ? GlobalVariables().userid != widget.userid ? Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) => MessageWidget(receiverId: widget.userid, receiverName: widget.name, newMessage: '',)
                //       )
                //   ) : null
                //       : {
                //     Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (context) => EditProfile()
                //         )
                //     ),
                //     ScaffoldMessenger.of(context).showSnackBar(
                //       const SnackBar(
                //         content: Text('To message anyone, frist complet your profile.'),
                //         backgroundColor: Color(0xe70b0378),
                //         duration: Duration(milliseconds: 1500),
                //       ),
                //     )
                //   };
                // },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Container(
                    //   width: 45.0,
                    //   height: 45.0,
                    //   clipBehavior: Clip.antiAlias,
                    //   decoration: BoxDecoration(
                    //     shape: BoxShape.circle,
                    //   ),
                    //   child: CachedNetworkImage(
                    //     imageUrl: GlobalVariables().gender?
                    //     "https://imgs.search.brave.com/ek_J28ierOL93E0C7btwCHh1V0nZyPAKISxj654meLg/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9pbWcu/ZnJlZXBpay5jb20v/cHJlbWl1bS1waG90/by9jYXJ0b29uLWdp/cmwtd2l0aC1sb25n/LWhhaXItYm9vdHMt/c3RhbmRpbmctZnJv/bnQtd2hpdGUtYmFj/a2dyb3VuZC1nZW5l/cmF0aXZlLWFpXzkw/MDgzMy0zODA0My5q/cGc_c2VtdD1haXNf/aHlicmlk"
                    //         :
                    //     "https://imgs.search.brave.com/Zz7rIOCJbxFVbkrRHGPdpNUfsyd6wne8UTisdu-3pV0/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9pbWcu/ZnJlZXBpay5jb20v/cHJlbWl1bS1waG90/by9jYXJ0b29uLWJv/eS13aXRoLWdyZWVu/LWV5ZXMtYmx1ZS1z/aGlydF8xMDI4ODgy/LTEwNjI2MC5qcGc_/c2VtdD1haXNfaHli/cmlk",
                    //
                    //     // Loading indicator
                    //     placeholder: (context, url) => CircularProgressIndicator(),
                    //
                    //     // Error widget
                    //     errorWidget: (context, url, error) => Icon(Icons.error, color: Colors.red),
                    //
                    //     // Custom cache key (optional)
                    //     cacheKey: GlobalVariables().gender?
                    //     "https://imgs.search.brave.com/ek_J28ierOL93E0C7btwCHh1V0nZyPAKISxj654meLg/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9pbWcu/ZnJlZXBpay5jb20v/cHJlbWl1bS1waG90/by9jYXJ0b29uLWdp/cmwtd2l0aC1sb25n/LWhhaXItYm9vdHMt/c3RhbmRpbmctZnJv/bnQtd2hpdGUtYmFj/a2dyb3VuZC1nZW5l/cmF0aXZlLWFpXzkw/MDgzMy0zODA0My5q/cGc_c2VtdD1haXNf/aHlicmlk"
                    //         :
                    //     "https://imgs.search.brave.com/Zz7rIOCJbxFVbkrRHGPdpNUfsyd6wne8UTisdu-3pV0/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9pbWcu/ZnJlZXBpay5jb20v/cHJlbWl1bS1waG90/by9jYXJ0b29uLWJv/eS13aXRoLWdyZWVu/LWV5ZXMtYmx1ZS1z/aGlydF8xMDI4ODgy/LTEwNjI2MC5qcGc_/c2VtdD1haXNfaHli/cmlk",
                    //
                    //
                    //     // Image properties
                    //     fit: BoxFit.cover,
                    //   ),
                    // ),
                    SizedBox(width: 7),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.name,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 20.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              height: 1,
                            ),
                          ),
                          Text(
                            widget.course,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12.0,
                              color: Colors.white54,
                            ),
                          ),
                        ],
                      ),
                    ),
                    widget.delete ?
                    IconButton(
                      onPressed: () {
                        //_showDeleteConfirmationDialog(context);
                        },
                      icon: Icon(Icons.delete),
                      color: Colors.white,
                    ) :
                    Text(
                        "Poll",
                        style: TextStyle(
                            fontSize: 24,
                            color: Colors.white54,
                            fontWeight: FontWeight.w600
                        )
                    ),
                  ],
                ),
              ),
            if(!widget.identityIsShow || widget.delete)
              Divider(
                thickness: 3.0,
                // indent: 30.0,
                // endIndent: 30.0,
                height: 30,
                color: Color(0x86805CBD),
              ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: Text(
                        widget.pollText,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      )),
                      SizedBox(width: 15),
                      widget.identityIsShow ? Text("Poll", style: TextStyle(fontSize: 24, color: Colors.white54, fontWeight: FontWeight.w900)): Container(),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: Checkbox(
                            value: widget.isYesChecked,
                            activeColor: Color(0xff060052), // Color when checked
                            checkColor: Colors.white,  // Check icon color
                            side: BorderSide(
                              color: Colors.white, // Border color
                              width: 2.0,                                    // Border width
                            ),
                            onChanged: (value) {
                              // if(GlobalVariables().name.isNotEmpty){
                              //   setState(() {
                              //     if(widget.isYesChecked){
                              //       // yesSelected = !yesSelected;
                              //       // noSelected = false;
                              //       widget.isYesChecked = !widget.isYesChecked;
                              //       widget.isNoChecked = false;
                              //     }
                              //     else{
                              //       // yesSelected = true;
                              //       // noSelected = false;
                              //       widget.isYesChecked = true;
                              //       widget.isNoChecked = false;
                              //     }
                              //     pollResponceCount();
                              //   });
                              // }else {
                              //   ScaffoldMessenger.of(context).showSnackBar(
                              //       SnackBar(
                              //         backgroundColor: Color(0xe70b0378),
                              //         content: Text("Frist complet your profile"),
                              //         duration: Duration(milliseconds: 500),
                              //       )
                              //   );
                              // }
                            }
                        ),
                      ),
                      SizedBox(width: 7),
                      Text(
                        'Yes',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0, color: Colors.white),
                      ),
                      Expanded(child: Container()),
                      GestureDetector(
                          // onTap: () {
                          //   widget.resultType ? Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //           builder: (context) => viewUserVote(
                          //             pollId: widget.pollId,
                          //             voteType: 1,
                          //           )
                          //       )
                          //   ) : null;
                          // } ,
                          child: Row(
                            children: [
                              Align(
                                alignment: AlignmentDirectional(1.0, 0.0),
                                child: SizedBox(
                                  width: 60.0,
                                  child: Stack(
                                    children: [
                                      // Align(
                                      //   alignment: AlignmentDirectional(1.0, 0.0),
                                      //   child: CircleAvatar(
                                      //     radius: 9.0,
                                      //     backgroundImage: NetworkImage(
                                      //       GlobalVariables().gender?
                                      //       "https://imgs.search.brave.com/ek_J28ierOL93E0C7btwCHh1V0nZyPAKISxj654meLg/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9pbWcu/ZnJlZXBpay5jb20v/cHJlbWl1bS1waG90/by9jYXJ0b29uLWdp/cmwtd2l0aC1sb25n/LWhhaXItYm9vdHMt/c3RhbmRpbmctZnJv/bnQtd2hpdGUtYmFj/a2dyb3VuZC1nZW5l/cmF0aXZlLWFpXzkw/MDgzMy0zODA0My5q/cGc_c2VtdD1haXNf/aHlicmlk"
                                      //           :
                                      //       "https://imgs.search.brave.com/Zz7rIOCJbxFVbkrRHGPdpNUfsyd6wne8UTisdu-3pV0/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9pbWcu/ZnJlZXBpay5jb20v/cHJlbWl1bS1waG90/by9jYXJ0b29uLWJv/eS13aXRoLWdyZWVu/LWV5ZXMtYmx1ZS1z/aGlydF8xMDI4ODgy/LTEwNjI2MC5qcGc_/c2VtdD1haXNfaHli/cmlk",
                                      //
                                      //     ),
                                      //   ),
                                      // ),
                                      // Align(
                                      //   alignment: AlignmentDirectional(0.4, 0.0),
                                      //   child: CircleAvatar(
                                      //     radius: 9.0,
                                      //     backgroundImage: NetworkImage(
                                      //       GlobalVariables().gender?
                                      //       "https://imgs.search.brave.com/ek_J28ierOL93E0C7btwCHh1V0nZyPAKISxj654meLg/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9pbWcu/ZnJlZXBpay5jb20v/cHJlbWl1bS1waG90/by9jYXJ0b29uLWdp/cmwtd2l0aC1sb25n/LWhhaXItYm9vdHMt/c3RhbmRpbmctZnJv/bnQtd2hpdGUtYmFj/a2dyb3VuZC1nZW5l/cmF0aXZlLWFpXzkw/MDgzMy0zODA0My5q/cGc_c2VtdD1haXNf/aHlicmlk"
                                      //           :
                                      //       "https://imgs.search.brave.com/Zz7rIOCJbxFVbkrRHGPdpNUfsyd6wne8UTisdu-3pV0/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9pbWcu/ZnJlZXBpay5jb20v/cHJlbWl1bS1waG90/by9jYXJ0b29uLWJv/eS13aXRoLWdyZWVu/LWV5ZXMtYmx1ZS1z/aGlydF8xMDI4ODgy/LTEwNjI2MC5qcGc_/c2VtdD1haXNfaHli/cmlk",
                                      //
                                      //     ),
                                      //   ),
                                      // ),
                                      // Align(
                                      //   alignment: AlignmentDirectional(-0.2, 0.0),
                                      //   child: CircleAvatar(
                                      //     radius: 9.0,
                                      //     backgroundImage: NetworkImage(
                                      //       GlobalVariables().gender?
                                      //       "https://imgs.search.brave.com/ek_J28ierOL93E0C7btwCHh1V0nZyPAKISxj654meLg/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9pbWcu/ZnJlZXBpay5jb20v/cHJlbWl1bS1waG90/by9jYXJ0b29uLWdp/cmwtd2l0aC1sb25n/LWhhaXItYm9vdHMt/c3RhbmRpbmctZnJv/bnQtd2hpdGUtYmFj/a2dyb3VuZC1nZW5l/cmF0aXZlLWFpXzkw/MDgzMy0zODA0My5q/cGc_c2VtdD1haXNf/aHlicmlk"
                                      //           :
                                      //       "https://imgs.search.brave.com/Zz7rIOCJbxFVbkrRHGPdpNUfsyd6wne8UTisdu-3pV0/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9pbWcu/ZnJlZXBpay5jb20v/cHJlbWl1bS1waG90/by9jYXJ0b29uLWJv/eS13aXRoLWdyZWVu/LWV5ZXMtYmx1ZS1z/aGlydF8xMDI4ODgy/LTEwNjI2MC5qcGc_/c2VtdD1haXNfaHli/cmlk",
                                      //
                                      //     ),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 5.0, left: 5, bottom: 5, top: 5),
                                child: Text(
                                  widget.yesCount.toString(),
                                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.white),
                                ),
                              ),
                            ],
                          )
                      ),

                    ],
                  ),
                  Container(
                    height: 7.0,
                    decoration: BoxDecoration(),
                    child: Padding(
                      padding: EdgeInsets.only(left: 25.0),
                      child: LinearProgressIndicator(
                        value: (widget.yesCount != 0)
                            ? widget.yesCount > widget.noCount ? 1 : (widget.yesCount / widget.noCount)
                            : 0,
                        backgroundColor: Color(0xFFBB99FF),
                        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFE854F)),
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: Checkbox(
                            value: widget.isNoChecked,
                            activeColor: Color(0xff060052), // Color when checked
                            checkColor: Colors.white,  // Check icon color
                            side: BorderSide(
                              color: Colors.white, // Border color
                              width: 2.0,                                    // Border width
                            ),
                            onChanged: (value) {
                              // if(GlobalVariables().name.isNotEmpty){
                              //   setState(() {
                              //     if(widget.isNoChecked){
                              //       // noSelected = !noSelected;
                              //       // yesSelected = false;
                              //       widget.isNoChecked = !widget.isNoChecked;
                              //       widget.isYesChecked = false;
                              //     }
                              //     else{
                              //       // noSelected = true;
                              //       // yesSelected = false;
                              //       widget.isNoChecked = true;
                              //       widget.isYesChecked = false;
                              //     }
                              //     pollResponceCount();
                              //   });
                              // }else {
                              //   ScaffoldMessenger.of(context).showSnackBar(
                              //       SnackBar(
                              //         backgroundColor: Color(0xe70b0378),
                              //         content: Text("Frist complet your profile"),
                              //         duration: Duration(milliseconds: 500),
                              //       )
                              //   );
                              // }
                            }
                        ),
                      ),
                      SizedBox(width: 7),
                      Text(
                        'No',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0, color: Colors.white),
                      ),
                      Expanded(child: Container()),
                      GestureDetector(
                          // onTap: () {
                          //   widget.resultType ? Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //           builder: (context) => viewUserVote(
                          //             pollId: widget.pollId,
                          //             voteType: 0,
                          //           )
                          //       )
                          //   ) : null;
                          // } ,
                          child: Row(
                            children: [
                              Align(
                                alignment: AlignmentDirectional(1.0, 0.0),
                                child: SizedBox(
                                  width: 60.0,
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: AlignmentDirectional(1.0, 0.0),
                                        child: CircleAvatar(
                                          radius: 9.0,
                                          backgroundImage: NetworkImage(
                                            'https://images.unsplash.com/photo-1526505262320-81542978f63b?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHw3fHxsZWdvfGVufDB8fHx8MTczMjE0OTY4MXww&ixlib=rb-4.0.3&q=80&w=1080',
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: AlignmentDirectional(0.4, 0.0),
                                        child: CircleAvatar(
                                          radius: 9.0,
                                          backgroundImage: NetworkImage(
                                            'https://images.unsplash.com/photo-1503803508152-7790ae3cb125?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHw2fHxmaXJld29ya3N8ZW58MHx8fHwxNzMyMTI1NjgyfDA&ixlib=rb-4.0.3&q=80&w=1080',
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: AlignmentDirectional(-0.2, 0.0),
                                        child: CircleAvatar(
                                          radius: 9.0,
                                          backgroundImage: NetworkImage(
                                            'https://images.unsplash.com/photo-1534711429713-aeeeff724f23?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHw4fHxzdGFycnklMjBuaWdodHxlbnwwfHx8fDE3MzIwNzY5MzN8MA&ixlib=rb-4.0.3&q=80&w=1080',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 5.0, left: 5, bottom: 5, top: 5),
                                child: Text(
                                  widget.noCount.toString(),
                                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.white),
                                ),
                              ),
                            ],
                          )
                      ),
                    ],
                  ),
                  Container(
                    height: 7.0,
                    decoration: BoxDecoration(),
                    child: Padding(
                      padding: EdgeInsets.only(left: 25.0),
                      child: LinearProgressIndicator(
                        value: (widget.noCount != 0)
                            ? (widget.noCount > widget.yesCount ? 1 : widget.noCount / widget.yesCount)
                            : 0,
                        backgroundColor: Color(0xFFBB99FF),
                        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFE854F)),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment(1, 0),
                    child: Text(
                      'Posted on :  $widget.time',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 10.0,
                        color: Colors.white54,
                      ),
                    ),
                  )
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}


//full screen image
void showImageFullScreen(BuildContext context, String imageUrl) async{
  await showDialog(
      context: context,
      builder: (BuildContext context){
        return StatefulBuilder(
            builder: (context, setState){
              return AlertDialog(
                  contentPadding: EdgeInsets.zero,
                  insetPadding: EdgeInsets.symmetric(horizontal: 30),
                  content: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CachedNetworkImage(
                        imageUrl: imageUrl
                    ),
                  )
              );
            }
        );
      }
  );
}
// class PersonMsgTile extends StatefulWidget{
//   PersonMsgTile({super.key});
//   @override
//   State<PersonMsgTile> createState() => _PersonMsgTile()
// }
//
// class _PersonMsgTile extends State<PersonMsgTile>{
//
//   @override
//   Widget build(BuildContext context){
//     return GestureDetector(
//       // onTap: () async{
//       //   if (GlobalVariables().name.isNotEmpty) {
//       //     Navigator.push(
//       //       context,
//       //       MaterialPageRoute(
//       //         builder: (context) => MessageWidget(
//       //           receiverId: data['userid'],
//       //           receiverName: data['name'],
//       //           newMessage: message,
//       //         ),
//       //       ),
//       //     );
//       //   } else {
//       //     Navigator.push(
//       //       context,
//       //       MaterialPageRoute(builder: (context) => EditProfile()),
//       //     );
//       //     ScaffoldMessenger.of(context).showSnackBar(
//       //       const SnackBar(
//       //         content: Text('First complete your profile!'),
//       //         backgroundColor: Colors.redAccent,
//       //         duration: Duration(milliseconds: 1000),
//       //       ),
//       //     );
//       //   }
//       // },
//       child: Padding(
//         padding: EdgeInsets.only(top: 8, left: 7, right: 7, bottom: 2),
//         child: Container(
//           width: double.infinity,
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//           decoration: BoxDecoration(
//             gradient: const LinearGradient(
//               colors: [Color(0xFF4A3274), Color(0xFF5C4D91)],
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//             ),
//             borderRadius: BorderRadius.circular(15),
//             boxShadow: [
//               BoxShadow(
//                 color: Color(0x57ff3456),
//                 blurRadius: 5,
//                 offset: Offset(0, 2),
//               ),
//             ],
//           ),
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               SizedBox(
//                 height: 45,
//                 width: 45,
//                 child: Stack(
//                   children: [
//                     Container(
//                       width: 45.0,
//                       height: 45.0,
//                       clipBehavior: Clip.antiAlias,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                       ),
//                       child: CachedNetworkImage(
//                         imageUrl: data['gender']?? false ?
//                         "https://imgs.search.brave.com/ek_J28ierOL93E0C7btwCHh1V0nZyPAKISxj654meLg/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9pbWcu/ZnJlZXBpay5jb20v/cHJlbWl1bS1waG90/by9jYXJ0b29uLWdp/cmwtd2l0aC1sb25n/LWhhaXItYm9vdHMt/c3RhbmRpbmctZnJv/bnQtd2hpdGUtYmFj/a2dyb3VuZC1nZW5l/cmF0aXZlLWFpXzkw/MDgzMy0zODA0My5q/cGc_c2VtdD1haXNf/aHlicmlk"
//                             :
//                         "https://imgs.search.brave.com/Zz7rIOCJbxFVbkrRHGPdpNUfsyd6wne8UTisdu-3pV0/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9pbWcu/ZnJlZXBpay5jb20v/cHJlbWl1bS1waG90/by9jYXJ0b29uLWJv/eS13aXRoLWdyZWVu/LWV5ZXMtYmx1ZS1z/aGlydF8xMDI4ODgy/LTEwNjI2MC5qcGc_/c2VtdD1haXNfaHli/cmlk",
//
//                         placeholder: (context, url) => CircularProgressIndicator(),
//                         errorWidget: (context, url, error) => Icon(Icons.error, color: Colors.red),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                     Align(
//                         alignment: Alignment(0.96, -0.96),
//                         child: data['isOnline'] ?
//                         Icon(
//                           Icons.circle_rounded,
//                           color: Colors.greenAccent,
//                           size: 12,
//                         )
//                             :
//                         Container()
//                     ),
//                   ],
//                 ),
//               ),
//               // Container(
//               //   width: 45.0,
//               //   height: 45.0,
//               //   clipBehavior: Clip.antiAlias,
//               //   decoration: BoxDecoration(
//               //     shape: BoxShape.circle,
//               //   ),
//               //   child: CachedNetworkImage(
//               //     imageUrl: 'https://images.unsplash.com/photo-1569222646742-ed39b7cbb072', // Use the imageUrl parameter
//               //     placeholder: (context, url) => CircularProgressIndicator(),
//               //     errorWidget: (context, url, error) => Icon(Icons.error, color: Colors.red),
//               //     fit: BoxFit.cover,
//               //   ),
//               // ),
//               SizedBox(width: 7),
//               Expanded(
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       data['name'] ?? 'User',
//                       style: TextStyle(
//                         fontFamily: 'Poppins',
//                         fontSize: 17.0,
//                         color: Colors.white,
//                         fontWeight: FontWeight.w500,
//                         //height: 1,
//                       ),
//                     ),
//                     message.isNotEmpty ?
//                     Row(
//                       children: [
//                         Text(
//                           message.length > 30 ?
//                           message.substring(0, 30) + '...' : message, // Display the time appropriately
//                           style: TextStyle(
//                             fontSize: 12,
//                             color: Colors.white70,
//                             //   fontWeight: FontWeight.w500
//                           ),
//                         ),
//                         SizedBox(
//                           height: 22,
//                           width: 26,
//                           child: Card(
//                               child: Center(
//                                 child: Text(
//                                   receiverIDs.length.toString(),
//                                   style: TextStyle(
//                                       fontSize: 10,
//                                       color: Colors.black,
//                                       fontWeight: FontWeight.w500
//                                     //   fontWeight: FontWeight.w500
//                                   ),
//                                 ),
//                               )
//                           ),
//                         )
//                       ],
//                     )
//                         :
//                     data['isOnline'] ?
//                     Text(
//                       "Online...", // Display the time appropriately
//                       style: TextStyle(
//                         fontSize: 12,
//                         color: Colors.green,
//                         //  fontWeight: FontWeight.w500
//                       ),
//                     )
//                         :
//                     data['lastSeen'] != null ? Text(
//                       "Last Online : $formattedTime", // Display the time appropriately
//                       style: TextStyle(
//                         fontSize: 12,
//                         color: Colors.white70,
//                         //  fontWeight: FontWeight.w500
//                       ),
//                     ) : Text(
//                       data['course'], // Display the time appropriately
//                       style: TextStyle(
//                         fontSize: 12,
//                         color: Colors.white70,
//                         //  fontWeight: FontWeight.w500
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               message.isNotEmpty ?
//               Icon(Icons.notifications_active_rounded, color: Colors.yellowAccent)
//                   :
//               Container()
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }