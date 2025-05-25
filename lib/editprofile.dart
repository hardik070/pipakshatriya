import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hive/hive.dart';
import 'package:pipakshatriya/datamodels/user_model.dart';
import 'datamodels/datamanager/data_manager.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';



class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  final List<TextEditingController> _phoneNumbersController = [];


  bool isSaving = false;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController fatherNameController = TextEditingController();
  final TextEditingController gotraController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController currentCityController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  String userId = '';
  String profilePicUrl = '';

  bool statusId= false;

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
    numbers = UserDataManager().currentUser!.phoneNumber;
    relationships = UserDataManager().currentUser!.relationships;

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

  Future<void> pickAndUploadImage() async {

    try {

      pickedFile = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
      if (pickedFile == null) {
        print('No image selected.');
        return;
      }
      setState(() {
        _profileImage = File(pickedFile!.path);
      });
      // Step 2: Create unique file name
      String fileName = basename("${userId}_profilePic");
      Reference storageRef = FirebaseStorage.instance.ref().child('profilePic/$fileName');

      // Step 3: Upload image
      UploadTask uploadTask = storageRef.putFile(_profileImage!);

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
      print(uploadedImageUrl);
      await UserDataManager().updateUserField((user) {
        user.profilePic = uploadedImageUrl!;
      });
      try{
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId).update({
          "profilePic" : uploadedImageUrl
        });
      }catch (e){
        print("\n\n\n\Error to store on firestore : $e");
      }
      setState(() {
        profilePicUrl = uploadedImageUrl!;
      });


    } catch (e) {
      print('Error uploading image: $e');
    }
    statusId = true;
  }

  Future<void> _uploadUserInfoToFirestore() async{

    String name = nameController.text.trim();
    String fatherName = fatherNameController.text.trim();
    String gotra = gotraController.text.trim();
    String city = cityController.text.trim();
    String currentCity = currentCityController.text.trim();
    List<String> numbers = _phoneNumbersController.map((eachNumber) => eachNumber.text).toList();
    List<Map<String, String>> relations = relationships.map((eachRelation) => eachRelation).toList();
    String userid = UserDataManager().currentUser!.userId;

    try{
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userid).update({
        "name" : name,
        "fatherName" : fatherName,
        "gotra" : gotra,
        "actualAddress" : city,
        "currentAddress" : currentCity,
        "relations" : relations,
        "numbers" : numbers,
      });
    }catch (e){
      print("\n\n\n\Error to store on firestore : $e");
    }

    try{
      final user = UserModel(
        name: name,
        fatherName: fatherName,
        email: emailController.text.trim(),
        gotra: gotra,
        actualAddress: city,
        currentAddress: currentCity,
        phoneNumber: numbers,
        relationships: UserDataManager().currentUser!.relationships,
        loginInfo: UserDataManager().currentUser!.loginInfo,
        profilePic: UserDataManager().currentUser!.profilePic,
        contacts: UserDataManager().currentUser!.contacts,
        userId: UserDataManager().currentUser!.userId
      );

      await UserDataManager().updateUser(user);
    }catch (e){
      print(e);
    }

    statusId = true;
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

    for(var controller in _phoneNumbersController){
      controller.dispose();
    }
    super.dispose();
  }

  Future<bool> _showItemDialog(BuildContext context, int indexFromPara, String oldValue) async {
    List<String> fltdlist = reltionTypes;
    String searchQuery = '';
    final result = await showDialog<String>(
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
                        hintText: 'City...',
                        prefixIcon: Icon(Icons.search, color: Color(0xFF23255D)),
                        suffixIcon: _searchController.text.isEmpty
                            ? IconButton(
                          icon: Icon(Icons.info_outline),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                content: Text(
                                  'First select city in which person lives',
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
                              fltdlist = reltionTypes;
                            });
                          },
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          searchQuery = value.trim().toLowerCase();
                          fltdlist = reltionTypes
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
                            onTap: () {
                              relationships[indexFromPara] = {reltionTypes[index]: oldValue};
                              Navigator.of(context).pop(fltdlist[index]);
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
    return true;
  }


  @override
  Widget build(BuildContext context) {
    return PopScope<Object?>(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        Navigator.pop(context, true);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        //resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Color(0xFF23255D),
          leading: InkWell(
            onTap: () {
              Navigator.pop(context, statusId); // Indicate no changes
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
                        await pickAndUploadImage();
                      },
                      child: SizedBox(
                          height: 120,
                          width: 120,
                          child: Stack(
                            children: [
                              _profileImage == null ?
                              ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: CachedNetworkImage(
                                  imageUrl: profilePicUrl,
                                  placeholder: (context, url) => CircleAvatar(
                                    radius: 60,
                                    backgroundImage: _profileImage != null ? FileImage(_profileImage!) : null,
                                    child: _profileImage != null ? null : Icon(Icons.person, size: 60, color: Color(0xFF666AC6)),
                                  ),

                                  errorWidget: (context, url, error) => CircleAvatar(
                                    radius: 60,
                                    child: Icon(Icons.error, size: 60, color: Color(0xFF666AC6)),
                                  ),
                                  fit: BoxFit.cover,
                                  width: 120,
                                  height: 120,
                                ),
                              )
                                  :
                              CircleAvatar(
                                radius: 60,
                                backgroundImage: _profileImage != null ? FileImage(_profileImage!) : null,
                                child: _profileImage != null ? null : Icon(Icons.person, size: 60, color: Color(0xFF666AC6)),
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
                pickedFile != null ?
                LinearProgressIndicator(
                  value: _uploadProgress, // between 0 and 1
                  minHeight: 6,
                  backgroundColor: Color(0xFFB3B5EF),
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF666AC6),),
                ) :
                Container(),
                SizedBox(height: 20,),
                //Divider(color: Color(0x54002785), thickness: 1, height: 20),
                textBox("Name", Icons.person_rounded, TextInputType.name, nameController, 20),
                SizedBox(height: 15,),
                //Divider(color: Color(0x54002785), thickness: 1, height: 20),
                textBox("E-mail", Icons.email_rounded, TextInputType.emailAddress, emailController, 30),
                SizedBox(height: 15,),
                //Divider(color: Color(0x54002785), thickness: 1, height: 20),
                textBox("Father name", Icons.account_circle_rounded, TextInputType.text, fatherNameController, 20),
                SizedBox(height: 15,),
                //Divider(color: Color(0x54002785), thickness: 1, height: 20),
                textBox("Gotra", Icons.temple_hindu_rounded, TextInputType.text, gotraController, 20),
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
                textBox("Address", Icons.location_city_rounded, TextInputType.text, cityController, 20),
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
                textBox("Current living address", Icons.location_history, TextInputType.text, currentCityController, 20),
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
                                    child: textBox("Number${index+1}", Icons.phone, TextInputType.phone, controller, 10),
                                  ),


                                  const SizedBox(width: 10),

                                  /// Delete Button
                                  IconButton(
                                    icon: const Icon(Icons.close_rounded, color: Colors.black54, size: 30),
                                    onPressed: () => _deleteOption(index, controller),
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
                                      await _showItemDialog(context ,index, indexMapValues.values.first);
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
                                            "${indexMapValues.keys.first}",
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
                                        onTap: () {},
                                        child: Container(
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
                                                "${indexMapValues.values.first}",
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
                                    Navigator.pop(context, statusId);
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

                      print(UserDataManager().currentUser?.profilePic ?? "hello");
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
  Widget textBox(String hint, final prefixIcon, final inputType, TextEditingController controller, int maxLength) {
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
        suffixIcon: controller == cityController ||
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
      readOnly: controller == emailController ? true : false,
      keyboardType: inputType,
    );
  }



}
