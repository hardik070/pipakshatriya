import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:path/path.dart' as path;
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:pipakshatriya/datamodels/user_model.dart';
import 'datamodels/datamanager/data_manager.dart';



class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  EditProfileState createState() => EditProfileState();
}

class EditProfileState extends State<EditProfile> {

  final List<TextEditingController> _phoneNumbersController = [];


  bool isSaving = false;
  bool isImageUploading = false;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController fatherNameController = TextEditingController();
  final TextEditingController gotraController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController currentCityController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  String userId = '';
  String profilePicUrl = '';

  List<String> numbers = ["9982875922", "8696282986"];
  List<String> reltionTypes = ["Mama", "Fufa", "Chacha", "Mosa", "Sala", "Sasur", "Sadu", ];
  List<Map<String, String>> relationships = [
    {"Mama" : "Hardikkumar"},
    {"Mama" : "Shayam kumar"},
    {"Chacha" : "Mohan lal"},
    {"Sasur" : "Mohan lal"},
    {"Sala" : "Mohan lal"},
    {"Fufa" : "Ravi Kumar"}
  ];
  List<String> fltdCityList = [];
  List<String> fltdCurrentCityList = [];
  List<String> fltdListGotra = [];
  List<String> gotraList = ["Parmar", "Bhati", "Solanki", "Panwar", "Padhyar", "Makwana", "Dabhi", "Dahiya",];
  List<String> citysList = ["Jodhpur", "Navsari", "Bhinmal", "Daspa", "Surat", "Dhanera", "Pamana", "Virona", "Samrani"];
  Map<String, Map<String, Map<String, dynamic>>> bhinmal = {
    "Samrani" : {

    },
    "daspa" : {
      "Mr Ajmal ji (S-o)  Shri Pratapji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Shri Pratapji",
        "gotra": "Parmar",
        "name": "Mr Ajmal ji",
        "number": "9413854869",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": "",
        "relations": {
          "mama": "Mr Arjun Kumar ji (S-o)  Shri Krishna ji",
          "fufa": "Mr Ambalal ji (S-o)  Shri Babuji",
          "mosa": "Mr Ashok Kumar ji (S-o)  Mr Chogji",
          "chacha": "Mr Ashok ji (S-o)  Mr Poonma ji"
        }
      },
      "Mr Jeetaji (S-o)  Shri Manrupji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Shri Manrupji",
        "gotra": "Padhiyaar",
        "name": "Mr Jeetaji",
        "number": "9549113159",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Jitendra Kumar (S-o)  Shri Roopchand ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Shri Roopchand ji",
        "gotra": "Parmar",
        "name": "Mr Jitendra Kumar",
        "number": "9829248872",
        "number 2": "7296989899",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Kalpesh Kumar (S-o)  Mr Masra ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Mr Masra ji",
        "gotra": "Solanki",
        "name": "Mr Kalpesh Kumar",
        "number": "9979558187",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Kalu ji (S-o)  Mr Moti Ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Mr Moti Ji",
        "gotra": "Parmar",
        "name": "Mr Kalu ji",
        "number": "9460169798",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": "",
        "relations": {
          "sasur ji": "Mr Chandu ji (S-o)  Mr Gheva ji",
          "chacha": "Mr Chandu ji (S-o)  Mr Gheva ji"
        }
      },
      "Mr Kalu ji (S-o)  Mr Poonma ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Mr Poonma ji",
        "gotra": "Dabhi",
        "name": "Mr Kalu ji",
        "number": "9982244898",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Kantilal ji (S-o)  Mr Haka ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Mr Haka ji",
        "gotra": "Makwana",
        "name": "Mr Kantilal ji",
        "number": "9413439191",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Kapoor ji (S-o)  Shri Shankar Ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Shri Shankar Ji",
        "gotra": "Parmar",
        "name": "Mr Kapoor ji",
        "number": "9784717997",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Kapoor ji (S-o)  Shri Shankar ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Shri Shankar ji",
        "gotra": "Parmar",
        "name": "Mr Kapoor ji",
        "number": "9784717997",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Kesa ji (S-o)  Shri Rama Ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Shri Rama Ji",
        "gotra": "Parmar",
        "name": "Mr Kesa ji",
        "number": "9602715500",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Kishore Kumar ji (S-o)  Mr Jamta ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Mr Jamta ji",
        "gotra": "Padhiyaar",
        "name": "Mr Kishore Kumar ji",
        "number": "9982641533",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Kishore ji (S-o)  Shri Trikma Ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Shri Trikma Ji",
        "gotra": "Parmar",
        "name": "Mr Kishore ji",
        "number": "9828231584",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Madan ji (S-o)  Shri Shankar ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Shri Shankar ji",
        "gotra": "Parmar",
        "name": "Mr Madan ji",
        "number": "8003740252",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Mahendra Kumar (S-o)  Mr Jabararam ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Mr Jabararam ji",
        "gotra": "makwana",
        "name": "Mr Mahendra Kumar",
        "number": "9587329044",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Mahendra Kumar (S-o)  Shri Rupchandji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Shri Rupchandji",
        "gotra": "Parmar",
        "name": "Mr Mahendra Kumar",
        "number": "9783323254",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Mahendra ji (S-o)  Mr Himta ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Mr Himta ji",
        "gotra": "Padhiyaar",
        "name": "Mr Mahendra ji",
        "number": "9828489793",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Mahendra ji (S-o)  Mr Nanji Ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Mr Nanji Ji",
        "gotra": "Dabhi",
        "name": "Mr Mahendra ji",
        "number": "9001784576",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Mahendra ji (S-o)  Shri Varda ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Shri Varda ji",
        "gotra": "makwana",
        "name": "Mr Mahendra ji",
        "number": "8239255574",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Manchha ji (S-o)  Shri Trikmaji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Shri Trikmaji",
        "gotra": "Solanki",
        "name": "Mr Manchha ji",
        "number": "9461065565",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
    },
    "suthana" : {
      "Mr Ajmal ji (S-o)  Shri Pratapji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Shri Pratapji",
        "gotra": "Parmar",
        "name": "Mr Ajmal ji",
        "number": "9413854869",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": "",
        "relations": {
          "mama": "Mr Arjun Kumar ji (S-o)  Shri Krishna ji",
          "fufa": "Mr Ambalal ji (S-o)  Shri Babuji",
          "mosa": "Mr Ashok Kumar ji (S-o)  Mr Chogji",
          "chacha": "Mr Ashok ji (S-o)  Mr Poonma ji"
        }
      },
      "Mr Ambalal ji (S-o)  Shri Babuji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Shri Babuji",
        "gotra": "Dabhi",
        "name": "Mr Ambalal ji",
        "number": "8094471215",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": "",
        "relations": {
          "mama": "Mr Bhura ji (S-o)  Mr Dhukha ji",
          "fufa": "Mr Kalu ji (S-o)  Mr Moti Ji",
          "mosa": "Mr Himta ji (S-o)  Mr Pratap ji",
          "chacha": "Mr Dhanraj ji (S-o)  Mr Sonaji",
          "sasur ji": "Mr Hemant Kumar (S-o)  Mr Kantilal ji"
        }
      },
      "Mr Arjun Kumar ji (S-o)  Shri Krishna ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Shri Krishna ji",
        "gotra": "Makwana",
        "name": "Mr Arjun Kumar ji",
        "number": "8875730563",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Ashok Kumar ji (S-o)  Mr Chogji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Mr Chogji",
        "gotra": "Dahiya",
        "name": "Mr Ashok Kumar ji",
        "number": "9602253043",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Ashok Kumar ji (S-o)  Mr Jamta ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Mr Jamta ji",
        "gotra": "Padhiyaar",
        "name": "Mr Ashok Kumar ji",
        "number": "9602108893",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Ashok ji (S-o)  Mr Samera ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Mr Samera ji",
        "gotra": "Parmar",
        "name": "Mr Ashok ji",
        "number": "8094521138",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Ashok ji (S-o)  Mr Sura Ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Mr Sura Ji",
        "gotra": "Makwana",
        "name": "Mr Ashok ji",
        "number": "9672797381",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Babu Ji (S-o)  Mr Fullaji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Mr Fullaji",
        "gotra": "Solanki",
        "name": "Mr Babu Ji",
        "number": "7568432067",
        "number 2": "9549744952",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Bagda ji (S-o)  Mr Gaja ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Mr Gaja ji",
        "gotra": "Solanki",
        "name": "Mr Bagda ji",
        "number": "9829457034",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Jeetaji (S-o)  Shri Manrupji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Shri Manrupji",
        "gotra": "Padhiyaar",
        "name": "Mr Jeetaji",
        "number": "9549113159",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Jitendra Kumar (S-o)  Shri Roopchand ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Shri Roopchand ji",
        "gotra": "Parmar",
        "name": "Mr Jitendra Kumar",
        "number": "9829248872",
        "number 2": "7296989899",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Kalpesh Kumar (S-o)  Mr Masra ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Mr Masra ji",
        "gotra": "Solanki",
        "name": "Mr Kalpesh Kumar",
        "number": "9979558187",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Kalu ji (S-o)  Mr Moti Ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Mr Moti Ji",
        "gotra": "Parmar",
        "name": "Mr Kalu ji",
        "number": "9460169798",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": "",
        "relations": {
          "sasur ji": "Mr Chandu ji (S-o)  Mr Gheva ji",
          "chacha": "Mr Chandu ji (S-o)  Mr Gheva ji"
        }
      },
      "Mr Kalu ji (S-o)  Mr Poonma ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Mr Poonma ji",
        "gotra": "Dabhi",
        "name": "Mr Kalu ji",
        "number": "9982244898",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Kantilal ji (S-o)  Mr Haka ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Mr Haka ji",
        "gotra": "Makwana",
        "name": "Mr Kantilal ji",
        "number": "9413439191",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Kapoor ji (S-o)  Shri Shankar Ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Shri Shankar Ji",
        "gotra": "Parmar",
        "name": "Mr Kapoor ji",
        "number": "9784717997",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Kapoor ji (S-o)  Shri Shankar ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Shri Shankar ji",
        "gotra": "Parmar",
        "name": "Mr Kapoor ji",
        "number": "9784717997",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Kesa ji (S-o)  Shri Rama Ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Shri Rama Ji",
        "gotra": "Parmar",
        "name": "Mr Kesa ji",
        "number": "9602715500",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Kishore Kumar ji (S-o)  Mr Jamta ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Mr Jamta ji",
        "gotra": "Padhiyaar",
        "name": "Mr Kishore Kumar ji",
        "number": "9982641533",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Kishore ji (S-o)  Shri Trikma Ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Shri Trikma Ji",
        "gotra": "Parmar",
        "name": "Mr Kishore ji",
        "number": "9828231584",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Madan ji (S-o)  Shri Shankar ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Shri Shankar ji",
        "gotra": "Parmar",
        "name": "Mr Madan ji",
        "number": "8003740252",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Mahendra Kumar (S-o)  Mr Jabararam ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Mr Jabararam ji",
        "gotra": "makwana",
        "name": "Mr Mahendra Kumar",
        "number": "9587329044",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Mahendra Kumar (S-o)  Shri Rupchandji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Shri Rupchandji",
        "gotra": "Parmar",
        "name": "Mr Mahendra Kumar",
        "number": "9783323254",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Mahendra ji (S-o)  Mr Himta ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Mr Himta ji",
        "gotra": "Padhiyaar",
        "name": "Mr Mahendra ji",
        "number": "9828489793",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Mahendra ji (S-o)  Mr Nanji Ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Mr Nanji Ji",
        "gotra": "Dabhi",
        "name": "Mr Mahendra ji",
        "number": "9001784576",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Mahendra ji (S-o)  Shri Varda ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Shri Varda ji",
        "gotra": "makwana",
        "name": "Mr Mahendra ji",
        "number": "8239255574",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Manchha ji (S-o)  Shri Trikmaji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Shri Trikmaji",
        "gotra": "Solanki",
        "name": "Mr Manchha ji",
        "number": "9461065565",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
    },
    "Bhinmal" : {
      "Mr Ajmal ji (S-o)  Shri Pratapji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Shri Pratapji",
        "gotra": "Parmar",
        "name": "Mr Ajmal ji",
        "number": "9413854869",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": "",
        "relations": {
          "mama": "Mr Arjun Kumar ji (S-o)  Shri Krishna ji",
          "fufa": "Mr Ambalal ji (S-o)  Shri Babuji",
          "mosa": "Mr Ashok Kumar ji (S-o)  Mr Chogji",
          "chacha": "Mr Ashok ji (S-o)  Mr Poonma ji"
        }
      },
      "Mr Ambalal ji (S-o)  Shri Babuji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Shri Babuji",
        "gotra": "Dabhi",
        "name": "Mr Ambalal ji",
        "number": "8094471215",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": "",
        "relations": {
          "mama": "Mr Bhura ji (S-o)  Mr Dhukha ji",
          "fufa": "Mr Kalu ji (S-o)  Mr Moti Ji",
          "mosa": "Mr Himta ji (S-o)  Mr Pratap ji",
          "chacha": "Mr Dhanraj ji (S-o)  Mr Sonaji",
          "sasur ji": "Mr Hemant Kumar (S-o)  Mr Kantilal ji"
        }
      },
      "Mr Arjun Kumar ji (S-o)  Shri Krishna ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Shri Krishna ji",
        "gotra": "Makwana",
        "name": "Mr Arjun Kumar ji",
        "number": "8875730563",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Ashok Kumar ji (S-o)  Mr Chogji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Mr Chogji",
        "gotra": "Dahiya",
        "name": "Mr Ashok Kumar ji",
        "number": "9602253043",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Ashok Kumar ji (S-o)  Mr Jamta ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Mr Jamta ji",
        "gotra": "Padhiyaar",
        "name": "Mr Ashok Kumar ji",
        "number": "9602108893",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Ashok ji (S-o)  Mr Samera ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Mr Samera ji",
        "gotra": "Parmar",
        "name": "Mr Ashok ji",
        "number": "8094521138",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Ashok ji (S-o)  Mr Sura Ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Mr Sura Ji",
        "gotra": "Makwana",
        "name": "Mr Ashok ji",
        "number": "9672797381",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Babu Ji (S-o)  Mr Fullaji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Mr Fullaji",
        "gotra": "Solanki",
        "name": "Mr Babu Ji",
        "number": "7568432067",
        "number 2": "9549744952",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Bagda ji (S-o)  Mr Gaja ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Mr Gaja ji",
        "gotra": "Solanki",
        "name": "Mr Bagda ji",
        "number": "9829457034",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Jeetaji (S-o)  Shri Manrupji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Shri Manrupji",
        "gotra": "Padhiyaar",
        "name": "Mr Jeetaji",
        "number": "9549113159",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Jitendra Kumar (S-o)  Shri Roopchand ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Shri Roopchand ji",
        "gotra": "Parmar",
        "name": "Mr Jitendra Kumar",
        "number": "9829248872",
        "number 2": "7296989899",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Kalpesh Kumar (S-o)  Mr Masra ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Mr Masra ji",
        "gotra": "Solanki",
        "name": "Mr Kalpesh Kumar",
        "number": "9979558187",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Kalu ji (S-o)  Mr Moti Ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Mr Moti Ji",
        "gotra": "Parmar",
        "name": "Mr Kalu ji",
        "number": "9460169798",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": "",
        "relations": {
          "sasur ji": "Mr Chandu ji (S-o)  Mr Gheva ji",
          "chacha": "Mr Chandu ji (S-o)  Mr Gheva ji"
        }
      },
      "Mr Kalu ji (S-o)  Mr Poonma ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Mr Poonma ji",
        "gotra": "Dabhi",
        "name": "Mr Kalu ji",
        "number": "9982244898",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Kantilal ji (S-o)  Mr Haka ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Mr Haka ji",
        "gotra": "Makwana",
        "name": "Mr Kantilal ji",
        "number": "9413439191",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Kapoor ji (S-o)  Shri Shankar Ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Shri Shankar Ji",
        "gotra": "Parmar",
        "name": "Mr Kapoor ji",
        "number": "9784717997",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Kapoor ji (S-o)  Shri Shankar ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Shri Shankar ji",
        "gotra": "Parmar",
        "name": "Mr Kapoor ji",
        "number": "9784717997",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Kesa ji (S-o)  Shri Rama Ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Shri Rama Ji",
        "gotra": "Parmar",
        "name": "Mr Kesa ji",
        "number": "9602715500",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Kishore Kumar ji (S-o)  Mr Jamta ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Mr Jamta ji",
        "gotra": "Padhiyaar",
        "name": "Mr Kishore Kumar ji",
        "number": "9982641533",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Kishore ji (S-o)  Shri Trikma Ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Shri Trikma Ji",
        "gotra": "Parmar",
        "name": "Mr Kishore ji",
        "number": "9828231584",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Madan ji (S-o)  Shri Shankar ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Shri Shankar ji",
        "gotra": "Parmar",
        "name": "Mr Madan ji",
        "number": "8003740252",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Mahendra Kumar (S-o)  Mr Jabararam ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Mr Jabararam ji",
        "gotra": "makwana",
        "name": "Mr Mahendra Kumar",
        "number": "9587329044",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Mahendra Kumar (S-o)  Shri Rupchandji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Shri Rupchandji",
        "gotra": "Parmar",
        "name": "Mr Mahendra Kumar",
        "number": "9783323254",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Mahendra ji (S-o)  Mr Himta ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Mr Himta ji",
        "gotra": "Padhiyaar",
        "name": "Mr Mahendra ji",
        "number": "9828489793",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Mahendra ji (S-o)  Mr Nanji Ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Mr Nanji Ji",
        "gotra": "Dabhi",
        "name": "Mr Mahendra ji",
        "number": "9001784576",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Mahendra ji (S-o)  Shri Varda ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Shri Varda ji",
        "gotra": "makwana",
        "name": "Mr Mahendra ji",
        "number": "8239255574",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Manchha ji (S-o)  Shri Trikmaji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Shri Trikmaji",
        "gotra": "Solanki",
        "name": "Mr Manchha ji",
        "number": "9461065565",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
    },
    "Sansore" : {
      "Mr Ajmal ji (S-o)  Shri Pratapji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Shri Pratapji",
        "gotra": "Parmar",
        "name": "Mr Ajmal ji",
        "number": "9413854869",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": "",
        "relations": {
          "mama": "Mr Arjun Kumar ji (S-o)  Shri Krishna ji",
          "fufa": "Mr Ambalal ji (S-o)  Shri Babuji",
          "mosa": "Mr Ashok Kumar ji (S-o)  Mr Chogji",
          "chacha": "Mr Ashok ji (S-o)  Mr Poonma ji"
        }
      },
      "Mr Ambalal ji (S-o)  Shri Babuji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Shri Babuji",
        "gotra": "Dabhi",
        "name": "Mr Ambalal ji",
        "number": "8094471215",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": "",
        "relations": {
          "mama": "Mr Bhura ji (S-o)  Mr Dhukha ji",
          "fufa": "Mr Kalu ji (S-o)  Mr Moti Ji",
          "mosa": "Mr Himta ji (S-o)  Mr Pratap ji",
          "chacha": "Mr Dhanraj ji (S-o)  Mr Sonaji",
          "sasur ji": "Mr Hemant Kumar (S-o)  Mr Kantilal ji"
        }
      },
      "Mr Arjun Kumar ji (S-o)  Shri Krishna ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Shri Krishna ji",
        "gotra": "Makwana",
        "name": "Mr Arjun Kumar ji",
        "number": "8875730563",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Ashok Kumar ji (S-o)  Mr Chogji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Mr Chogji",
        "gotra": "Dahiya",
        "name": "Mr Ashok Kumar ji",
        "number": "9602253043",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Ashok Kumar ji (S-o)  Mr Jamta ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Mr Jamta ji",
        "gotra": "Padhiyaar",
        "name": "Mr Ashok Kumar ji",
        "number": "9602108893",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Ashok ji (S-o)  Mr Samera ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Mr Samera ji",
        "gotra": "Parmar",
        "name": "Mr Ashok ji",
        "number": "8094521138",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Ashok ji (S-o)  Mr Sura Ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Mr Sura Ji",
        "gotra": "Makwana",
        "name": "Mr Ashok ji",
        "number": "9672797381",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Babu Ji (S-o)  Mr Fullaji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Mr Fullaji",
        "gotra": "Solanki",
        "name": "Mr Babu Ji",
        "number": "7568432067",
        "number 2": "9549744952",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Bagda ji (S-o)  Mr Gaja ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Mr Gaja ji",
        "gotra": "Solanki",
        "name": "Mr Bagda ji",
        "number": "9829457034",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Jeetaji (S-o)  Shri Manrupji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Shri Manrupji",
        "gotra": "Padhiyaar",
        "name": "Mr Jeetaji",
        "number": "9549113159",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Jitendra Kumar (S-o)  Shri Roopchand ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Shri Roopchand ji",
        "gotra": "Parmar",
        "name": "Mr Jitendra Kumar",
        "number": "9829248872",
        "number 2": "7296989899",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Kalpesh Kumar (S-o)  Mr Masra ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Mr Masra ji",
        "gotra": "Solanki",
        "name": "Mr Kalpesh Kumar",
        "number": "9979558187",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Kalu ji (S-o)  Mr Moti Ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Mr Moti Ji",
        "gotra": "Parmar",
        "name": "Mr Kalu ji",
        "number": "9460169798",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": "",
        "relations": {
          "sasur ji": "Mr Chandu ji (S-o)  Mr Gheva ji",
          "chacha": "Mr Chandu ji (S-o)  Mr Gheva ji"
        }
      },
      "Mr Kalu ji (S-o)  Mr Poonma ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Mr Poonma ji",
        "gotra": "Dabhi",
        "name": "Mr Kalu ji",
        "number": "9982244898",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Kantilal ji (S-o)  Mr Haka ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Mr Haka ji",
        "gotra": "Makwana",
        "name": "Mr Kantilal ji",
        "number": "9413439191",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Kapoor ji (S-o)  Shri Shankar Ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Shri Shankar Ji",
        "gotra": "Parmar",
        "name": "Mr Kapoor ji",
        "number": "9784717997",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Kapoor ji (S-o)  Shri Shankar ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Shri Shankar ji",
        "gotra": "Parmar",
        "name": "Mr Kapoor ji",
        "number": "9784717997",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Kesa ji (S-o)  Shri Rama Ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Shri Rama Ji",
        "gotra": "Parmar",
        "name": "Mr Kesa ji",
        "number": "9602715500",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Kishore Kumar ji (S-o)  Mr Jamta ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Mr Jamta ji",
        "gotra": "Padhiyaar",
        "name": "Mr Kishore Kumar ji",
        "number": "9982641533",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Kishore ji (S-o)  Shri Trikma Ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Shri Trikma Ji",
        "gotra": "Parmar",
        "name": "Mr Kishore ji",
        "number": "9828231584",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Madan ji (S-o)  Shri Shankar ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Shri Shankar ji",
        "gotra": "Parmar",
        "name": "Mr Madan ji",
        "number": "8003740252",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Mahendra Kumar (S-o)  Mr Jabararam ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Mr Jabararam ji",
        "gotra": "makwana",
        "name": "Mr Mahendra Kumar",
        "number": "9587329044",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Mahendra Kumar (S-o)  Shri Rupchandji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Shri Rupchandji",
        "gotra": "Parmar",
        "name": "Mr Mahendra Kumar",
        "number": "9783323254",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Mahendra ji (S-o)  Mr Himta ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Mr Himta ji",
        "gotra": "Padhiyaar",
        "name": "Mr Mahendra ji",
        "number": "9828489793",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Mahendra ji (S-o)  Mr Nanji Ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Mr Nanji Ji",
        "gotra": "Dabhi",
        "name": "Mr Mahendra ji",
        "number": "9001784576",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Mahendra ji (S-o)  Shri Varda ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Shri Varda ji",
        "gotra": "makwana",
        "name": "Mr Mahendra ji",
        "number": "8239255574",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Manchha ji (S-o)  Shri Trikmaji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Shri Trikmaji",
        "gotra": "Solanki",
        "name": "Mr Manchha ji",
        "number": "9461065565",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
    },
    "Bhimpura" : {
      "Mr Ajmal ji (S-o)  Shri Pratapji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Shri Pratapji",
        "gotra": "Parmar",
        "name": "Mr Ajmal ji",
        "number": "9413854869",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": "",
        "relations": {
          "mama": "Mr Arjun Kumar ji (S-o)  Shri Krishna ji",
          "fufa": "Mr Ambalal ji (S-o)  Shri Babuji",
          "mosa": "Mr Ashok Kumar ji (S-o)  Mr Chogji",
          "chacha": "Mr Ashok ji (S-o)  Mr Poonma ji"
        }
      },
      "Mr Ambalal ji (S-o)  Shri Babuji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Shri Babuji",
        "gotra": "Dabhi",
        "name": "Mr Ambalal ji",
        "number": "8094471215",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": "",
        "relations": {
          "mama": "Mr Bhura ji (S-o)  Mr Dhukha ji",
          "fufa": "Mr Kalu ji (S-o)  Mr Moti Ji",
          "mosa": "Mr Himta ji (S-o)  Mr Pratap ji",
          "chacha": "Mr Dhanraj ji (S-o)  Mr Sonaji",
          "sasur ji": "Mr Hemant Kumar (S-o)  Mr Kantilal ji"
        }
      },
      "Mr Arjun Kumar ji (S-o)  Shri Krishna ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Shri Krishna ji",
        "gotra": "Makwana",
        "name": "Mr Arjun Kumar ji",
        "number": "8875730563",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Ashok Kumar ji (S-o)  Mr Chogji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Mr Chogji",
        "gotra": "Dahiya",
        "name": "Mr Ashok Kumar ji",
        "number": "9602253043",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Ashok Kumar ji (S-o)  Mr Jamta ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Mr Jamta ji",
        "gotra": "Padhiyaar",
        "name": "Mr Ashok Kumar ji",
        "number": "9602108893",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Ashok ji (S-o)  Mr Samera ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Mr Samera ji",
        "gotra": "Parmar",
        "name": "Mr Ashok ji",
        "number": "8094521138",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Ashok ji (S-o)  Mr Sura Ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Mr Sura Ji",
        "gotra": "Makwana",
        "name": "Mr Ashok ji",
        "number": "9672797381",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Babu Ji (S-o)  Mr Fullaji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Mr Fullaji",
        "gotra": "Solanki",
        "name": "Mr Babu Ji",
        "number": "7568432067",
        "number 2": "9549744952",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Bagda ji (S-o)  Mr Gaja ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Mr Gaja ji",
        "gotra": "Solanki",
        "name": "Mr Bagda ji",
        "number": "9829457034",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Jeetaji (S-o)  Shri Manrupji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Shri Manrupji",
        "gotra": "Padhiyaar",
        "name": "Mr Jeetaji",
        "number": "9549113159",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Jitendra Kumar (S-o)  Shri Roopchand ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Shri Roopchand ji",
        "gotra": "Parmar",
        "name": "Mr Jitendra Kumar",
        "number": "9829248872",
        "number 2": "7296989899",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Kalpesh Kumar (S-o)  Mr Masra ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Mr Masra ji",
        "gotra": "Solanki",
        "name": "Mr Kalpesh Kumar",
        "number": "9979558187",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Kalu ji (S-o)  Mr Moti Ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Mr Moti Ji",
        "gotra": "Parmar",
        "name": "Mr Kalu ji",
        "number": "9460169798",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": "",
        "relations": {
          "sasur ji": "Mr Chandu ji (S-o)  Mr Gheva ji",
          "chacha": "Mr Chandu ji (S-o)  Mr Gheva ji"
        }
      },
      "Mr Kalu ji (S-o)  Mr Poonma ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Mr Poonma ji",
        "gotra": "Dabhi",
        "name": "Mr Kalu ji",
        "number": "9982244898",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Kantilal ji (S-o)  Mr Haka ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Mr Haka ji",
        "gotra": "Makwana",
        "name": "Mr Kantilal ji",
        "number": "9413439191",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Kapoor ji (S-o)  Shri Shankar Ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Shri Shankar Ji",
        "gotra": "Parmar",
        "name": "Mr Kapoor ji",
        "number": "9784717997",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Kapoor ji (S-o)  Shri Shankar ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Shri Shankar ji",
        "gotra": "Parmar",
        "name": "Mr Kapoor ji",
        "number": "9784717997",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Kesa ji (S-o)  Shri Rama Ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Shri Rama Ji",
        "gotra": "Parmar",
        "name": "Mr Kesa ji",
        "number": "9602715500",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Kishore Kumar ji (S-o)  Mr Jamta ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Mr Jamta ji",
        "gotra": "Padhiyaar",
        "name": "Mr Kishore Kumar ji",
        "number": "9982641533",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Kishore ji (S-o)  Shri Trikma Ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Shri Trikma Ji",
        "gotra": "Parmar",
        "name": "Mr Kishore ji",
        "number": "9828231584",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Madan ji (S-o)  Shri Shankar ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Shri Shankar ji",
        "gotra": "Parmar",
        "name": "Mr Madan ji",
        "number": "8003740252",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Mahendra Kumar (S-o)  Mr Jabararam ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Mr Jabararam ji",
        "gotra": "makwana",
        "name": "Mr Mahendra Kumar",
        "number": "9587329044",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Mahendra Kumar (S-o)  Shri Rupchandji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Shri Rupchandji",
        "gotra": "Parmar",
        "name": "Mr Mahendra Kumar",
        "number": "9783323254",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Mahendra ji (S-o)  Mr Himta ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Mr Himta ji",
        "gotra": "Padhiyaar",
        "name": "Mr Mahendra ji",
        "number": "9828489793",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Mahendra ji (S-o)  Mr Nanji Ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Mr Nanji Ji",
        "gotra": "Dabhi",
        "name": "Mr Mahendra ji",
        "number": "9001784576",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Mahendra ji (S-o)  Shri Varda ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Shri Varda ji",
        "gotra": "makwana",
        "name": "Mr Mahendra ji",
        "number": "8239255574",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Manchha ji (S-o)  Shri Trikmaji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Shri Trikmaji",
        "gotra": "Solanki",
        "name": "Mr Manchha ji",
        "number": "9461065565",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
    },
    "Navsari" : {
      "Mr Ajmal ji (S-o)  Shri Pratapji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Shri Pratapji",
        "gotra": "Parmar",
        "name": "Mr Ajmal ji",
        "number": "9413854869",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": "",
        "relations": {
          "mama": "Mr Arjun Kumar ji (S-o)  Shri Krishna ji",
          "fufa": "Mr Ambalal ji (S-o)  Shri Babuji",
          "mosa": "Mr Ashok Kumar ji (S-o)  Mr Chogji",
          "chacha": "Mr Ashok ji (S-o)  Mr Poonma ji"
        }
      },
      "Mr Ambalal ji (S-o)  Shri Babuji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Shri Babuji",
        "gotra": "Dabhi",
        "name": "Mr Ambalal ji",
        "number": "8094471215",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": "",
        "relations": {
          "mama": "Mr Bhura ji (S-o)  Mr Dhukha ji",
          "fufa": "Mr Kalu ji (S-o)  Mr Moti Ji",
          "mosa": "Mr Himta ji (S-o)  Mr Pratap ji",
          "chacha": "Mr Dhanraj ji (S-o)  Mr Sonaji",
          "sasur ji": "Mr Hemant Kumar (S-o)  Mr Kantilal ji"
        }
      },
      "Mr Arjun Kumar ji (S-o)  Shri Krishna ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Shri Krishna ji",
        "gotra": "Makwana",
        "name": "Mr Arjun Kumar ji",
        "number": "8875730563",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Ashok Kumar ji (S-o)  Mr Chogji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Mr Chogji",
        "gotra": "Dahiya",
        "name": "Mr Ashok Kumar ji",
        "number": "9602253043",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Ashok Kumar ji (S-o)  Mr Jamta ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Mr Jamta ji",
        "gotra": "Padhiyaar",
        "name": "Mr Ashok Kumar ji",
        "number": "9602108893",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Ashok ji (S-o)  Mr Samera ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Mr Samera ji",
        "gotra": "Parmar",
        "name": "Mr Ashok ji",
        "number": "8094521138",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Ashok ji (S-o)  Mr Sura Ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Mr Sura Ji",
        "gotra": "Makwana",
        "name": "Mr Ashok ji",
        "number": "9672797381",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Babu Ji (S-o)  Mr Fullaji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Mr Fullaji",
        "gotra": "Solanki",
        "name": "Mr Babu Ji",
        "number": "7568432067",
        "number 2": "9549744952",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Bagda ji (S-o)  Mr Gaja ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Mr Gaja ji",
        "gotra": "Solanki",
        "name": "Mr Bagda ji",
        "number": "9829457034",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Jeetaji (S-o)  Shri Manrupji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Shri Manrupji",
        "gotra": "Padhiyaar",
        "name": "Mr Jeetaji",
        "number": "9549113159",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Jitendra Kumar (S-o)  Shri Roopchand ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Shri Roopchand ji",
        "gotra": "Parmar",
        "name": "Mr Jitendra Kumar",
        "number": "9829248872",
        "number 2": "7296989899",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Kalpesh Kumar (S-o)  Mr Masra ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Mr Masra ji",
        "gotra": "Solanki",
        "name": "Mr Kalpesh Kumar",
        "number": "9979558187",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Kalu ji (S-o)  Mr Moti Ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Mr Moti Ji",
        "gotra": "Parmar",
        "name": "Mr Kalu ji",
        "number": "9460169798",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": "",
        "relations": {
          "sasur ji": "Mr Chandu ji (S-o)  Mr Gheva ji",
          "chacha": "Mr Chandu ji (S-o)  Mr Gheva ji"
        }
      },
      "Mr Kalu ji (S-o)  Mr Poonma ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Mr Poonma ji",
        "gotra": "Dabhi",
        "name": "Mr Kalu ji",
        "number": "9982244898",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Kantilal ji (S-o)  Mr Haka ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Mr Haka ji",
        "gotra": "Makwana",
        "name": "Mr Kantilal ji",
        "number": "9413439191",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Kapoor ji (S-o)  Shri Shankar Ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Shri Shankar Ji",
        "gotra": "Parmar",
        "name": "Mr Kapoor ji",
        "number": "9784717997",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Kapoor ji (S-o)  Shri Shankar ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Shri Shankar ji",
        "gotra": "Parmar",
        "name": "Mr Kapoor ji",
        "number": "9784717997",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Kesa ji (S-o)  Shri Rama Ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Shri Rama Ji",
        "gotra": "Parmar",
        "name": "Mr Kesa ji",
        "number": "9602715500",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Kishore Kumar ji (S-o)  Mr Jamta ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Mr Jamta ji",
        "gotra": "Padhiyaar",
        "name": "Mr Kishore Kumar ji",
        "number": "9982641533",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Kishore ji (S-o)  Shri Trikma Ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Shri Trikma Ji",
        "gotra": "Parmar",
        "name": "Mr Kishore ji",
        "number": "9828231584",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Madan ji (S-o)  Shri Shankar ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Shri Shankar ji",
        "gotra": "Parmar",
        "name": "Mr Madan ji",
        "number": "8003740252",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Mahendra Kumar (S-o)  Mr Jabararam ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Mr Jabararam ji",
        "gotra": "makwana",
        "name": "Mr Mahendra Kumar",
        "number": "9587329044",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Mahendra Kumar (S-o)  Shri Rupchandji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Shri Rupchandji",
        "gotra": "Parmar",
        "name": "Mr Mahendra Kumar",
        "number": "9783323254",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Mahendra ji (S-o)  Mr Himta ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Mr Himta ji",
        "gotra": "Padhiyaar",
        "name": "Mr Mahendra ji",
        "number": "9828489793",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Mahendra ji (S-o)  Mr Nanji Ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Mr Nanji Ji",
        "gotra": "Dabhi",
        "name": "Mr Mahendra ji",
        "number": "9001784576",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Mahendra ji (S-o)  Shri Varda ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Shri Varda ji",
        "gotra": "makwana",
        "name": "Mr Mahendra ji",
        "number": "8239255574",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Manchha ji (S-o)  Shri Trikmaji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Shri Trikmaji",
        "gotra": "Solanki",
        "name": "Mr Manchha ji",
        "number": "9461065565",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
    },
    "Bevta" : {
      "Mr Ajmal ji (S-o)  Shri Pratapji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Shri Pratapji",
        "gotra": "Parmar",
        "name": "Mr Ajmal ji",
        "number": "9413854869",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": "",
        "relations": {
          "mama": "Mr Arjun Kumar ji (S-o)  Shri Krishna ji",
          "fufa": "Mr Ambalal ji (S-o)  Shri Babuji",
          "mosa": "Mr Ashok Kumar ji (S-o)  Mr Chogji",
          "chacha": "Mr Ashok ji (S-o)  Mr Poonma ji"
        }
      },
      "Mr Ambalal ji (S-o)  Shri Babuji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Shri Babuji",
        "gotra": "Dabhi",
        "name": "Mr Ambalal ji",
        "number": "8094471215",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": "",
        "relations": {
          "mama": "Mr Bhura ji (S-o)  Mr Dhukha ji",
          "fufa": "Mr Kalu ji (S-o)  Mr Moti Ji",
          "mosa": "Mr Himta ji (S-o)  Mr Pratap ji",
          "chacha": "Mr Dhanraj ji (S-o)  Mr Sonaji",
          "sasur ji": "Mr Hemant Kumar (S-o)  Mr Kantilal ji"
        }
      },
      "Mr Arjun Kumar ji (S-o)  Shri Krishna ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Shri Krishna ji",
        "gotra": "Makwana",
        "name": "Mr Arjun Kumar ji",
        "number": "8875730563",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Ashok Kumar ji (S-o)  Mr Chogji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Mr Chogji",
        "gotra": "Dahiya",
        "name": "Mr Ashok Kumar ji",
        "number": "9602253043",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Ashok Kumar ji (S-o)  Mr Jamta ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Mr Jamta ji",
        "gotra": "Padhiyaar",
        "name": "Mr Ashok Kumar ji",
        "number": "9602108893",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Ashok ji (S-o)  Mr Samera ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Mr Samera ji",
        "gotra": "Parmar",
        "name": "Mr Ashok ji",
        "number": "8094521138",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Ashok ji (S-o)  Mr Sura Ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Mr Sura Ji",
        "gotra": "Makwana",
        "name": "Mr Ashok ji",
        "number": "9672797381",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Babu Ji (S-o)  Mr Fullaji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Mr Fullaji",
        "gotra": "Solanki",
        "name": "Mr Babu Ji",
        "number": "7568432067",
        "number 2": "9549744952",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Bagda ji (S-o)  Mr Gaja ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Mr Gaja ji",
        "gotra": "Solanki",
        "name": "Mr Bagda ji",
        "number": "9829457034",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Jeetaji (S-o)  Shri Manrupji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Shri Manrupji",
        "gotra": "Padhiyaar",
        "name": "Mr Jeetaji",
        "number": "9549113159",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Jitendra Kumar (S-o)  Shri Roopchand ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Shri Roopchand ji",
        "gotra": "Parmar",
        "name": "Mr Jitendra Kumar",
        "number": "9829248872",
        "number 2": "7296989899",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Kalpesh Kumar (S-o)  Mr Masra ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Mr Masra ji",
        "gotra": "Solanki",
        "name": "Mr Kalpesh Kumar",
        "number": "9979558187",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Kalu ji (S-o)  Mr Moti Ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Mr Moti Ji",
        "gotra": "Parmar",
        "name": "Mr Kalu ji",
        "number": "9460169798",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": "",
        "relations": {
          "sasur ji": "Mr Chandu ji (S-o)  Mr Gheva ji",
          "chacha": "Mr Chandu ji (S-o)  Mr Gheva ji"
        }
      },
      "Mr Kalu ji (S-o)  Mr Poonma ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Mr Poonma ji",
        "gotra": "Dabhi",
        "name": "Mr Kalu ji",
        "number": "9982244898",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Kantilal ji (S-o)  Mr Haka ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Mr Haka ji",
        "gotra": "Makwana",
        "name": "Mr Kantilal ji",
        "number": "9413439191",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Kapoor ji (S-o)  Shri Shankar Ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Shri Shankar Ji",
        "gotra": "Parmar",
        "name": "Mr Kapoor ji",
        "number": "9784717997",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Kapoor ji (S-o)  Shri Shankar ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Shri Shankar ji",
        "gotra": "Parmar",
        "name": "Mr Kapoor ji",
        "number": "9784717997",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Kesa ji (S-o)  Shri Rama Ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Shri Rama Ji",
        "gotra": "Parmar",
        "name": "Mr Kesa ji",
        "number": "9602715500",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Kishore Kumar ji (S-o)  Mr Jamta ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Mr Jamta ji",
        "gotra": "Padhiyaar",
        "name": "Mr Kishore Kumar ji",
        "number": "9982641533",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Kishore ji (S-o)  Shri Trikma Ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Shri Trikma Ji",
        "gotra": "Parmar",
        "name": "Mr Kishore ji",
        "number": "9828231584",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Madan ji (S-o)  Shri Shankar ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Shri Shankar ji",
        "gotra": "Parmar",
        "name": "Mr Madan ji",
        "number": "8003740252",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Mahendra Kumar (S-o)  Mr Jabararam ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Mr Jabararam ji",
        "gotra": "makwana",
        "name": "Mr Mahendra Kumar",
        "number": "9587329044",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Mahendra Kumar (S-o)  Shri Rupchandji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Shri Rupchandji",
        "gotra": "Parmar",
        "name": "Mr Mahendra Kumar",
        "number": "9783323254",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Mahendra ji (S-o)  Mr Himta ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Mr Himta ji",
        "gotra": "Padhiyaar",
        "name": "Mr Mahendra ji",
        "number": "9828489793",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Mahendra ji (S-o)  Mr Nanji Ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Mr Nanji Ji",
        "gotra": "Dabhi",
        "name": "Mr Mahendra ji",
        "number": "9001784576",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Mahendra ji (S-o)  Shri Varda ji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Shri Varda ji",
        "gotra": "makwana",
        "name": "Mr Mahendra ji",
        "number": "8239255574",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
      "Mr Manchha ji (S-o)  Shri Trikmaji": {
        "address": "Bhinmal",
        "current living address": "",
        "father name": "Shri Trikmaji",
        "gotra": "Solanki",
        "name": "Mr Manchha ji",
        "number": "9461065565",
        "number 2": "",
        "number 3": "",
        "pin code": "",
        "work": ""
      },
    },
  };
  double _uploadProgress = 0.0;
  @override
  void initState() {
    super.initState();
    emailController.text = UserDataManager().currentUser!.email;
    nameController.text = UserDataManager().currentUser!.name;
    fatherNameController.text = UserDataManager().currentUser!.fatherName;
    gotraController.text = UserDataManager().currentUser!.gotra;
    cityController.text = UserDataManager().currentUser!.actualAddress;
    currentCityController.text = UserDataManager().currentUser!.currentAddress;
    userId = UserDataManager().currentUser!.userId;
    profilePicUrl = UserDataManager().currentUser?.profilePic ?? '';
    numbers = List.from(UserDataManager().currentUser!.phoneNumber);
    relationships = List.from(UserDataManager().currentUser!.relationships);
    if(numbers.isNotEmpty){
      createNumberController();
    }else {
      _phoneNumbersController.add(TextEditingController());
      _phoneNumbersController.add(TextEditingController());
    }

    if(relationships.isEmpty){
      _addRelationMakingTile("Fufa");
      _addRelationMakingTile("Chacha");
    }

  }

  final ImagePicker _picker = ImagePicker();
  String? uploadedImageUrl;
  File? _profileImage;
  XFile? pickedFile;
  File? compresedImage;

  // Future<void> pickAndUploadImage() async {
  //   statusId = true;
  //   try {
  //
  //     pickedFile = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 20);
  //     if (pickedFile == null) {
  //       return;
  //     }
  //     setState(() {
  //       _profileImage = File(pickedFile!.path);
  //     });
  //     // Step 2: Create unique file name
  //     String fileName = basename("${userId}_profilePic");
  //     Reference storageRef = FirebaseStorage.instance.ref().child('profilePic/$fileName');
  //
  //     // Step 3: Upload image
  //     UploadTask uploadTask = storageRef.putFile(_profileImage!);
  //
  //     uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
  //       final progress = snapshot.bytesTransferred / snapshot.totalBytes;
  //       setState(() {
  //         _uploadProgress = progress;
  //       });
  //     }).onError((error) {
  //       print("Upload failed: $error");
  //     });
  //
  //     TaskSnapshot snapshot = await uploadTask;
  //
  //     // Step 4: Get download URL
  //     uploadedImageUrl = await snapshot.ref.getDownloadURL();
  //     await UserDataManager().updateUserField((user) {
  //       user.profilePic = uploadedImageUrl!;
  //     });
  //     try{
  //       await FirebaseFirestore.instance
  //           .collection('users')
  //           .doc(userId).update({
  //         "profilePic" : uploadedImageUrl
  //       });
  //     }catch (e){
  //       print("\n\n\n\Error to store on firestore : $e");
  //     }
  //     setState(() {
  //       profilePicUrl = uploadedImageUrl!;
  //     });
  //
  //
  //   } catch (e) {
  //     print('Error uploading image: $e');
  //   }
  //   statusId = false;
  // }
  Future<void> _pickImage() async {
    pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) {
      return;
    }
    setState(() {
      profilePicUrl = '';
      _profileImage = File(pickedFile!.path);
    });

    if (pickedFile != null) {
      final file = File(pickedFile!.path);
      final ext = path.extension(file.path).toLowerCase(); // .jpg or .png

      int quality = (ext == '.jpg' || ext == '.jpeg') ? 20 : 70;

      final dir = await getTemporaryDirectory();
      final targetPath = path.join(dir.path, "compressed.jpg");

      final compressedFile = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path,
        targetPath,
        quality: quality,
      );
      compresedImage = File(compressedFile!.path);
    }
  }

  Future<bool> _uploadImage() async{

    try{
      _uploadProgress = 0.0;
      String fileName = basename("${userId}_profilePic");
      Reference storageRef = FirebaseStorage.instance.ref().child('profilePic/$fileName');

      // Step 3: Upload image
      UploadTask uploadTask = storageRef.putFile(compresedImage!);

      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        final progress = snapshot.bytesTransferred / snapshot.totalBytes;
        setState(() {
          _uploadProgress = progress;
        });
      }).onError((error) {
        print("Upload failed: $error");
      });

      TaskSnapshot snapshot = await uploadTask;

      // Step 4: Get download URL
      uploadedImageUrl = await snapshot.ref.getDownloadURL();
      await UserDataManager().updateUserField((user) {
        user.profilePic = uploadedImageUrl!;
      });
      setState(() {
        profilePicUrl = uploadedImageUrl!;
      });
      return true;
    }catch(e){
      print(e);
    }
    return false;
  }

  Future<void> _formValidation(BuildContext context) async{
    if(nameController.text.trim().isNotEmpty){
      if(fatherNameController.text.trim().isNotEmpty){
        if(gotraController.text.trim().isNotEmpty){
          if(cityController.text.trim().isNotEmpty){
            if(currentCityController.text.trim().isNotEmpty){
              bool isNumberFieldEmpty = false;
              for(var element in _phoneNumbersController){
                if(element.text.trim().isEmpty){
                  isNumberFieldEmpty = true;
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Number field should not be empty"),
                        backgroundColor: Colors.deepPurpleAccent,
                        duration: Duration(milliseconds: 1500),
                      )
                  );
                  return ;
                }
              }
              if(!isNumberFieldEmpty){
                bool isRelationFieldEmpty = false;
                for(var element in relationships){
                  if(element.keys.first == "Select" || element.values.first == "Select person"){
                    isRelationFieldEmpty = true;
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Relation field should not be empty"),
                          backgroundColor: Colors.deepPurpleAccent,
                          duration: Duration(milliseconds: 1500),
                        )
                    );
                    return ;
                  }
                }
                if(!isRelationFieldEmpty){
                  setState(() {
                    isSaving = true;
                  });

                  await _uploadUserInfoToFirestore();
                  Navigator.pop(context);
                  setState(() {
                    isSaving = false;
                  });
                }
              }
            }else{
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Please enter your current living city"),
                    backgroundColor: Colors.deepPurpleAccent,
                    duration: Duration(milliseconds: 1500),
                  )
              );
            }
          }else {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.deepPurpleAccent,
                  duration: Duration(milliseconds: 1500),
                  content: Text("Please enter your city"),
                )
            );
          }
        }else {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.deepPurpleAccent,
                duration: Duration(milliseconds: 1500),
                content: Text("Please enter your gotra"),
              )
          );
        }
      }else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.deepPurpleAccent,
              duration: Duration(milliseconds: 1500),
              content: Text("Please enter your father name"),
            )
        );
      }
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Please enter your name"),
            backgroundColor: Colors.deepPurpleAccent,
            duration: Duration(milliseconds: 1500),
          )
      );
    }
  }


  Future<void> _uploadUserInfoToFirestore() async {
    var user = UserDataManager().currentUser;
    String name = nameController.text.trim();
    String fatherName = fatherNameController.text.trim();
    String gotra = gotraController.text.trim();
    String city = cityController.text.trim();
    String currentCity = currentCityController.text.trim();
    List<String> numbers = _phoneNumbersController.map((
                           eachNumber) => eachNumber.text).toList();
    List<Map<String, String>> relations = relationships.map((
                            eachRelation) => eachRelation).toList();
    String userid = UserDataManager().currentUser!.userId;
    String subDocId = UserDataManager().currentUser!.subDocId;
    bool isNewImageSet = false;
    name = name[0].toUpperCase()+name.substring(1);
    fatherName = fatherName[0].toUpperCase()+fatherName.substring(1);
    gotra = gotra[0].toUpperCase()+gotra.substring(1);
    city = city[0].toUpperCase()+city.substring(1);
    currentCity = currentCity[0].toUpperCase()+currentCity.substring(1);
    if(pickedFile != null){
      isNewImageSet = await _uploadImage();
    }

    if(subDocId.isEmpty){
      if ((user!.name != name) || (user.fatherName != fatherName) ||
          (user.profilePic != profilePicUrl) || (user.gotra != gotra)
          || isNewImageSet) {
        try {
          await FirebaseFirestore.instance
              .collection('minUsersData')
              .doc("citysList")
              .collection(city)
              .doc("doc1")
              .set({
            userid : {
              "name" : name,
              "fatherName" : fatherName,
              "gotra" : gotra,
              "profilePic" : profilePicUrl
            },
          }, SetOptions(merge: true));
          subDocId = "doc1";
        } catch (e) {

          try {
            await FirebaseFirestore.instance
                .collection('minUsersData')
                .doc("citysList")
                .collection(city)
                .doc("doc2")
                .set({
              userid : {
                "name" : name,
                "fatherName" : fatherName,
                "gotra" : gotra,
                "profilePic" : profilePicUrl
              },
            }, SetOptions(merge: true));
            subDocId = "doc2";
          } catch (e) {
            try {
              await FirebaseFirestore.instance
                  .collection('minUsersData')
                  .doc("citysList")
                  .collection(city)
                  .doc("doc3")
                  .set({
                userid : {
                  "name" : name,
                  "fatherName" : fatherName,
                  "gotra" : gotra,
                  "profilePic" : profilePicUrl
                },
              }, SetOptions(merge: true));
              subDocId = "doc3";
            } catch (e) {
              print(e);
            }
          }
        }
      }
    }else {
      if ((user!.name != name) || (user.fatherName != fatherName) ||
          (user.profilePic != profilePicUrl) || (user.gotra != gotra)
          || isNewImageSet) {
        try {
          await FirebaseFirestore.instance
              .collection('minUsersData')
              .doc("citysList")
              .collection(city)
              .doc(subDocId)
              .set({
            userid : {
              "name" : name,
              "fatherName" : fatherName,
              "gotra" : gotra,
              "profilePic" : user.profilePic
            },
          }, SetOptions(merge: true));
        } catch (e) {
          print(e);
        }
      }
    }

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userid).update({
        "name": name,
        "fatherName": fatherName,
        "gotra": gotra,
        "actualAddress": city,
        "currentAddress": currentCity,
        "relations": relations,
        "numbers": numbers,
        "lastUpdated": FieldValue.serverTimestamp(),
        "profilePic": user.profilePic,
        "subDocId": subDocId
      });


      if (!(citysList.contains(city)) || !(citysList.contains(currentCity))) {
        await FirebaseFirestore.instance
            .collection('minUsersData')
            .doc("citysList")
            .set({
          city: true,
          currentCity: true
        }, SetOptions(merge: true));
      }
    } catch (e) {
      print("Error to store on firestore : $e");
    }

    try {
      final user = UserModel(
          name: name,
          fatherName: fatherName,
          email: emailController.text.trim(),
          gotra: gotra,
          actualAddress: city,
          currentAddress: currentCity,
          phoneNumber: numbers,
          relationships: relationships,
          profilePic: UserDataManager().currentUser!.profilePic,
          userId: UserDataManager().currentUser!.userId,
          subDocId: subDocId
      );

      await UserDataManager().updateUser(user);
    } catch (e) {
      print(e);
    }
  }

  void createNumberController() {
    for(var item in numbers){
      _phoneNumbersController.add(TextEditingController(text: item));
    }
  }

  void _addContactNumber() {
    setState(() {
      _phoneNumbersController.add(TextEditingController());
    });
  }

  void _addRelationMakingTile(String? relationType) {
    setState(() {
      relationships.add({ relationType ?? "Select" : "Select person"});
    });
  }

  void _deleteRelation(int index) {
    setState(() {
      relationships.removeAt(index);
    });
  }

  /// Delete an option at a given index
  void _deleteOption(int index, final TextEditingController t) {
    setState(() {
      _phoneNumbersController.removeAt(index);
      t.dispose();
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    fatherNameController.dispose();
    gotraController.dispose();
    cityController.dispose();
    currentCityController.dispose();
    _searchController.dispose();
    for(var controller in _phoneNumbersController){
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _showItemDialog(
      BuildContext context,
      int indexFromPara,
      List<String> elements,
      String hintText,
      String hintMessage) async {
    List<String> fltdlist = elements;
    String searchQuery = '';
    await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              insetPadding: EdgeInsets.symmetric(horizontal: 20),
              content: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.5,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: hintText,
                        prefixIcon: Icon(Icons.search, color: Color(0xFF23255D)),
                        suffixIcon: _searchController.text.isEmpty
                            ? IconButton(
                          icon: Icon(Icons.info_outline),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                content: Text(
                                  hintMessage,
                                  style: TextStyle(
                                    color: Color(0xFF23255D),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text('OK'),
                                  ),
                                ],
                              ),
                            );
                          },
                        )
                            : IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                            setState(() {
                              searchQuery = '';
                              fltdlist = elements;
                            });
                          },
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          searchQuery = value.trim().toLowerCase();
                          fltdlist = elements
                              .where((item) => item.toLowerCase().contains(searchQuery))
                              .toList();
                        });
                      },
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: fltdlist.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              fltdlist[index],
                              style: TextStyle(
                                color: Color(0xFF23255D),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            onTap: () async{
                              if(hintText == "City..."){
                                relationships[indexFromPara] = {relationships[indexFromPara].keys.first : fltdlist[index]};
                                Navigator.of(context).pop(fltdlist[index]);
                              }else if(hintText == "Relation type"){
                                relationships[indexFromPara] = {fltdlist[index]: relationships[indexFromPara].keys.first};
                                Navigator.of(context).pop(fltdlist[index]);
                              }else if(hintText == "Person..."){
                                relationships[indexFromPara] = {relationships[indexFromPara].keys.first : fltdlist[index]};
                                Navigator.of(context).pop(fltdlist[index]);
                              }
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );

    _searchController.clear();
    return ;
  }


  @override
  Widget build(BuildContext context) {
    return PopScope<Object?>(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        if (!didPop) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        //resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Color(0xFF23255D),
          leading: InkWell(
            onTap: () {
              Navigator.pop(context); // Indicate no changes
            },
            child: Icon(Icons.arrow_back_rounded, size: 30, color: Colors.white),
          ),
          title: Text("Edit Profile", style: TextStyle(color: Colors.white)),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                    child: GestureDetector(
                      onTap: () async{
                        await _pickImage();
                      },
                      child: SizedBox(
                          height: 300,
                          width: 300,
                          child: Stack(
                            children: [

                              ClipRRect(
                                borderRadius: BorderRadius.circular(90),
                                child: CachedNetworkImage(
                                  imageUrl: profilePicUrl,
                                  placeholder: (context, url) => CircleAvatar(
                                    radius: 60,
                                    backgroundImage: _profileImage != null ? FileImage(_profileImage!) : null,
                                    child: _profileImage != null ? null : Icon(Icons.person, size: 60, color: Color(0xFF666AC6)),
                                  ),

                                  errorWidget: (context, url, error) => CircleAvatar(
                                    radius: 60,
                                    backgroundImage: _profileImage != null ? FileImage(_profileImage!) : null,
                                    child: _profileImage != null ? null : Icon(Icons.person, size: 60, color: Color(0xFF666AC6)),
                                  ),
                                  fit: BoxFit.cover,
                                  width: 300,
                                  height: 300,
                                ),
                              ),

                              Align(
                                alignment: Alignment(1, 1),
                                child: Icon(Icons.add_a_photo_rounded, color: Color(0xFF666AC6)),
                              )
                            ],
                          )
                      ),
                    )
                ),
                SizedBox(height: 15,),
                _uploadProgress != 0 ? LinearProgressIndicator(
                  value: _uploadProgress, // between 0 and 1
                  minHeight: 6,
                  backgroundColor: Color(0xFFB3B5EF),
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF666AC6),),
                ) : SizedBox.shrink(),
                SizedBox(height: 20,),
                //Divider(color: Color(0x54002785), thickness: 1, height: 20),
                textBox("Name", Icons.person_rounded, TextInputType.name, nameController, 20, true),
                SizedBox(height: 15,),
                //Divider(color: Color(0x54002785), thickness: 1, height: 20),
                textBox("E-mail", Icons.email_rounded, TextInputType.emailAddress, emailController, 30, false),
                SizedBox(height: 15,),
                //Divider(color: Color(0x54002785), thickness: 1, height: 20),
                textBox("Father name", Icons.account_circle_rounded, TextInputType.text, fatherNameController, 20, true),
                SizedBox(height: 15,),
                //Divider(color: Color(0x54002785), thickness: 1, height: 20),
                textBox("Gotra", Icons.temple_hindu_rounded, TextInputType.text, gotraController, 20, true),
                fltdListGotra.isNotEmpty ?
                ConstrainedBox(
                  constraints: BoxConstraints(
                      maxHeight: 170,
                      minWidth: double.infinity
                  ),
                  child: Card(
                      color: Colors.white,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ...fltdListGotra.asMap().entries.map((element) {
                              int index = element.key;

                              return GestureDetector(
                                onTap: () {
                                  gotraController.text = fltdListGotra[index];
                                  setState(() {
                                    fltdListGotra = [];
                                  });
                                },
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 20),
                                    child: SizedBox(width: double.infinity, child: Text(
                                      fltdListGotra[index],
                                      style: TextStyle(
                                          color: Colors.deepPurpleAccent,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500
                                      ),
                                    ),)
                                ),
                              );
                            }),
                          ],
                        ),
                      )
                  ),
                )
                    :
                Container(),
                SizedBox(height: 15,),
                //Divider(color: Color(0x54002785), thickness: 1, height: 20),
                textBox("Address", Icons.location_city_rounded, TextInputType.text, cityController, 20, UserDataManager().currentUser!.actualAddress.isEmpty),
                fltdCityList.isNotEmpty ?
                ConstrainedBox(
                  constraints: BoxConstraints(
                      maxHeight: 170,
                      minWidth: double.infinity
                  ),
                  child: Card(
                      color: Colors.white,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ...fltdCityList.asMap().entries.map((element) {
                              int index = element.key;

                              return GestureDetector(
                                onTap: () {
                                  cityController.text = fltdCityList[index];
                                  setState(() {
                                    fltdCityList = [];
                                  });
                                },
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 20),
                                    child: SizedBox(width: double.infinity, child: Text(
                                      fltdCityList[index],
                                      style: TextStyle(
                                          color: Colors.deepPurpleAccent,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500
                                      ),
                                    ),)
                                ),
                              );
                            }),
                          ],
                        ),
                      )
                  ),
                )
                    :
                Container(),
                SizedBox(height: 15,),
                textBox("Current living address", Icons.location_history, TextInputType.text, currentCityController, 20, true),
                fltdCurrentCityList.isNotEmpty ?
                ConstrainedBox(
                  constraints: BoxConstraints(
                      maxHeight: 170,
                      minWidth: double.infinity
                  ),
                  child: Card(
                      color: Colors.white,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ...fltdCurrentCityList.asMap().entries.map((element) {
                              int index = element.key;

                              return GestureDetector(
                                onTap: () {
                                  currentCityController.text = fltdCurrentCityList[index];
                                  setState(() {
                                    fltdCurrentCityList = [];
                                  });
                                },
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 20),
                                    child: SizedBox(width: double.infinity, child: Text(
                                      fltdCurrentCityList[index],
                                      style: TextStyle(
                                          color: Colors.deepPurpleAccent,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500
                                      ),
                                    ),)
                                ),
                              );
                            }),
                          ],
                        ),
                      )
                  ),
                )
                    :
                Container(),
                SizedBox(height: 25),
                //phone number
                Card(
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text("Phone Numbers",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Color(0xFF23255D),
                                ),
                              ),
                              Spacer(),
                              IconButton(
                                onPressed: (){
                                  _addContactNumber();
                                },
                                icon: Icon(
                                  Icons.add_rounded,
                                  size: 40,
                                  color: Color(0xB623255D),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 20,),
                          ..._phoneNumbersController.asMap().entries.map((element) {
                            int index = element.key;
                            TextEditingController controller = element.value;
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: Row(
                                children: [

                                  Expanded(
                                    child: textBox("Number${index+1}", Icons.phone, TextInputType.phone, controller, 10, true),
                                  ),


                                  const SizedBox(width: 10),

                                  /// Delete Button
                                  SizedBox(
                                    height: 50,
                                    width: 40,
                                    child: GestureDetector(
                                      onTap: (){
                                        _deleteOption(index, controller);
                                      },
                                      child: Icon(Icons.delete, color: Color(0xFF666AC6),),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ],
                      ),
                    )
                ),
                SizedBox(height: 25),
                //relations
                Card(
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text("Relations",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Color(0xFF23255D),
                                ),
                              ),
                              Spacer(),
                              IconButton(
                                onPressed: (){
                                  _addRelationMakingTile(null);
                                },
                                icon: Icon(
                                  Icons.add_rounded,
                                  size: 40,
                                  color: Color(0xB623255D),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 20,),
                          ...relationships.asMap().entries.map((element) {
                            int index = element.key;
                            final indexMapValues= element.value;

                            Color textColorType = Colors.white;
                            Color textBackColor = Colors.black;

                            if(indexMapValues.keys.first == "Fufa"){
                              textColorType = Color(0xFF4CAF50);
                              textBackColor = Color(0xFFE8F5E9);

                            }else if(indexMapValues.keys.first == "Mama"){
                              textColorType = Color(0xFF304D6C);
                              textBackColor = Color(0x34304D6C);

                            }else if(indexMapValues.keys.first == "Chacha"){
                              textColorType = Color(0xFF2196F3);
                              textBackColor = Color(0xFFE3F2FD);

                            }else if(indexMapValues.keys.first == "Mosa"){
                              textColorType = Color(0xFFFF5722);
                              textBackColor = Color(0xFFFFEBEE);
                            }else if(indexMapValues.keys.first == "Sasur"){
                              textColorType = Color(0xFF3955EF);
                              textBackColor = Color(0x4F6073DC);
                            }else if(indexMapValues.keys.first == "Sadu"){
                              textColorType = Color(0xFFFFFFFF);
                              textBackColor = Color(0xFF507CC1);
                            }else if(indexMapValues.keys.first == "Sala"){
                              textColorType = Color(0xFF6A1B9A);
                              textBackColor = Color(0xFFE1BEE7);
                            }

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () async{
                                      FocusManager.instance.primaryFocus?.unfocus();
                                      await _showItemDialog(context ,index, reltionTypes, "Relation type", "Select which type of relative you want to add.");
                                      setState(() {});
                                    },
                                    child: Container(
                                        width : 90,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: textBackColor,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              bottomLeft: Radius.circular(10)
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            indexMapValues.keys.first,
                                            style: TextStyle(
                                                color: textColorType,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16
                                            ),
                                          ),
                                        )
                                    ),
                                  ),
                                  Expanded(
                                      child: GestureDetector(
                                        onTap: () async{
                                          FocusManager.instance.primaryFocus?.unfocus();
                                          await _showItemDialog(context, index, bhinmal.keys.toList(), "City...", "Select city in which your relative live in.");

                                          await _showItemDialog(context ,index, bhinmal[relationships[index].values.first]!.keys.toList(), "Person...", "Select your relative.");
                                          setState(() {});
                                        },
                                        child: Container(
                                            padding: EdgeInsets.symmetric(horizontal: 5),
                                            height: 50,
                                            decoration: BoxDecoration(
                                              color: Color(0xA9666AC6),
                                              borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(10),
                                                  bottomRight: Radius.circular(10)
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                indexMapValues.values.first,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16
                                                ),
                                              ),
                                            )
                                        ),
                                      )
                                  ),
                                  SizedBox(
                                    height: 50,
                                    width: 40,
                                    child: GestureDetector(
                                      onTap: (){
                                        _deleteRelation(index);
                                      },
                                      child: Icon(Icons.delete, color: Color(0xFF666AC6),),
                                    ),
                                  )
                                ],
                              ),
                            );
                          }),
                        ],
                      ),
                    )
                ),
                SizedBox(height: 50),
                isSaving ? CircularProgressIndicator() :
                ElevatedButton(
                    onPressed: ()async{
                      _formValidation(context);
                    },
                    style: ElevatedButton.styleFrom(
                      textStyle: TextStyle(fontSize: 20,),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      child: Text(
                        "Save",
                      ),
                    )
                ),
                SizedBox(height: 50,)
              ],
            ),
          ),
        ),
      ),
    );
  }



  String citySearchQuery = "";


  Widget textBox(String hint, final prefixIcon, final inputType, TextEditingController controller, int maxLength, bool isTypingEndabled) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: hint,
        labelStyle: const TextStyle(
          fontFamily: 'Plus Jakarta Sans',
          color: Color(0x8B00257E),
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xFFF1F4F8),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xFF4B39EF),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        prefixIcon: Icon(prefixIcon, color: Color(0xff130097), size: 20),
        suffixIcon: isTypingEndabled && (controller == cityController) ||
            controller == currentCityController ||
            controller == gotraController ?
        GestureDetector(onTap: (){
          setState(() {
            if(controller == cityController){
              cityController.clear();
              fltdCityList = [];
            }else if(controller == currentCityController){
              fltdCurrentCityList = [];
              currentCityController.clear();
            }else if(controller == gotraController){
              fltdListGotra = [];
              gotraController.clear();
            }
          });
        }, child: Icon(Icons.close_rounded, color: Colors.deepPurpleAccent,),)
            :
        null,
        filled: true,
        fillColor: const Color(0xFFF1F4F8),
        counterText: '',
      ),
      onChanged: (value) {
        setState(() {
          if(controller == cityController){
            citySearchQuery = value.trim().toLowerCase();
            fltdCityList = citysList
                .where((item) => item.toLowerCase().contains(citySearchQuery))
                .toList();
          }else if(controller == currentCityController){
            citySearchQuery = value.trim().toLowerCase();
            fltdCurrentCityList = citysList
                .where((item) => item.toLowerCase().contains(citySearchQuery))
                .toList();
          }else if(controller == gotraController){
            citySearchQuery = value.trim().toLowerCase();
            fltdListGotra = gotraList
                .where((item) => item.toLowerCase().contains(citySearchQuery))
                .toList();
          }

        });

      },
      maxLength: maxLength,
      readOnly: !isTypingEndabled,
      keyboardType: inputType,
    );
  }

}
