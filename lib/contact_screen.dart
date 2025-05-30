import 'package:flutter/material.dart';
import 'helper_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'show_person_info.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreen();

}

class _ContactScreen extends State<ContactScreen> {
  bool language = true;
  bool contactScreenState = false;
  bool cityPeopleIsLoading = false;
  late String lastCity = '';
  List<dynamic> citysList = [];
  List<dynamic> filteredCitysList = [];
  List<dynamic> cityPeopleList = [];
  List<dynamic> filteredCityPeoplesList = [];
  String city = '';
  String person = '';

  final TextEditingController _citysearchController = TextEditingController();
  final TextEditingController _peoplesearchController = TextEditingController();
  final FocusNode _cityFocusNode = FocusNode();
  final FocusNode _peopleFocusNode = FocusNode();

  //for citys list geting
  Future<void> _fatchCitys() async{
    final DocumentReference engAddress = FirebaseFirestore.instance.collection('EngAddress').doc('CitysData');
    final DocumentReference hiAddress = FirebaseFirestore.instance.collection('HiAddress').doc('GaonData');

    if(language){
      DocumentSnapshot cityDataDoc = await engAddress.get();

      final Map<String, dynamic> cityData = cityDataDoc.data() as Map<String, dynamic>;
      citysList = cityData.keys.toList();
      setState(() {
        filteredCitysList = citysList;
      });
    }else {
      DocumentSnapshot cityDataDoc = await hiAddress.get();
      final Map<String, dynamic> cityData = cityDataDoc.data() as Map<String, dynamic>;
      citysList = cityData.keys.toList();
      setState(() {
        filteredCitysList = citysList;
      });
    }
  }

  //for city peoples list getting
  Future<void> _fatchCitysPeople(String city) async{

    final DocumentReference engAddress = FirebaseFirestore.instance
        .collection('EngAddress')
        .doc('SaveReadPeople')
        .collection('PeoplesList')
        .doc(city);
    final DocumentReference hiAddress = FirebaseFirestore.instance
        .collection('HiAddress')
        .doc('SaveReadPeople')
        .collection('PeoplesList')
        .doc(city);

    if(language){
      DocumentSnapshot cityPeoplesDataDoc = await engAddress.get();
      final Map<String, dynamic> cityPeoplesData = cityPeoplesDataDoc.data() as Map<String, dynamic>;
      cityPeopleList = cityPeoplesData['peoples'];
      setState(() {
        filteredCityPeoplesList = cityPeopleList;
        cityPeopleIsLoading = false;
      });
    }else {
      DocumentSnapshot cityPeoplesDataDoc = await hiAddress.get();
      final Map<String, dynamic> cityPeoplesData = cityPeoplesDataDoc.data() as Map<String, dynamic>;
      cityPeopleList = cityPeoplesData['peoples'];
      setState(() {
        filteredCityPeoplesList = cityPeopleList;
        cityPeopleIsLoading = false;
      });
    }
  }


  @override
  void initState(){
    _fatchCitys();
    super.initState();
  }

  @override
  void dispose() {

    _citysearchController.dispose;
    super.dispose();
  }



