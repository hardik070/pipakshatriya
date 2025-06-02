import 'package:flutter/material.dart';
import 'package:pipakshatriya/datamodels/datamanager/data_manager.dart';
import 'package:pipakshatriya/editprofile.dart';
import 'community_screen.dart';
import 'contact_screen.dart';
import 'relation_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'profilescreen.dart';
import 'communitydiscover.dart';


class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _Dashboard();

}

class _Dashboard extends State<Dashboard> {
  int _selectedIndex = 0;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(UserDataManager().currentUser!.relationships.isEmpty
          || UserDataManager().currentUser!.name.isEmpty
          || UserDataManager().currentUser!.fatherName.isEmpty
          || UserDataManager().currentUser!.gotra.isEmpty
          || UserDataManager().currentUser!.actualAddress.isEmpty
          || UserDataManager().currentUser!.currentAddress.isEmpty
          || UserDataManager().currentUser!.phoneNumber.isEmpty
          || UserDataManager().currentUser!.profilePic.isEmpty){
        _loadProfileFillComponent();
      }
    });

  }

  void _loadProfileFillComponent() async{
    await Future.delayed(
      Duration(milliseconds: 5000),(){
        _showItemDialog();
      }
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<bool> _showItemDialog() async {

    await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              insetPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              content: SizedBox(
                height: 100,
                width: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Your profile is incomplete", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("Skip"),
                        ),
                        ElevatedButton(onPressed: (){
                          Navigator.of(context).pop();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => EditProfile()
                            )
                          );
                        }, child: Text("Complete now"))
                      ],
                    )
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

  final List<Widget> _screens = [

    ContactScreen(),
    CommunityMessage(),
    ItemSelectionScreen(),
    ProfileManage()
  ];

  @override
  Widget build(BuildContext context){
    return Scaffold(
        resizeToAvoidBottomInset: false,

        appBar: _selectedIndex == 3 ? null : AppBar(
          title: Text(
            "👋 Hy hardik",
            style: GoogleFonts.montserrat(
              //color: Color(0xfffffb00),
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF666AC6),
            ),
          ),
          //centerTitle: true,
          actions: [
            GestureDetector(
              onTap: () {},
              child: const Icon(Icons.notifications_active, color: Color(0xFF666AC6),),
            ),
            const SizedBox(width: 20,),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CommunityDiscovery()
                  )
                );
              },
              child: Icon(
                Icons.message,
                color: Color(0xFF666AC6),
              ),
            ),
            const SizedBox(width: 25)
          ],
        ),
        body: IndexedStack(
          index: _selectedIndex,
          children: _screens,
        ),
        bottomNavigationBar: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: SizedBox(
            height: 80,
            child: BottomNavigationBar(
              currentIndex: _selectedIndex,
              backgroundColor: Color(0xFF23255D),
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Color(0xfffffb00),
              unselectedItemColor: Colors.white70,
              onTap: _onItemTapped,
              items: [
                const BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: "Home"),
                const BottomNavigationBarItem(icon: Icon(Icons.connect_without_contact_rounded), label: "Community"),
                const BottomNavigationBarItem(icon: Icon(Icons.people_outline_rounded), label: "Relation"),
                const BottomNavigationBarItem(icon: Icon(Icons.person_rounded), label: "Profile"),
              ],
            ),
          ),
        ),

    );
  }
}


