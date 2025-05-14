import 'package:flutter/material.dart';

import 'helper widgets.dart';
class CommunityMessage extends StatefulWidget{
  const CommunityMessage({
    super.key
  });

  @override
  State<CommunityMessage> createState() => _CommunityMessageState();
}

class _CommunityMessageState extends State<CommunityMessage>{

  List<Map<String, dynamic>> quizData = [
    {
      "image": "https://example.com/image1.jpg",
      "name": "Aman Verma",
      "course": "Physics",
      "identityIsShow": true,
      "question": "What is the SI unit of force?",
      "options": ["Newton", "Pascal", "Joule", "Watt"],
      "correctAnswerIndex": 0,
      "quizID": "quiz001",
      "mySelection": -1,
      "singleTime": true,
      "userid": "user001",
      "viewResult": false,
      "delete": false,
      "time": "10:15 AM",
    },
    {
      "image": "https://example.com/image2.jpg",
      "name": "Priya Singh",
      "course": "Biology",
      "identityIsShow": false,
      "question": "Which part of the plant conducts photosynthesis?",
      "options": ["Root", "Stem", "Leaf", "Flower"],
      "correctAnswerIndex": 2,
      "quizID": "quiz002",
      "mySelection": -1,
      "singleTime": true,
      "userid": "user002",
      "viewResult": false,
      "delete": false,
      "time": "11:00 AM",
    },
    {
      "image": "https://example.com/image1.jpg",
      "name": "Aman Verma",
      "course": "Physics",
      "identityIsShow": true,
      "pollText": "Should we have a group study session every weekend?",
      "yes": {"user101": true, "user102": true},
      "no": {"user103": true},
      "pollId": "poll001",
      "userId": "user001","postType" : 0,
      "time": "10:30 AM"
    },
    {
      "image": "https://example.com/image3.jpg",
      "name": "Rahul Mehra",
      "course": "Chemistry",
      "identityIsShow": true,
      "question": "What is H2O commonly known as?",
      "options": ["Salt", "Water", "Oxygen", "Hydrogen"],
      "correctAnswerIndex": 1,
      "quizID": "quiz003",
      "mySelection": -1,
      "singleTime": false,
      "userid": "user003","postType" : 1,
      "viewResult": false,
      "delete": false,
      "time": "12:30 PM",
    },
    {
      "image": "https://example.com/image1.jpg",
      "name": "Aman Verma",
      "course": "Physics",
      "identityIsShow": true,
      "pollText": "Should we have a group study session every weekend?",
      "yes": {"user101": true, "user102": true},
      "no": {"user103": true},
      "pollId": "poll001","postType" : 0,
      "userId": "user001",
      "time": "10:30 AM"
    },
    {
      "image": "https://example.com/image4.jpg",
      "name": "Sneha Patel",
      "course": "Maths",
      "identityIsShow": false,
      "question": "What is 12 × 8?",
      "options": ["96", "88", "104", "100"],
      "correctAnswerIndex": 0,
      "quizID": "quiz004",
      "mySelection": -1,
      "singleTime": true,"postType" : 1,
      "userid": "user004",
      "viewResult": false,
      "delete": false,
      "time": "1:45 PM",
    },
    {
      "image": "https://example.com/image5.jpg",
      "name": "Karan Thakur",
      "course": "History",
      "identityIsShow": true,
      "question": "Who was the first President of India?",
      "options": ["Jawaharlal Nehru", "B. R. Ambedkar", "Rajendra Prasad", "Sardar Patel"],
      "correctAnswerIndex": 2,
      "quizID": "quiz005",
      "postType" : 1,
      "mySelection": -1,
      "singleTime": true,
      "userid": "user005",
      "viewResult": false,
      "delete": false,
      "time": "3:00 PM",
    }
  ];



  @override
  Widget build(BuildContext context){
    return Stack(
      children: [
        ListView.builder(
          cacheExtent: 10000,
          itemCount: quizData.length,
          itemBuilder: (context, index){

            if(quizData[index]['postType'] == 0){
              return BuildPoll(
                updatedShared: (widgetID) async{

                },
                image: quizData[index]['image'],
                name: quizData[index]['name'],
                course: quizData[index]['course'],
                identityIsShow: quizData[index]['identityIsShow'],
                pollText: quizData[index]['pollText'],
                yesCount: quizData[index]['yes'].length,
                noCount: quizData[index]['no'].length,
                pollId: quizData[index]['pollId'],
                isYesChecked: true,
                isNoChecked: false,
                userid: quizData[index]['userId'],
                resultType: false,
                delete: false,
                time: quizData[index]['time'],
              );
            }else {
              return QuizWidget(
                updatedShared: (widgetID) async {},
                image: quizData[index]['image'] ?? '',
                name: quizData[index]['name'] ?? '',
                course: quizData[index]['course'] ?? '',
                identityIsShow: quizData[index]['identityIsShow'] ?? false,
                question: quizData[index]['question'] ?? '',
                options: List<String>.from(quizData[index]['options'] ?? []),
                correctAnswerIndex: quizData[index]['correctAnswerIndex'] ?? -1,
                quizID: quizData[index]['quizID'] ?? '', // FIXED
                mySelection: 1,
                singleTime: quizData[index]['singleTime'] ?? false,
                userid: quizData[index]['userid'] ?? '',
                viewResult: false,
                delete: false,
                time: quizData[index]['time'] ?? '',
              );
            }


          },
        ),
        FloatButton(),
      ],
    );
  }
}