  @override
  Widget build(BuildContext context){

    return SafeArea(
      child: Column(
          children: [
            Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 20, top: 5),
                      child: TextFormField(
                        focusNode: contactScreenState ? _peopleFocusNode : _cityFocusNode,
                        controller: contactScreenState ? _peoplesearchController : _citysearchController,
                        autofocus: false,
                        textInputAction: TextInputAction.search,
                        obscureText: false,
                        decoration: InputDecoration(
                          isDense: true,
                          hintText: contactScreenState ? "Name" : "City",
                          hintStyle: TextStyle(color: Colors.white70),
                          labelStyle: TextStyle(
                            fontFamily: 'Inter',
                            letterSpacing: 0.0,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(25.0),
                              bottomRight: Radius.circular(25.0),
                              topLeft: Radius.circular(25.0),
                              topRight: Radius.circular(25.0),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(25.0),
                              bottomRight: Radius.circular(25.0),
                              topLeft: Radius.circular(25.0),
                              topRight: Radius.circular(25.0),
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(25.0),
                              bottomRight: Radius.circular(25.0),
                              topLeft: Radius.circular(25.0),
                              topRight: Radius.circular(25.0),
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(25.0),
                              bottomRight: Radius.circular(25.0),
                              topLeft: Radius.circular(25.0),
                              topRight: Radius.circular(25.0),
                            ),
                          ),
                          filled: true,
                          fillColor: Color(0xEF23255D),
                          prefixIcon: IconButton(
                            onPressed: (){
                              setState(() {
                                contactScreenState = false;
                                cityPeopleIsLoading = false;
                              });
                            },
                            icon: Icon(
                              contactScreenState ? Icons.arrow_back_ios_new_rounded : Icons.search_rounded,
                              size: 25.0,
                            ),
                            color: Colors.white,
                          ),
                          suffixIcon: contactScreenState ? _peoplesearchController.text.isEmpty? null : IconButton(
                            onPressed: () {
                              _peoplesearchController.clear();
                              _peopleFocusNode.unfocus();

                              setState(() {
                                filteredCityPeoplesList = cityPeopleList;
                              });
                            },
                            icon: const Icon(Icons.close_rounded),
                            color: Colors.purpleAccent,
                          )
                              :
                          _citysearchController.text.isEmpty? null : IconButton(
                            onPressed: () {
                              _citysearchController.clear();
                              _cityFocusNode.unfocus();
                              // searchQuery= '';
                              setState(() {
                                filteredCitysList = citysList;
                              });
                            },
                            icon: const Icon(Icons.close_rounded),
                            color: Colors.purpleAccent,
                          ),
                        ),
                        onChanged: (value) {

                          if(contactScreenState){
                            setState(() {

                              filteredCityPeoplesList = cityPeopleList
                                  .where((item) => item.toLowerCase().contains(_peoplesearchController.text.trim().toLowerCase()))
                                  .toList();
                            });
                          }else {
                            setState(() {

                              filteredCitysList = citysList
                                  .where((item) => item.toLowerCase().contains(_citysearchController.text.trim().toLowerCase()))
                                  .toList();
                            });
                          }
                        },
                        style: TextStyle(
                          fontFamily: 'Inter',
                          letterSpacing: 0.0,
                          color: Colors.white,
                        ),
                        maxLength: 20,
                        //maxLengthEnforcement: MaxLengthEnforcement.enforced,
                        buildCounter: (context,
                            {required currentLength, required isFocused, maxLength}) =>
                        null,
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  GestureDetector(
                      onTap: (){

                      },
                      child: Container(
                          margin: EdgeInsets.only(right: 20, top: 5),
                          padding: EdgeInsets.all(3),
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Color(0xFF8C52FF),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50),
                                bottomLeft: Radius.circular(50),
                                topRight: Radius.circular(50),
                                bottomRight: Radius.circular(50),
                              )
                          ),
                          child: const Align(
                              alignment: AlignmentDirectional(0.0,0.0),
                              child: Icon(
                                Icons.contacts_rounded,
                                color: Colors.white,
                              )
                          )
                      )

                  )
                ]
            ),
            filteredCitysList.isEmpty ? Expanded(child: Center(child: CircularProgressIndicator()))
                :
            Expanded(
                child: IndexedStack(
                  index: contactScreenState ? 1 : 0,
                  children: [
                    ListView.builder(
                      itemCount: filteredCitysList.length,
                      cacheExtent: 50000,
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 13),
                      itemBuilder: (context, index) {

                        return GestureDetector(
                          onTap: ()async{

                            if(contactScreenState != true){
                              setState(() {
                                contactScreenState = true;
                              });

                              if(lastCity != filteredCitysList[index]){
                                cityPeopleIsLoading = true;
                                lastCity = filteredCitysList[index];
                                city = filteredCitysList[index];
                                _fatchCitysPeople(filteredCitysList[index]);
                              }
                            }

                          },
                          child: CityTile(city: filteredCitysList[index] ,state: language ? "Rajasthan" : "राजस्थान"),
                        );
                      },
                    ),
                    cityPeopleIsLoading ? Center(child: CircularProgressIndicator(),)
                        :
                    PopScope<Object?>(
                      canPop: false,
                      onPopInvokedWithResult: (bool didPop, Object? result) async {
                        setState(() {
                          contactScreenState = false;
                        });
                      },
                      child: ListView.builder(
                        itemCount: filteredCityPeoplesList.length,
                        cacheExtent: 50000,
                        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 13),
                        itemBuilder: (context, index) {
                          String person1 ='';
                          String person2='';
                          String fullName= filteredCityPeoplesList[index];

                          List<String> parts = language ? fullName.split("(S-o)") : fullName.split("(पुत्र)");
                          person1 = parts[0].trim(); // "Mr Shantilal ji"
                          person2= parts.length > 1 ? parts[1].trim() : "";
                          return GestureDetector(
                            onTap: ()async{
                              person = filteredCityPeoplesList[index];
                              //_fatchPersonInfo(city, person);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ShowPersonInfo(userId: filteredCityPeoplesList[index], city: city)
                                )
                              );
                            },
                            child: CityTile(city: person1 ,state: person2),
                          );
                        },
                      ),
                    ),
                  ],
                )
            )
          ],
        )
    );
  }
}
