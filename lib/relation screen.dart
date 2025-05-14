import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'helper widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'dart:math';
import 'dart:ui';


class ItemSelectionScreen extends StatefulWidget {
  @override
  _ItemSelectionScreenState createState() => _ItemSelectionScreenState();
}

class _ItemSelectionScreenState extends State<ItemSelectionScreen> {
  String? selectedItem1;
  String? selectedItem2;
  final TextEditingController _searchController = TextEditingController();
  //List<String> fltdlist = [];
  //String searchQuery= '';
  bool postition= false;
  Map<String, Map<String, dynamic>> bhinmal = {
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
      "relations" :{
        "mama" : "Mr Arjun Kumar ji (S-o)  Shri Krishna ji",
        "fufa" : "Mr Ambalal ji (S-o)  Shri Babuji",
        "mosa" : "Mr Ashok Kumar ji (S-o)  Mr Chogji",
        "chacha" : "Mr Ashok ji (S-o)  Mr Poonma ji"
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
      "relations" :{
        "mama" : "Mr Bhura ji (S-o)  Mr Dhukha ji",
        "fufa" : "Mr Kalu ji (S-o)  Mr Moti Ji",
        "mosa" : "Mr Himta ji (S-o)  Mr Pratap ji",
        "chacha" : "Mr Dhanraj ji (S-o)  Mr Sonaji",
        "sasur ji" : "Mr Hemant Kumar (S-o)  Mr Kantilal ji"
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
    "Mr Ashok ji (S-o)  Mr Poonma ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Poonma ji",
      "gotra": "Dabhi",
      "name": "Mr Ashok ji",
      "number": "9828375617",
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
    "Mr Banshilal ji (S-o)  Mr Aydan ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Aydan ji",
      "gotra": "Solanki",
      "name": "Mr Banshilal ji",
      "number": "9413266878",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Mr Banshilal ji (S-o)  Shri Babuji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Shri Babuji",
      "gotra": "Solanki",
      "name": "Mr Banshilal ji",
      "number": "9413246629",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Mr Bhabut ji (S-o)  Mr Masra ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Masra ji",
      "gotra": "Goyal",
      "name": "Mr Bhabut ji",
      "number": "9636948030",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Mr Bhanwar ji (S-o)  Mr Chuna ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Chuna ji",
      "gotra": "Parmar",
      "name": "Mr Bhanwar ji",
      "number": "9982416798",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Mr Bharat ji (S-o)  Mr Kalu ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Kalu ji",
      "gotra": "Dabhi",
      "name": "Mr Bharat ji",
      "number": "9549216839",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Mr Bharatkumar (S-o)  Mr Masraji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Masraji",
      "gotra": "Padiyar",
      "name": "Mr Bharatkumar",
      "number": "9375966579",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Mr Bhura ji (S-o)  Mr Dhukha ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Dhukha ji",
      "gotra": "Makwana",
      "name": "Mr Bhura ji",
      "number": "8769528112",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Mr Champa ji (S-o)  Shri Shivraj ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Shri Shivraj ji",
      "gotra": "Parmar",
      "name": "Mr Champa ji",
      "number": "9587577906",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Mr Champalal ji (S-o)  Mr Sura Ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Sura Ji",
      "gotra": "Makwana",
      "name": "Mr Champalal ji",
      "number": "9929641909",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Mr Chandu ji (S-o)  Mr Gheva ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Gheva ji",
      "gotra": "Parmar",
      "name": "Mr Chandu ji",
      "number": "7568431912",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Mr Chogha ji (S-o)  Mr Bharata ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Bharata ji",
      "gotra": "Dahiya",
      "name": "Mr Chogha ji",
      "number": "9680446599",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Mr Chunna ji (S-o)  Shri Moti ji ": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Shri Moti ji ",
      "gotra": "Parmar",
      "name": "Mr Chunna ji",
      "number": "9982527453",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Mr Dasharathkumar ji (S-o)  Mr Ghevar ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Ghevar ji",
      "gotra": "Solanki",
      "name": "Mr Dasharathkumar ji",
      "number": "9660771603",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Mr Deepaji (S-o)  Shri Manrupji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Shri Manrupji",
      "gotra": "Padhiyaar",
      "name": "Mr Deepaji",
      "number": "9413266792",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Mr Deepak Kumar ji (S-o)  Mr Suresh Ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Suresh Ji",
      "gotra": "Solanki",
      "name": "Mr Deepak Kumar ji",
      "number": "9624236164",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Mr Deepak ji (S-o)  Mr Parsa ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Parsa ji",
      "gotra": "Padhiyaar",
      "name": "Mr Deepak ji",
      "number": "8511615749",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Mr Dhanraj ji (S-o)  Mr Sonaji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Sonaji",
      "gotra": "Solanki",
      "name": "Mr Dhanraj ji",
      "number": "9549744952",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": "",
      "relations" :{
        "mama" : "Mr Arjun Kumar ji (S-o)  Shri Krishna ji",
        "fufa" : "Mr Dheeraj Ji (S-o)  Mr Reva ji",
        "mosa" : "Mr Dinesh ji (S-o)  Mr Chogha ji",
        "chacha" : "Mr Dinesh ji (S-o)  Mr Sura Ji"
      }

    },
    "Mr Dheeraj Ji (S-o)  Mr Reva ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Reva ji",
      "gotra": "Dabhi",
      "name": "Mr Dheeraj Ji",
      "number": "9079319340",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": "",
      "relations" :{
        "mama" : "Mr Harsan ji (S-o)  Mr Sujana ji",
        "fufa" : "Mr Kalu ji (S-o)  Mr Moti Ji",
        "mosa" : "Mr Hemant Kumar (S-o)  Mr Kantilal ji",
        "chacha" : "Mr Himta ji (S-o)  Mr Pratap ji"
      }
    },
    "Mr Dinesh ji (S-o)  Mr Chogha ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Chogha ji",
      "gotra": "Dahiya",
      "name": "Mr Dinesh ji",
      "number": "9983731550",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Mr Dinesh ji (S-o)  Mr Pratap ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Pratap ji",
      "gotra": "makwana",
      "name": "Mr Dinesh ji",
      "number": "9680396400",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Mr Dinesh ji (S-o)  Mr Ramesh ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Ramesh ji",
      "gotra": "Solanki",
      "name": "Mr Dinesh ji",
      "number": "7701017244",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Mr Dinesh ji (S-o)  Mr Sura Ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Sura Ji",
      "gotra": "Makwana",
      "name": "Mr Dinesh ji",
      "number": "9983762781",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Mr Dinesh ji (S-o)  Shri Trikma Ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Shri Trikma Ji",
      "gotra": "Parmar",
      "name": "Mr Dinesh ji",
      "number": "9672691001",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Mr Dungra ji (S-o)  Mr Bhura ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Bhura ji",
      "gotra": "Bhati",
      "name": "Mr Dungra ji",
      "number": "9414588785",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Mr Gautam ji (S-o)  Mr Vansha ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Vansha ji",
      "gotra": "Dabhi",
      "name": "Mr Gautam ji",
      "number": "9672548604",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Mr Ghevar ji (S-o)  Shri Shivraj ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Shri Shivraj ji",
      "gotra": "Dabhi",
      "name": "Mr Ghevar ji",
      "number": "9983655767",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Mr Gumanmal ji (S-o)  Shri Trikma Ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Shri Trikma Ji",
      "gotra": "Parmar",
      "name": "Mr Gumanmal ji",
      "number": "9950711141",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Mr Hadmat ji (S-o)  Mr Chamna ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Chamna ji",
      "gotra": "makwana",
      "name": "Mr Hadmat ji",
      "number": "9413138512",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Mr Harish Kumar (S-o)  Shri Pukhrajji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Shri Pukhrajji",
      "gotra": "Solanki",
      "name": "Mr Harish Kumar",
      "number": "9694127455",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Mr Hariya ji (S-o)  Shri Shankar ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Shri Shankar ji",
      "gotra": "Dahiya",
      "name": "Mr Hariya ji",
      "number": "8003922202",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Mr Harsan ji (S-o)  Mr Sujana ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Sujana ji",
      "gotra": "Padhiyaar",
      "name": "Mr Harsan ji",
      "number": "9785938813",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Mr Heera Ji (S-o)  Mr Kesa ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Kesa ji",
      "gotra": "Parmar",
      "name": "Mr Heera Ji",
      "number": "9983547604",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Mr Hemant Kumar (S-o)  Mr Kantilal ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Kantilal ji",
      "gotra": "makwana",
      "name": "Mr Hemant Kumar",
      "number": "9725908540",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": "",
      "relations" :{
        "mama" : "Mr Jeetaji (S-o)  Shri Manrupji",
        "fufa" : "Mr Jitendra Kumar (S-o)  Shri Roopchand ji",
        "mosa" : "Mr Kalpesh Kumar (S-o)  Mr Masra ji",
        "chacha" : "Mr Kalu ji (S-o)  Mr Moti Ji",
        "sasur ji" : "Mr Ambalal ji (S-o)  Shri Babuji"
      }
    },
    "Mr Himta ji (S-o)  Mr Pratap ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Pratap ji",
      "gotra": "Parmar",
      "name": "Mr Himta ji",
      "number": "9772752527",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Mr Hitesh Kumar (S-o)  Mr Chogji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Chogji",
      "gotra": "Dahiya",
      "name": "Mr Hitesh Kumar",
      "number": "9928537507",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Mr Hitesh Kumar (S-o)  Mr Kishore ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Kishore ji",
      "gotra": "Parmar",
      "name": "Mr Hitesh Kumar",
      "number": "9587750098",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Mr Hitesh Kumar ji (S-o)  Shri Varda ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Shri Varda ji",
      "gotra": "Makwana",
      "name": "Mr Hitesh Kumar ji",
      "number": "7732963876",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Mr Hiteshkumar ji (S-o)  Mr Shantilal ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Shantilal ji",
      "gotra": "Solanki",
      "name": "Mr Hiteshkumar ji",
      "number": "8140377146",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Mr Jagdish ji (S-o)  Mr Sardarji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Sardarji",
      "gotra": "Solanki",
      "name": "Mr Jagdish ji",
      "number": "7285819510",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Mr Jamta ji (S-o)  Mr Khimji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Khimji",
      "gotra": "Padhiyaar",
      "name": "Mr Jamta ji",
      "number": "9828437132",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Mr Jeeta Ji (S-o)  Shri Shivraj ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Shri Shivraj ji",
      "gotra": "Parmar",
      "name": "Mr Jeeta Ji",
      "number": "9649862270",
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
      "relations" :{
        "sasur ji" : "Mr Chandu ji (S-o)  Mr Gheva ji"
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
    "Mr Mangilal Ji (S-o)  Shri Ganesha Ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Shri Ganesha Ji",
      "gotra": "Dabhi",
      "name": "Mr Mangilal Ji",
      "number": "9928424589",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Mr Masra ji (S-o)  Shri Bhima Ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Shri Bhima Ji",
      "gotra": "Solanki",
      "name": "Mr Masra ji",
      "number": "9983354039",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Mr Masra ji (S-o)  Shri Manrupji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Shri Manrupji",
      "gotra": "Padhiyaar",
      "name": "Mr Masra ji",
      "number": "7568095226",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Mr Masra ji (S-o)  Shri Trikma Ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Shri Trikma Ji",
      "gotra": "Solanki",
      "name": "Mr Masra ji",
      "number": "7665850220",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Mr Mowan ji (S-o)  Mr Chogha ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Chogha ji",
      "gotra": "Parmar",
      "name": "Mr Mowan ji",
      "number": "9413121136",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Mr Mowan ji (S-o)  Mr Ranchhod ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Ranchhod ji",
      "gotra": "Parmar",
      "name": "Mr Mowan ji",
      "number": "9530486270",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Mr Mukesh ji (S-o)  Mr Chogha ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Chogha ji",
      "gotra": "Dahiya",
      "name": "Mr Mukesh ji",
      "number": "9829997258",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Mr Mukesh ji (S-o)  Mr Parsa ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Parsa ji",
      "gotra": "Padhiyaar",
      "name": "Mr Mukesh ji",
      "number": "8094588953",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Mr Mukesh ji (S-o)  Mr Raju ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Raju ji",
      "gotra": "Solanki",
      "name": "Mr Mukesh ji",
      "number": "9772955564",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Mr Nanji (S-o)  Mr Bhura ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Bhura ji",
      "gotra": "Solanki",
      "name": "Mr Nanji",
      "number": "9929076929",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Mr Naresh Kumar ji (S-o)  Mr Masra ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Masra ji",
      "gotra": "Solanki",
      "name": "Mr Naresh Kumar ji",
      "number": "9694321587",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Mr Naresh ji (S-o)  Mr Veena ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Veena ji",
      "gotra": "Dahiya",
      "name": "Mr Naresh ji",
      "number": "9662383464",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Mr Nareshkumar ji (S-o)  Shri Poonmaji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Shri Poonmaji",
      "gotra": "Solanki",
      "name": "Mr Nareshkumar ji",
      "number": "8107925767",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Mr Narpatkumar (S-o)  Mr Romji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Romji",
      "gotra": "Parmar",
      "name": "Mr Narpatkumar",
      "number": "9783653289",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Mr Niteshkumar (S-o)  Shri Uttamchandji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Shri Uttamchandji",
      "gotra": "Solanki",
      "name": "Mr Niteshkumar",
      "number": "7742680208",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Mr Nitin Kumar ji (S-o)  Mr Ratan ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Ratan ji",
      "gotra": "Padhiyaar",
      "name": "Mr Nitin Kumar ji",
      "number": "8239787574",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Mr Parsa ji (S-o)  Mr Sonaji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Sonaji",
      "gotra": "Padhiyaar",
      "name": "Mr Parsa ji",
      "number": "9413819807",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Mr Peeraram (S-o)  Mr Romji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Romji",
      "gotra": "Parmar",
      "name": "Mr Peeraram",
      "number": "9468833646",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Mr Prakash ji (S-o)  Mr Gima Ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Gima Ji",
      "gotra": "makwana",
      "name": "Mr Prakash ji",
      "number": "9672752360",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Mr Prakash ji (S-o)  Shri Shivraj ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Shri Shivraj ji",
      "gotra": "Parmar",
      "name": "Mr Prakash ji",
      "number": "9982658128",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Mr Praveen Kumar ji (S-o)  Mr Shantilal ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Shantilal ji",
      "gotra": "Solanki",
      "name": "Mr Praveen Kumar ji",
      "number": "7357338324",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Mr Praveen ji (S-o)  Mr Sawla ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Sawla ji",
      "gotra": "Dahiya",
      "name": "Mr Praveen ji",
      "number": "7597326720",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Mr Prema ji (S-o)  Mr Masra ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Masra ji",
      "gotra": "Goyal",
      "name": "Mr Prema ji",
      "number": "9602963612",
      "number 2": "7339874181",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Mr Raju Kumar ji (S-o)  Mr Ramesh ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Ramesh ji",
      "gotra": "Solanki",
      "name": "Mr Raju Kumar ji",
      "number": "7568578518",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Mr Raju ji (S-o)  Mr Aydan ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Aydan ji",
      "gotra": "Solanki",
      "name": "Mr Raju ji",
      "number": "9413819952",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Mr Rajuji (S-o)  Shri Kantilal ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Shri Kantilal ji",
      "gotra": "Dabhi",
      "name": "Mr Rajuji",
      "number": "7568096669",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Mr Rakesh Kumar ji (S-o)  Mr Manchha ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Manchha ji",
      "gotra": "Solanki",
      "name": "Mr Rakesh Kumar ji",
      "number": "9820396864",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Mr Ramesh ji (S-o)  Mr Babu Ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Babu Ji",
      "gotra": "Dahiya",
      "name": "Mr Ramesh ji",
      "number": "8769708913",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Mr Ramesh ji (S-o)  Mr Sona ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Sona ji",
      "gotra": "Dabhi",
      "name": "Mr Ramesh ji",
      "number": "7710078344",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Mr Ramesh ji (S-o)  Mr Tikma Ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Tikma Ji",
      "gotra": "Solanki",
      "name": "Mr Ramesh ji",
      "number": "9998877411",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Mr Ramesh ji (S-o)  Mr Vansha ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Vansha ji",
      "gotra": "Dabhi",
      "name": "Mr Ramesh ji",
      "number": "9772990098",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Mr Reva ji (S-o)  Mr Nanji Ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Nanji Ji",
      "gotra": "Dabhi",
      "name": "Mr Reva ji",
      "number": "9460624258",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Mr Reva ji (S-o)  Mr Sura Ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Sura Ji",
      "gotra": "Makwana",
      "name": "Mr Reva ji",
      "number": "9414843283",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Mr Reva ji (S-o)  Shri Shankar ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Shri Shankar ji",
      "gotra": "Bhati",
      "name": "Mr Reva ji",
      "number": "9694433343",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Mr Sanjay Kumar (S-o)  Shri Krishna ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Shri Krishna ji",
      "gotra": "Makwana",
      "name": "Mr Sanjay Kumar",
      "number": "7568006975",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Mr Sawla ji (S-o)  Mr Narna ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Narna ji",
      "gotra": "Goyal",
      "name": "Mr Sawla ji",
      "number": "9982711572",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Mr Shantilal (S-o)  Shri Malaji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Shri Malaji",
      "gotra": "Solanki",
      "name": "Mr Shantilal",
      "number": "7865449095",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Mr Shantilal ji (S-o)  Shri Mala Ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Shri Mala Ji",
      "gotra": "Solanki",
      "name": "Mr Shantilal ji",
      "number": "7665449095",
      "number 2": "9829864262",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Mr Shravan ji (S-o)  Mr Romji ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Romji ji",
      "gotra": "Parmar",
      "name": "Mr Shravan ji",
      "number": "9887776599",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Mr Shravan ji (S-o)  Shri Pratapji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Shri Pratapji",
      "gotra": "Parmar",
      "name": "Mr Shravan ji",
      "number": "8058454852",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Mr Suresh Kumar ji (S-o)  Mr Masra ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Masra ji",
      "gotra": "Solanki",
      "name": "Mr Suresh Kumar ji",
      "number": "9586656468",
      "number 2": "9783570088",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Mr Suresh ji (S-o)  Mr Babu Ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Babu Ji",
      "gotra": "Dahiya",
      "name": "Mr Suresh ji",
      "number": "9166092990",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Mr Suresh ji (S-o)  Mr Banshilal ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Banshilal ji",
      "gotra": "Solanki",
      "name": "Mr Suresh ji",
      "number": "7588155143",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Mr Suresh ji (S-o)  Mr Gena ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Gena ji",
      "gotra": "Parmar",
      "name": "Mr Suresh ji",
      "number": "9983617491",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Mr Suresh ji (S-o)  Mr Mohan ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Mohan ji",
      "gotra": "Parmar",
      "name": "Mr Suresh ji",
      "number": "9983617491",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Mr Suresh ji (S-o)  Mr Parsa ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Parsa ji",
      "gotra": "Padhiyaar",
      "name": "Mr Suresh ji",
      "number": "7502840254",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Mr Thanmal ji (S-o)  Shri Trikma Ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Shri Trikma Ji",
      "gotra": "Solanki",
      "name": "Mr Thanmal ji",
      "number": "9650082626",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Mr Uttam ji (S-o)  Mr Hanja ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Hanja ji",
      "gotra": "Bhati",
      "name": "Mr Uttam ji",
      "number": "9950508961",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Mr Vena ji (S-o)  Mr Gima Ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Gima Ji",
      "gotra": "Dahiya",
      "name": "Mr Vena ji",
      "number": "9660374347",
      "number 2": "9460437027",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Mr Vikas Kumar (S-o)  Shri Uttamchandji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Shri Uttamchandji",
      "gotra": "Solanki",
      "name": "Mr Vikas Kumar",
      "number": "7733855274",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Mr Vikesh Kumar (S-o)  Mr Sardarji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Sardarji",
      "gotra": "Solanki",
      "name": "Mr Vikesh Kumar",
      "number": "9925134707",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Mr Vikram Kumar ji (S-o)  Mr Dhanraj ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Dhanraj ji",
      "gotra": "Solanki",
      "name": "Mr Vikram Kumar ji",
      "number": "9694765353",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Mr Vikram ji (S-o)  Shri Madhaji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Shri Madhaji",
      "gotra": "Solanki",
      "name": "Mr Vikram ji",
      "number": "9784574367",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Mr Vimal Kumar ji (S-o)  Mr Roopchandji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Roopchandji",
      "gotra": "Parmar",
      "name": "Mr Vimal Kumar ji",
      "number": "9166765616",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Mr hira ji (S-o)  Mr Geenga ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Geenga ji",
      "gotra": "Parmar",
      "name": "Mr hira ji",
      "number": "8094983833",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Shri Arjun ji (S-o)  Mr Souja ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Souja ji",
      "gotra": "Dahiya",
      "name": "Shri Arjun ji",
      "number": "9166224104",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Shri Balwant Ji (S-o)  Mr Gheva ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Gheva ji",
      "gotra": "Solanki",
      "name": "Shri Balwant Ji",
      "number": "9413818305",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Shri Bhaira ji (S-o)  Mr Dhukha ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Dhukha ji",
      "gotra": "Makwana",
      "name": "Shri Bhaira ji",
      "number": "9925198782",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Shri Bhavaram ji (S-o)  Shri Modaramji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Shri Modaramji",
      "gotra": "Dabhi",
      "name": "Shri Bhavaram ji",
      "number": "9772354914",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Shri Chatra Ramji (S-o)  Mr Chogha ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Chogha ji",
      "gotra": "Parmar",
      "name": "Shri Chatra Ramji",
      "number": "9413600697",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Shri Dashrath ji (S-o)  Mr Dhanraj ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Dhanraj ji",
      "gotra": "Solanki",
      "name": "Shri Dashrath ji",
      "number": "9982566609",
      "number 2": "8769968278",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Shri Dev Ji (S-o)  Mr Kesa ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Kesa ji",
      "gotra": "Parmar",
      "name": "Shri Dev Ji",
      "number": "9799221268",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Shri Ghevaram ji (S-o)  Mr Chogha ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Chogha ji",
      "gotra": "Parmar",
      "name": "Shri Ghevaram ji",
      "number": "9413484236",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Shri Ghevarchandji (S-o)  Shri Malaji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Shri Malaji",
      "gotra": "Solanki",
      "name": "Shri Ghevarchandji",
      "number": "9413464921",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Shri Govind ji (S-o)  Mr Chuna ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Chuna ji",
      "gotra": "Parmar",
      "name": "Shri Govind ji",
      "number": "9413821153",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Shri Hanjaram ji (S-o)  Shri Sanwalaram ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Shri Sanwalaram ji",
      "gotra": "makwana",
      "name": "Shri Hanjaram ji",
      "number": "9461452851",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Shri Jabra Ram Ji (S-o)  Mr Gima Ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Gima Ji",
      "gotra": "makwana",
      "name": "Shri Jabra Ram Ji",
      "number": "9983762783",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Shri Jagdishji (S-o)  Mr Roop ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Roop ji",
      "gotra": "Parmar",
      "name": "Shri Jagdishji",
      "number": "9649400447",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Shri Jitendra ji (S-o)  Mr Veena ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Veena ji",
      "gotra": "Dahiya",
      "name": "Shri Jitendra ji",
      "number": "9482435139",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Shri Kaluramji (S-o)  Shri Modaramji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Shri Modaramji",
      "gotra": "Dabhi",
      "name": "Shri Kaluramji",
      "number": "9772354918",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Shri Khetaram ji (S-o)  Mr Masra ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Masra ji",
      "gotra": "Makwana",
      "name": "Shri Khetaram ji",
      "number": "9602451770",
      "number 2": "7737147015",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Shri Kiran Kumar ji (S-o)  Mr Gumanmal ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Gumanmal ji",
      "gotra": "Parmar",
      "name": "Shri Kiran Kumar ji",
      "number": "9983132908",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Shri Krishna Ji (S-o)  Mr Reva ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Reva ji",
      "gotra": "Dabhi",
      "name": "Shri Krishna Ji",
      "number": "9079686164",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Shri Krishna ji (S-o)  Mr Haqma ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Haqma ji",
      "gotra": "Makwana",
      "name": "Shri Krishna ji",
      "number": "9460624249",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Shri Krishna ji (S-o)  Mr Romji ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Romji ji",
      "gotra": "Parmar",
      "name": "Shri Krishna ji",
      "number": "9983929695",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Shri Krishna ji (S-o)  Mr Sona ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Sona ji",
      "gotra": "Dabhi",
      "name": "Shri Krishna ji",
      "number": "9825980945",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Shri Lakharamji (S-o)  Mr Vela ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Vela ji",
      "gotra": "Dahiya",
      "name": "Shri Lakharamji",
      "number": "9982567997",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Shri Mula Ji (S-o)  Mr Poonma ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Poonma ji",
      "gotra": "Parmar",
      "name": "Shri Mula Ji",
      "number": "7742420669",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Shri Narayan Kumar ji (S-o)  Mr Manchha ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Manchha ji",
      "gotra": "Solanki",
      "name": "Shri Narayan Kumar ji",
      "number": "9001940068",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Shri Poonmaji (S-o)  Shri Malaji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Shri Malaji",
      "gotra": "Solanki",
      "name": "Shri Poonmaji",
      "number": "9413747006",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Shri Pukhraj ji (S-o)  Mr Aydan ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Aydan ji",
      "gotra": "Solanki",
      "name": "Shri Pukhraj ji",
      "number": "9413819186",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Shri Ranjit Ji (S-o)  Mr Veena ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Veena ji",
      "gotra": "Dahiya",
      "name": "Shri Ranjit Ji",
      "number": "8758918855",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Shri Roopchand ji (S-o)  Mr Babra ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Babra ji",
      "gotra": "Parmar",
      "name": "Shri Roopchand ji",
      "number": "9983933193",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Shri Rupa ji (S-o)  Shri Bhima Ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Shri Bhima Ji",
      "gotra": "Solanki",
      "name": "Shri Rupa ji",
      "number": "9461630646",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Shri Shankar ji (S-o)  Mr Dhukha ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Dhukha ji",
      "gotra": "Bhati",
      "name": "Shri Shankar ji",
      "number": "7728976620",
      "number 2": "9799673714",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Shri Suresh Kumar ji (S-o)  Mr Masra ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Masra ji",
      "gotra": "Solanki",
      "name": "Shri Suresh Kumar ji",
      "number": "9558968822",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Shri Uttamchandji (S-o)  Shri Malaji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Shri Malaji",
      "gotra": "Solanki",
      "name": "Shri Uttamchandji",
      "number": "9413656835",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Shri Varda ji (S-o)  Mr Dhukha ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Dhukha ji",
      "gotra": "Makwana",
      "name": "Shri Varda ji",
      "number": "9460961392",
      "number 2": "9468096192",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Shri Vikram Ji (S-o)  Mr Reva ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Reva ji",
      "gotra": "Dabhi",
      "name": "Shri Vikram Ji",
      "number": "7742032003",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Sri Arvind Ji (S-o)  Mr Kala Ji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Mr Kala Ji",
      "gotra": "Dabhi",
      "name": "Sri Arvind Ji",
      "number": "7690802737",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    },
    "Sri Ravikumar (S-o)  Shri Hariramji": {
      "address": "Bhinmal",
      "current living address": "",
      "father name": "Shri Hariramji",
      "gotra": "Dahiya",
      "name": "Sri Ravikumar",
      "number": "8963843710",
      "number 2": "",
      "number 3": "",
      "pin code": "",
      "work": ""
    }
  };
  int outputType = 0;

  File? _imageFile;
  String? _downloadUrl;
  bool _isUploading = false;
  double _uploadProgress = 0.0;

  Future<void> pickAndUploadImage() async {
    final picker = ImagePicker();

    // 1️⃣ Pick image from gallery
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No image selected')),
      );
      return;
    }

    setState(() {
      _imageFile = File(pickedFile.path);
      _isUploading = true;
      _uploadProgress = 0.0;
    });

    try {
      // 2️⃣ Create Firebase Storage reference
      final fileName = DateTime.now().toString();
      final ref = FirebaseStorage.instance.ref().child('uploads/$fileName.jpg');

      // 3️⃣ Upload file
      UploadTask uploadTask = ref.putFile(_imageFile!);

      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        final progress = snapshot.bytesTransferred / snapshot.totalBytes;
        setState(() {
          _uploadProgress = progress;
        });
      });

      TaskSnapshot snapshot = await uploadTask;
      // 4️⃣ Get download URL
      String url = await snapshot.ref.getDownloadURL();

      await FirebaseFirestore.instance.collection('users').doc('hardik').set(
          {
            'profilePicture': url,
            'name' : 'Hardik kumar'
          }
      );

      setState(() {
        _downloadUrl = url;
        _isUploading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Image uploaded successfully')),
      );
    } catch (e) {
      setState(() {
        _isUploading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Upload failed: $e')),
      );
    }
  }


  List<String> findRelationBetween(
      Map<String, dynamic> data,
      String person1,
      String person2,
      {int maxDepth = 7} // you can change this to 5, 6, 7 etc.
      ) {
    if (!data.containsKey(person1) || !data.containsKey(person2)) {
      setState(() {
        _isUploading = false;
      });
      return ["One or both persons not found."];
    }

    List<String> results = [];
    Set<String> visited = {person1};

    void dfs(String current, List<String> path, int depth) {

      if (depth > maxDepth) return;

      Map<String, dynamic>? relations = data[current]?['relations'];

      if (relations == null) return;

      for (var entry in relations.entries) {

        String relation = entry.key;
        String nextPerson = entry.value;

        if (visited.contains(nextPerson)) continue;
        visited.add(nextPerson);

        List<String> newPath = [
          "$nextPerson ${relation} हे $current के",
          ...path
        ];


        if (nextPerson == person2) {
          results.add(newPath.join('\n'));
        } else {
          dfs(nextPerson, newPath, depth + 1);
        }

        visited.remove(nextPerson); // backtrack
      }
    }

    dfs(person1, [], 1);
    setState(() {
      _isUploading = false;
      reltions = results.isNotEmpty
          ? [reltions[0], ...results]
          : [reltions[0], ...["No relation found within $maxDepth levels between $person1 and $person2."]];

    });
    return results.isNotEmpty
        ? results
        : ["No relation found within $maxDepth levels between $person1 and $person2."];
  }


  List<String> reltions = ["initWidget"];



  @override
  void initState() {
    super.initState();
  }
  void _showItemDialog() async {
    List<String> fltdlist = bhinmal.keys.toList();
    String searchQuery= '';
    final result = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              insetPadding: EdgeInsets.symmetric(horizontal: 20),
              //title: Text('Select an item'),
              content: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.5,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'City...',
                        hintStyle: TextStyle(
                          color: Color(0xFF23255D),
                        ),
                        prefixIcon: Icon(Icons.search, color: Color(0xFF23255D),),
                        suffixIcon: _searchController.text.isEmpty
                            ? IconButton(
                          icon: Icon(Icons.info_outline),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                //title: Text('Select City & Village'),
                                content: Text(
                                  'Frist select city in which person lives',
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
                              fltdlist = bhinmal.keys.toList();
                            });
                          },
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          searchQuery = value.trim().toLowerCase();
                          fltdlist = bhinmal.keys.toList()
                              .where((item) =>
                              item.toLowerCase().contains(searchQuery))
                              .toList();
                        });
                      },
                    ),
                    Expanded(
                      child: ListView.builder(
                        cacheExtent: 1000,
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
                            onTap: () {
                              if(selectedItem1 == null && selectedItem2 == null){
                                Navigator.of(context).pop(fltdlist[index]);
                              }else if(selectedItem1 != fltdlist[index] && selectedItem2 != fltdlist[index]
                                  || postition == true && selectedItem1 == fltdlist[index]
                                  || postition == false && selectedItem2 == fltdlist[index]){
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

    if (result != null) {
      if(postition){
        setState(() {
          reltions.clear();
          reltions = ["initWidget"];
          selectedItem1 = result;
        });
      }else {
        setState(() {
          reltions.clear();
          reltions = ["initWidget"];
          selectedItem2 = result;
        });
      }
    }
    _searchController.clear();
  }

  List<String> splitAndKeep(String input, List<String> delimiters) {
    final pattern = RegExp('(${delimiters.join('|')})');
    final matches = pattern.allMatches(input);

    List<String> result = [];
    int lastEnd = 0;

    for (final match in matches) {
      if (match.start > lastEnd) {
        result.add(input.substring(lastEnd, match.start).trim());
      }
      result.add(match.group(0)!); // the delimiter itself
      lastEnd = match.end;
    }

    // Add remaining part after last match
    if (lastEnd < input.length) {
      result.add(input.substring(lastEnd).trim());
    }
    result = result.where((element) => element.trim().isNotEmpty).toList();
    graph.clear();
    indexWiseTextLength.clear();

    for(int index = 0; index < result.length ; index++){
      if((!result[index].contains("हे"))
          &&(!result[index].contains("के"))
          &&(index < result.length-2)
          &&(!result[index].contains(result[index+2]))
          ||(index==result.length-2)
      ){
        graph.add(result[index]);
      }
    }

    // Example


    for (int i = 0; i < graph.length; i++) {
      if (i == 0) {
        indexWiseTextLength.add(graph[i].length);
      } else {

        int sum = indexWiseTextLength[i-1] + graph[i].length;

        indexWiseTextLength.add(sum);
      }
    }
    return result;
  }

  void graphObjectsList(int triger) {

    List<String> delimiters = [selectedItem1!, selectedItem2!, 'fufa', 'हे', 'के', 'chacha','mama', 'mosa', 'sasur ji'];
    String input = reltions[triger];
    final pattern = RegExp('(${delimiters.join('|')})');
    final matches = pattern.allMatches(input);

    List<String> result = [];
    int lastEnd = 0;

    for (final match in matches) {
      if (match.start > lastEnd) {
        result.add(input.substring(lastEnd, match.start).trim());
      }
      result.add(match.group(0)!); // the delimiter itself
      lastEnd = match.end;
    }

    // Add remaining part after last match
    if (lastEnd < input.length) {
      result.add(input.substring(lastEnd).trim());
    }
    result = result.where((element) => element.trim().isNotEmpty).toList();
    // graph.clear();
    // indexWiseTextLength.clear();

    for(int index = 0; index < result.length ; index++){
      if((!result[index].contains("हे"))
          &&(!result[index].contains("के"))
          &&(index < result.length-2)
          &&(!result[index].contains(result[index+2]))
          ||(index==result.length-2)
      ){
        graph.add(result[index]);
      }
    }

    // Example


    for (int i = 0; i < graph.length; i++) {
      if (i == 0) {
        indexWiseTextLength.add(graph[i].length);
      } else {

        int sum = indexWiseTextLength[i-1] + graph[i].length;

        indexWiseTextLength.add(sum);
      }
    }


    graph.add('End');
    if(triger < reltions.length-1){
      graphObjectsList(triger+1);
    }else {
      return ;
    }

  }

  Color getRandomColor() {
    Random random = Random();
    return Color.fromARGB(
      255, // Fully opaque
      random.nextInt(256), // Red (0-255)
      random.nextInt(256), // Green
      random.nextInt(256), // Blue
    );
  }

  List<String> graph = [];
  List<int> indexWiseTextLength = [];


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: reltions.length,
      cacheExtent: 10000,
      itemBuilder: (context, index){

        if(index == 0){
          return Column(
            children: [
              SizedBox(height: 15,),
              SizedBox(
                width: MediaQuery.of(context).size.width*0.85,
                child: RichText(
                  text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Platform where you can ',
                            style: GoogleFonts.poppins(
                                color: Color(0x4cf34578),
                                fontWeight: FontWeight.bold,
                                fontSize: 40,
                                height: 1
                            )
                        ),
                        TextSpan(
                            text: "find relation ",
                            style: GoogleFonts.poppins(
                                color: Color(0x42006bff),
                                fontWeight: FontWeight.w600,
                                fontSize: 35,
                                height: 1.2
                            )
                        ),
                        TextSpan(
                            text: "with your known ",
                            style: GoogleFonts.poppins(
                                color: Color(0x44c30af8),
                                fontWeight: FontWeight.w500,
                                fontSize: 30,
                                height: 1.4
                            )
                        ),
                        TextSpan(
                            text: "one",
                            style: GoogleFonts.poppins(
                                color: Color(0x4aff2b2a),
                                fontWeight: FontWeight.w400,
                                fontSize: 25,
                                height: 1.6
                            )
                        )
                      ]
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.85,
                child: Card(
                  color: Color(0xfff6dcff),
                  shadowColor: Color(0xffe06eff),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)
                  ),

                  child: Column(
                    children: [
                      selectedItem1 == null ? SizedBox() : Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                          selectedItem1?? "",
                          style: GoogleFonts.poppins(
                              color: Colors.purple,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            postition=true;
                            _showItemDialog();
                          },
                          child: Row(
                            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.person_rounded),
                              Expanded(
                                child: Center(
                                  child: Text("Select Person 1"),
                                ),
                              ),
                              IconButton(
                                onPressed: (){

                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      //title: Text('Select City & Village'),
                                      content: Text(
                                        "Please select person 1 whose relation you want to find" ,                            style: TextStyle(
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
                                icon: Icon(Icons.info_rounded),
                              )
                            ],
                          )
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 55,
                child: Icon(
                  Icons.people_outline_rounded,
                  color: Color(0x4F080077),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.85,
                child: Card(
                  color: Color(0xffdcdeff),
                  shadowColor: Color(0xffe06eff),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)
                  ),
                  child: Column(
                    children: [
                      selectedItem2 == null ? Container() : Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                          selectedItem2?? "",
                          style: GoogleFonts.poppins(
                              color: Colors.deepPurpleAccent,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            postition = false;
                            _showItemDialog();
                          },
                          child: Row(
                            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.person_rounded),
                              Expanded(
                                child: Center(
                                  child: Text("Select Person 2"),
                                ),
                              ),
                              IconButton(
                                onPressed: (){

                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      //title: Text('Select City & Village'),
                                      content: Text(
                                        "Please select person 2 whose relation you want to find with person 1" ,                            style: TextStyle(
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
                                icon: Icon(Icons.info_rounded),
                              )
                            ],
                          )
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 40),
              _isUploading ? CircularProgressIndicator() : SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: ElevatedButton(
                  //onPressed: _isUploading ? null : pickAndUploadImage,
                    onPressed: (){
                      if(selectedItem1 != null && selectedItem2 != null){
                        setState(() {
                          _isUploading = true;
                        });
                        findRelationBetween(bhinmal, selectedItem1!, selectedItem2!);

                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF666AC6),
                      foregroundColor: Color(0xffffffff),
                    ),
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Center(
                            child: Text(
                              'Find Realtion',
                              style: TextStyle(
                                fontFamily: 'Outfit',
                                fontSize: 17,
                                color: Color(0xFFFFFFFF),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                ),
              ),
              SizedBox(height: 40),
              reltions.length >= 2 ? reltions[1].contains(
                  "No relation found within 7 levels between $selectedItem1 and $selectedItem2."
              ) ? Container() : Container(
                margin: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
                //padding: EdgeInsets.all(3),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFF666AC6),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: (){
                        if(outputType != 0){
                          setState(() {
                            outputType = 0;
                          });
                        }
                      },
                      icon: Icon(
                        Icons.line_style_rounded,
                        size: outputType == 0 ? 25 : 20 ,
                        color: outputType == 0 ? Colors.yellowAccent : Colors.white,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        if(outputType != 1){
                          setState(() {
                            outputType = 1;
                          });
                        }
                      },
                      icon: Icon(
                        Icons.linear_scale_rounded,
                        size: outputType == 1 ? 25 : 20,
                        color: outputType == 1 ? Colors.yellowAccent : Colors.white,
                      ),
                    ),
                    IconButton(
                      onPressed: (){
                        if(outputType != 2){
                          setState(() {
                            outputType = 2;
                          });
                        }
                      },
                      icon: Icon(
                        Icons.polyline_rounded,
                        size: outputType == 2 ? 25 : 20,
                        color: outputType == 2 ? Colors.yellowAccent : Colors.white,
                      ),
                    )
                  ],
                ),
              ) : Container()
            ],
          );
        }else{
          List<String> splitedRelation = splitAndKeep(reltions[index],
              [selectedItem1!, selectedItem2!, 'fufa', 'हे', 'के', 'chacha','mama', 'mosa', 'sasur ji']);

          if(outputType == 0){
            return Column(
              children: [
                Container(
                    width: MediaQuery.of(context).size.width * 0.92,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Color(0xffdcdeff), Color(0xfff6dcff)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter
                      ),
                      boxShadow: [BoxShadow(
                          color: Color(0xffb6bbff).withOpacity(1),
                          blurRadius: 5,
                          offset: Offset(0.5, 0.5)
                      )],
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Text(
                            selectedItem2?? "",
                            style: GoogleFonts.poppins(
                                color: Colors.deepPurpleAccent,
                                fontWeight: FontWeight.w500,
                                fontSize: 16
                            ),
                          ),
                        ),
                        Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [BoxShadow(
                                  color: Color(0xffffffff).withOpacity(1),
                                  blurRadius: 5,
                                  offset: Offset(0.5, 0.5)
                              )],
                            ),
                            child: Column(
                              children: [
                                ...splitedRelation.asMap().entries.map((entry){
                                  int index= entry.key;
                                  Color textColorType = Color(0xff000485);

                                  Color? textBackColor;
                                  if(index == 0){
                                    if(splitedRelation[0].contains("No relation found within 7 levels between $selectedItem1 and $selectedItem2.")){
                                      return Container(
                                        decoration: BoxDecoration(
                                            color: textBackColor?? Colors.transparent,
                                            borderRadius: BorderRadius.circular(5)
                                        ),
                                        padding: EdgeInsets.all(15),
                                        child: Center(
                                          child: Text(
                                            "❌ No relation found ❌",
                                            style: GoogleFonts.poppins(
                                                color: Color(0xff000485),
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                    return Container();
                                  }else if(index == splitedRelation.length-1 || index == splitedRelation.length-2){
                                    return Container();
                                  }else if(splitedRelation[index].contains("fufa")){
                                    textColorType = Color(0xFF4CAF50);
                                    textBackColor = Color(0xFFE8F5E9);

                                  }else if(splitedRelation[index].contains("mama")){
                                    textColorType = Color(0xFFFFEB3B);
                                    textBackColor = Color(0xFF0D1B2A);

                                  }else if(splitedRelation[index].contains("chacha")){
                                    textColorType = Color(0xFF2196F3);
                                    textBackColor = Color(0xFFE3F2FD);

                                  }else if(splitedRelation[index].contains("mosa")){
                                    textColorType = Color(0xFFFF5722);
                                    textBackColor = Color(0xFFFFEBEE);

                                  }else if(splitedRelation[index].contains("sasur ji")){
                                    textColorType = Color(0xFF3955EF);
                                    textBackColor = Color(0x4F6073DC);

                                  }else if(splitedRelation[index].contains(selectedItem1!)){
                                    textColorType = Color(0xffe06eff);

                                    textBackColor = Color(0xfff6dcff);
                                  }else if(splitedRelation[index].contains(selectedItem2!)){
                                    textColorType = Colors.deepPurpleAccent;

                                    textBackColor = Color(0xffdcdeff);
                                  }

                                  return Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            color: textBackColor?? Colors.transparent,
                                            borderRadius: BorderRadius.circular(5)
                                        ),
                                        padding: EdgeInsets.all(5),
                                        child: Text(
                                          splitedRelation[index],
                                          style: GoogleFonts.poppins(
                                              color: textColorType,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16
                                          ),
                                        ),
                                      ),
                                      splitedRelation[index].contains('के') ?
                                      Divider(
                                        color: Colors.deepPurpleAccent.withOpacity(0.2),
                                        endIndent: 100,
                                        indent: 100,
                                        thickness: 3,
                                      )
                                          :
                                      Container()
                                    ],
                                  );
                                })
                              ],
                            )
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Text(
                            selectedItem1?? "",
                            style: GoogleFonts.poppins(
                                color: Colors.purple,
                                fontWeight: FontWeight.w500,
                                fontSize: 16
                            ),
                          ),
                        ),
                        // SizedBox(
                        //   height: 500, // fixed height required!
                        //   child: InteractiveViewer(
                        //     constrained: false,
                        //     minScale: 0.5,
                        //     maxScale: 2.5,
                        //     boundaryMargin: EdgeInsets.all(100),
                        //     child: SizedBox(
                        //       width: 500,
                        //       height: 500,
                        //       child: Stack(
                        //         children: [
                        //           Positioned(top: 100, left: 50, child: RelationCard(title: 'Scout')),
                        //           Positioned(top: 50, left: 200, child: RelationCard(title: 'Atticus')),
                        //           Positioned(top: 150, left: 200, child: RelationCard(title: 'Jem')),
                        //
                        //           // Draw arrows between them
                        //           CustomPaint(
                        //             painter: ArrowPainter(
                        //               from: Offset(100, 100),
                        //               to: Offset(250, 50),
                        //               curvature: 60,
                        //               curveAxis: Axis.vertical,
                        //               invertCurve: true,
                        //               arrowHeadSize: 17,
                        //               arrowHeadAngle: 0.4,
                        //               glassEffect: true,
                        //               label: "Uncle",
                        //               labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        //               arrowColor: Color(0xffb847ff).withOpacity(0.8),
                        //               glassColor: Color(0xffb847ff).withOpacity(1),
                        //               lineColor: Color(0xffb847ff).withOpacity(0.5)
                        //             ),
                        //           ),
                        //
                        //
                        //
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    )
                ),
                index == reltions.length-1 ? SizedBox(height: 50,)
                    :
                Divider(
                  color: Colors.deepPurpleAccent.withOpacity(0.3),
                  thickness: 3,
                  height: 70,
                  indent: 40,
                  endIndent: 40,
                )
              ],
            );
          }else if(outputType == 1){
            return Container(
              width: double.infinity,
              margin: EdgeInsets.all(15),
              //padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  boxShadow: [BoxShadow(
                      color: Colors.white30,
                      blurRadius: 2,
                      offset: Offset.zero
                  )]
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [

                    ...splitedRelation.asMap().entries.map((entry){
                      int index= entry.key;
                      Color textColorType = Color(0xff000485);
                      int textType;
                      Color? textBackColor;

                      if(splitedRelation[index].contains("हे")){
                        return Container(
                            decoration: BoxDecoration(
                                color: textBackColor?? Colors.transparent,
                                borderRadius: BorderRadius.circular(5)
                            ),
                            padding: EdgeInsets.all(25),
                            //margin: EdgeInsets.all(10),
                            child: Center(
                              child: Text(
                                ">>>",
                                style: GoogleFonts.poppins(
                                    color: textColorType,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16
                                ),
                              ),
                            )
                        );
                      }else if(splitedRelation[index].contains("के")){
                        return Container();
                      }else if(index < splitedRelation.length-2){
                        if(splitedRelation[index].contains(splitedRelation[index+2]))
                          return Container();
                      }

                      if(splitedRelation[index].contains("fufa")){
                        textColorType = Color(0xFF4CAF50);
                        textBackColor = Color(0xFFE8F5E9);
                        textType = 1;
                      }else if(splitedRelation[index].contains("mama")){
                        textColorType = Color(0xFFFFEB3B);
                        textBackColor = Color(0xFF0D1B2A);
                        textType = 2;
                      }else if(splitedRelation[index].contains("chacha")){
                        textColorType = Color(0xFF2196F3);
                        textBackColor = Color(0xFFE3F2FD);
                        textType = 3;
                      }else if(splitedRelation[index].contains("mosa")){
                        textColorType = Color(0xFFFF5722);
                        textBackColor = Color(0xFFFFEBEE);
                        textType = 4;
                      }else if(splitedRelation[index].contains("sasur ji")){
                        textColorType = Color(0xFF3955EF);
                        textBackColor = Color(0x4F6073DC);
                        textType = 2;
                      }else if(splitedRelation[index].contains(selectedItem1!)){
                        textColorType = Color(0xffe06eff);
                        textType = 6;
                        textBackColor = Color(0xfff6dcff);
                      }else if(splitedRelation[index].contains(selectedItem2!)){
                        textColorType = Colors.deepPurpleAccent;
                        textType = 6;
                        textBackColor = Color(0xffdcdeff);
                      }

                      return Container(
                          decoration: BoxDecoration(
                              color: textBackColor?? Colors.transparent,
                              borderRadius: BorderRadius.circular(5)
                          ),
                          padding: EdgeInsets.all(25),
                          //margin: EdgeInsets.all(10),
                          child: Center(
                            child: Text(
                              splitedRelation[index],
                              style: GoogleFonts.poppins(
                                  color: textColorType,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16
                              ),
                            ),
                          )
                      );
                    }),

                    // SizedBox(
                    //   height: 500, // fixed height required!
                    //   child: InteractiveViewer(
                    //     constrained: false,
                    //     minScale: 0.5,
                    //     maxScale: 2.5,
                    //     boundaryMargin: EdgeInsets.all(100),
                    //     child: SizedBox(
                    //       width: 500,
                    //       height: 500,
                    //       child: Stack(
                    //         children: [
                    //           Positioned(top: 100, left: 50, child: RelationCard(title: 'Scout')),
                    //           Positioned(top: 50, left: 200, child: RelationCard(title: 'Atticus')),
                    //           Positioned(top: 150, left: 200, child: RelationCard(title: 'Jem')),
                    //
                    //           // Draw arrows between them
                    //           CustomPaint(
                    //             painter: ArrowPainter(
                    //               from: Offset(100, 100),
                    //               to: Offset(250, 50),
                    //               curvature: 60,
                    //               curveAxis: Axis.vertical,
                    //               invertCurve: true,
                    //               arrowHeadSize: 17,
                    //               arrowHeadAngle: 0.4,
                    //               glassEffect: true,
                    //               label: "Uncle",
                    //               labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    //               arrowColor: Color(0xffb847ff).withOpacity(0.8),
                    //               glassColor: Color(0xffb847ff).withOpacity(1),
                    //               lineColor: Color(0xffb847ff).withOpacity(0.5)
                    //             ),
                    //           ),
                    //
                    //
                    //
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            );
          }else if(outputType == 2 && index == 1){

            indexWiseTextLength.clear();
            graph.clear();

            graphObjectsList(1);

            double positionIng = 0;
            double start = 0;
            Map<String, Map<String, double>> codinates= {};

            return SizedBox(
              height: 500, // fixed height required!
              child: InteractiveViewer(
                constrained: false,
                minScale: 0.1,
                maxScale: 6.5,
                boundaryMargin: EdgeInsets.all(20),
                child: SizedBox(
                  width: indexWiseTextLength[indexWiseTextLength.length-1]*7,
                  height: 100*reltions.length-1,
                  child: Stack(
                    children: [

                      ...graph.asMap().entries.map((entry){
                        int drawIndex = entry.key;
                        start +=50;
                        double fromLeft = start;
                        double fromTop = 50+positionIng*60;
                        double toLeft = start+50;
                        double toTop = 50+positionIng*60;
                        if(entry.value != "End"){
                          if(drawIndex%2 == 0){
                            Color textColorType = Color(0xFF8487CA);
                            Color textBackColor = Colors.white;
                            if(graph[drawIndex].contains(selectedItem1!)){
                              textColorType = Color(0xffe06eff);

                              textBackColor = Color(0xfff5d5ff);
                            }else if(graph[drawIndex].contains(selectedItem2!)){
                              textColorType = Colors.deepPurpleAccent;

                              textBackColor = Color(0xffdcdeff);
                            }
                            if(!codinates.containsKey(graph[drawIndex])){
                              codinates.addAll({graph[drawIndex] : {'fromLeft' : fromLeft, 'fromTop' : fromTop}});
                              return Positioned(
                                  top: fromTop,
                                  left: fromLeft,
                                  child: RelationCard(
                                    title: graph[drawIndex],
                                    textBackColor: textBackColor,
                                    textColorType: textColorType,
                                  ));
                            }
                          }
                        }else{
                          if(drawIndex == graph.length-1){
                            positionIng = -1;
                          }
                          positionIng += 1;
                          start =0;
                          return Container();
                        }
                        return Container();
                      }),


                      ...graph.asMap().entries.map((entry) {
                        int drawIndex = entry.key;

                        if (entry.value != "End") {
                          if (drawIndex % 2 != 0) {
                            final prevKey = graph[drawIndex - 1];
                            final nextKey = graph[drawIndex + 1];


                            // Check if both previous and next entries exist in codinates
                            if (codinates.containsKey(prevKey) && codinates.containsKey(nextKey)) {
                              Color textColorType = Color(0xFF666AC6);
                              Color textBackColor = Color(0xFF666AC6);
                              Color arrowColor = Color(0xFF666AC6);
                              if(graph[drawIndex].contains("fufa")){
                                textColorType = Color(0xFF4CAF50);
                                textBackColor = Color(0xFFC2FBC7);
                                arrowColor = Color(0xFF4CAF50);
                              }else if(graph[drawIndex].contains("mama")){
                                textColorType = Color(0xFFFFEB3B);
                                textBackColor = Color(0xFF0D1B2A);
                                arrowColor = Color(0xFFFFEB3B);
                              }else if(graph[drawIndex].contains("chacha")){
                                textColorType = Color(0xFF2196F3);
                                textBackColor = Color(0xFFB4DFFF);
                                arrowColor = Color(0xFF2196F3);
                              }else if(graph[drawIndex].contains("mosa")){
                                textColorType = Color(0xFFFF5722);
                                textBackColor = Color(0xFFFFA6B2);
                                arrowColor = Color(0xFFFF5722);
                              }else if(graph[drawIndex].contains("sasur ji")){
                                textColorType = Color(0xFF3955EF);
                                textBackColor = Color(0x4F6D85FF);
                                arrowColor = Color(0xFF3955EF);
                              }


                              double fromLeft =50+ codinates[prevKey]!['fromLeft']!;
                              double fromTop = codinates[prevKey]!['fromTop']!;
                              double toLeft = 50+codinates[nextKey]!['fromLeft']!; // not 'toLeft'
                              double toTop = codinates[nextKey]!['fromTop']!;
                              bool curveAxis = false;

                              if(fromTop == toTop && fromLeft < toLeft){
                                toLeft = toLeft - 50;

                                curveAxis=true;
                              }
                              if(fromTop < toTop && fromLeft < toLeft){
                                toLeft = toLeft - 50;
                                fromTop = fromTop + 17;
                                curveAxis=false;
                              }
                              if(fromTop > toTop && fromLeft > toLeft){
                                toTop = toTop + 17;
                                curveAxis=true;
                              }
                              if(fromTop > toTop && fromLeft == toLeft){
                                toTop = toTop + 19;

                                curveAxis=true;
                              }
                              print("$fromLeft   $fromTop   $toLeft   $toTop   ${prevKey}   ${entry.value}   ${nextKey}");
                              return CustomPaint(
                                painter: ArrowPainter(
                                  from: Offset(toLeft, toTop),
                                  to: Offset(fromLeft, fromTop),
                                  curvature: 15,
                                  curveAxis: Axis.vertical,
                                  invertCurve: curveAxis,
                                  arrowHeadSize: 10,
                                  arrowHeadAngle: 0.4,
                                  glassEffect: true,
                                  label: graph[drawIndex],
                                  labelStyle: TextStyle(
                                    color: textColorType,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 8,
                                  ),
                                  arrowColor: arrowColor.withOpacity(0.5),
                                  glassColor: textBackColor.withOpacity(0.4),
                                  lineColor: textBackColor.withOpacity(0.7),
                                ),
                              );
                            } else {
                              // Debugging
                              print("Missing coordinates for $prevKey or $nextKey");
                              return Container();
                            }
                          }
                        } else {
                          positionIng += 1;
                          start = 0;
                        }

                        return Container();
                      }),

                    ],
                  ),
                ),
              ),
            );
          }
        }

      },
    );
  }
}


