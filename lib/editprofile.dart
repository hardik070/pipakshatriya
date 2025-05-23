import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'datamodels/datamanager/data_manager.dart';
import 'package:intl/intl.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  bool gender = false;
  final List<TextEditingController> _phoneNumbersController = [];



  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController fatherNameController = TextEditingController();
  final TextEditingController gotraController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController currentCityController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  List<String> numbers = ["9982875922", "8696282986"];
  List<String> reltionTypes = ["Mama", "Fufa", "Chacha", "Mosa", "Sala", "Sasur", "Sadu", ];
  List<Map<String, String>> relationships = [{"Mama" : "Hardikkumar"},{"Mama" : "Shayam kumar"}, {"Chacha" : "Mohan lal"}, {"Fufa" : "Ravi Kumar"}];


  @override
  void initState() {
    super.initState();
    createNumberController();
  }

  void createNumberController() {
    if(numbers.isNotEmpty){
      for(var item in numbers){
        _phoneNumbersController.add(TextEditingController(text: item));
      }
    }else {
      _phoneNumbersController.add(TextEditingController());
      _phoneNumbersController.add(TextEditingController());
    }
  }

  void _addContactNumber() {
    setState(() {
      _phoneNumbersController.add(TextEditingController());
    });
  }

  void _addRelationMakingTile() {
    setState(() {
      relationships.add({"Select" : "Select person"});
    });
  }

  void _deleteRelation(int index) {
    setState(() {
      relationships.removeAt(index);
    });
  }

  /// Delete an option at a given index
  void _deleteOption(int index) {
    setState(() {
      _phoneNumbersController.removeAt(index);
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

  Future<bool> _showItemDialog(int indexFromPara, String oldValue) async {
    List<String> fltdlist = reltionTypes;
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
                              fltdlist = reltionTypes;
                            });
                          },
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          searchQuery = value.trim().toLowerCase();
                          fltdlist = reltionTypes
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
                              relationships[indexFromPara] = {reltionTypes[index] : oldValue};
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
    return Scaffold(
      backgroundColor: Colors.white,
      //resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Color(0xFF23255D),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context, false); // Indicate no changes
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
                  onTap: () {

                  },
                  child: SizedBox(
                      height: 120,
                      width: 120,
                      child: Stack(
                        children: [
                          Icon(
                            Icons.account_circle_outlined,
                            size: 120,
                            color: Color(0xFF666AC6),
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
              SizedBox(height: 20,),
              //Divider(color: Color(0x54002785), thickness: 1, height: 20),
              textBox("Name", Icons.person_rounded, TextInputType.name, nameController, 20),
              SizedBox(height: 15,),
              //Divider(color: Color(0x54002785), thickness: 1, height: 20),
              textBox("E-mail", Icons.email_rounded, TextInputType.emailAddress, emailController, 30),
              SizedBox(height: 15,),
              //Divider(color: Color(0x54002785), thickness: 1, height: 20),
              textBox("Father name", Icons.account_circle_rounded, TextInputType.phone, fatherNameController, 10),
              SizedBox(height: 15,),
              //Divider(color: Color(0x54002785), thickness: 1, height: 20),
              textBox("Gotra", Icons.temple_hindu_rounded, TextInputType.text, gotraController, 20),
              SizedBox(height: 15,),
              //Divider(color: Color(0x54002785), thickness: 1, height: 20),
              textBox("Address", Icons.location_city_rounded, TextInputType.text, cityController, 20),
              SizedBox(height: 15,),
              textBox("Current living address", Icons.location_history, TextInputType.text, currentCityController, 20),
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
                                onPressed: () => _deleteOption(index),
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
                                _addRelationMakingTile();
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
                                    await _showItemDialog(index, indexMapValues.values.first);
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
                                    child: Icon(Icons.delete),
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
              ElevatedButton(
                  onPressed: (){},
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
    );
  }

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
        filled: true,
        fillColor: const Color(0xFFF1F4F8),
        counterText: '',
      ),
      maxLength: maxLength,
      readOnly: controller == emailController ? true : false,
      keyboardType: inputType,
    );
  }



}
