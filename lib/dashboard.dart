import 'package:flutter/material.dart';
import 'community screen.dart';
import 'contact screen.dart';
import 'relation screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'profilescreen.dart';
import 'communitydiscover.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _Dashboard();

}

class _Dashboard extends State<Dashboard> {

  int _selectedIndex = 3;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _screens = [

    Center(child: ContactScreen()),
    Center(child: CommunityMessage()),

    Center(child: ItemSelectionScreen()),
    Center(child: profileManage()),
  ];

  @override
  Widget build(BuildContext context){
    return Scaffold(
        resizeToAvoidBottomInset: false,

        appBar: _selectedIndex == 3 ? null : AppBar(
          // leading: Card(
          //
          //   color: Colors.deepOrange,
          //   child: Icon(Icons.search),
          // ),
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
            const Icon(Icons.notifications_active, color: Color(0xFF666AC6),),
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