class ArrowPainter extends CustomPainter {
  final Offset from;
  final Offset to;
  final Color color;
  final double curvature;
  final Axis curveAxis;
  final bool invertCurve;
  final double arrowHeadSize;
  final double arrowHeadAngle;
  final bool reverseArrow;
  final String? label;
  final TextStyle labelStyle;
  final bool glassEffect;
  Color? arrowColor;
  Color? lineColor;
  Color? glassColor;
  ArrowPainter({
    required this.from,
    required this.to,
    this.color = Colors.white,
    this.curvature = 40,
    this.curveAxis = Axis.vertical,
    this.invertCurve = false,
    this.arrowHeadSize = 10,
    this.arrowHeadAngle = 0.5,
    this.reverseArrow = false,
    this.label,
    this.labelStyle = const TextStyle(color: Colors.black, fontSize: 12),
    this.glassEffect = false,
    this.arrowColor ,
    this.glassColor ,
    this.lineColor ,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final start = reverseArrow ? to : from;
    final end = reverseArrow ? from : to;

    // Control point
    final controlPoint = (curveAxis == Axis.vertical)
        ? Offset((start.dx + end.dx) / 2,
        (start.dy + end.dy) / 2 + (invertCurve ? -curvature : curvature))
        : Offset((start.dx + end.dx) / 2 + (invertCurve ? -curvature : curvature),
        (start.dy + end.dy) / 2);

    final path = Path()
      ..moveTo(start.dx, start.dy)
      ..quadraticBezierTo(controlPoint.dx, controlPoint.dy, end.dx, end.dy);

    if (glassEffect) {
      canvas.saveLayer(Rect.largest, Paint());

      // Background blur
      canvas.drawPath(
        path,
        Paint()
          ..imageFilter = ImageFilter.blur(sigmaX: 4, sigmaY: 4)
          ..color = glassColor!
          ..style = PaintingStyle.stroke
          ..strokeWidth = 4,
      );

      // Soft white highlight stroke
      canvas.drawPath(
        path,
        Paint()
          ..color = glassColor!
          ..style = PaintingStyle.stroke
          ..color = lineColor!
          ..strokeWidth = 1.5,
      );

      canvas.restore();
    } else {
      // Normal line
      final paint = Paint()
        ..color = color
        ..strokeWidth = 2
        ..style = PaintingStyle.stroke;
      canvas.drawPath(path, paint);
    }

    _drawArrowHead(canvas, start, end, controlPoint);
    _drawLabel(canvas, start, end);
  }

  void _drawArrowHead(Canvas canvas, Offset start, Offset end, Offset control) {
    // Derivative of quadratic Bézier at t=1 to get tangent vector
    final tangent = (end - control) * 2;
    final angle = atan2(tangent.dy, tangent.dx);

    final path = Path()
      ..moveTo(end.dx, end.dy)
      ..lineTo(
        end.dx - arrowHeadSize * cos(angle - arrowHeadAngle),
        end.dy - arrowHeadSize * sin(angle - arrowHeadAngle),
      )
      ..lineTo(
        end.dx - arrowHeadSize * cos(angle + arrowHeadAngle),
        end.dy - arrowHeadSize * sin(angle + arrowHeadAngle),
      )
      ..close();

    canvas.drawPath(
      path,
      Paint()
        ..color = glassEffect ? arrowColor! : color
        ..style = PaintingStyle.fill,
    );
  }


  void _drawLabel(Canvas canvas, Offset start, Offset end) {
    if (label == null) return;

    final textPainter = TextPainter(
      text: TextSpan(text: label, style: labelStyle),
      textDirection: TextDirection.ltr,
    )..layout();

    final labelOffset = Offset(
      (start.dx + end.dx) / 2 - textPainter.width / 2,
      (start.dy + end.dy) / 2 - textPainter.height - 6,
    );
    textPainter.paint(canvas, labelOffset);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}




class RelationCard extends StatelessWidget {
  final String title;
  final Color textColorType;
  final Color textBackColor;

  const RelationCard({required this.title, required this.textColorType, required this.textBackColor});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(2),
        width: 50,
        decoration: BoxDecoration(
          color: textBackColor,
          border: Border.all(color: textColorType.withOpacity(0.3)),
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(color: textBackColor, blurRadius: 8, offset: Offset(3, 3)),
          ],
        ),
        child: Center(child: Text(title, style: TextStyle(fontSize: 5, color: textColorType, fontWeight: FontWeight.bold)))
    );
  }
}
