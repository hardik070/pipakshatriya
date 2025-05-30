import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ShowPersonInfo extends StatefulWidget{
  final String userId;
  final String city;
  const ShowPersonInfo({super.key, required this.userId, required this.city});

  @override
  State<ShowPersonInfo> createState() => _ShowPersonInfo();
}
class _ShowPersonInfo extends State<ShowPersonInfo> {

  bool isDataLoading = true;
  Map<String, dynamic>? userInfo;

  @override
  void initState(){
    super.initState();
    _getUserInfo();
  }

  Future<void> _getUserInfo() async{
    try{
      DocumentSnapshot userData = await FirebaseFirestore.instance
                                  .collection("EngAddress")
                                  .doc("CitysData")
                                  .collection(widget.city)
                                  .doc(widget.userId)
                                  .get();
      userInfo = userData.data() as Map<String, dynamic>?;

      setState(() {
        isDataLoading = false;
      });
    }catch (e){
      setState(() {
        isDataLoading = false;
      });
    }
  }

  void _showImageFullScreen() async{
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
                        imageUrl: userInfo!['profilePic'] ?? ''
                    ),
                  )
                );
              }
          );
        }
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFDFD), // Soft white background
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Color(0xFF23255D),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: isDataLoading ? Center(child: CircularProgressIndicator(),)
          :
      SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Profile Picture & Send Message
            GestureDetector(
              onTap: () {
                if(userInfo?['profilePic'] != null){
                  _showImageFullScreen();
                }
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [Color(0xfffffb00), Color(0xFF666AC6)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: CachedNetworkImage(
                      imageUrl: userInfo?['profilePic'] ?? "",
                      placeholder: (context, url) =>const CircleAvatar(
                          radius: 60,
                          //backgroundImage: uploadedImageUrl != null ? FileImage(_profileImage!) : null,
                          child: Icon(Icons.person, size: 40, color: Color(0xFF666AC6))
                      ),
                      errorWidget: (context, url, error) =>const CircleAvatar(
                        radius: 60,
                        //backgroundImage: _profileImage != null ? FileImage(_profileImage!) : null,
                        child: Icon(Icons.person, size: 40, color: Color(0xFF666AC6)),
                      ),
                      fit: BoxFit.cover,
                      width: 112,
                      height: 112,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Container(
              width: 160,
              height: 45,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xffffc107), Color(0xFF666AC6)],
                ),
                borderRadius: BorderRadius.circular(30),
              ),
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.send),
                label: const Text('Message'),
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.white,
                  shadowColor: Colors.transparent,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Name & Gotra
            Text(
              userInfo?['name'] ?? "",
              style:const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF23255D),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              (userInfo?['gotra'] ?? "").trim(),
              style:const TextStyle(
                fontSize: 16,
                color: Color(0xFF666AC6),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),

            // Personal Info
            _buildCardSection('Personal Info', [
              ProfileField(label: 'Father Name', value: userInfo?['fatherName'] ?? '', icon: Icons.person,),
              ProfileField(label: 'Current City', value: userInfo?['currentAddress'] ?? '', icon: Icons.location_city_rounded,),
              ProfileField(label: 'Actual City', value: userInfo?['actualAddress'] ?? '', icon: Icons.location_history,),
            ]),

            const SizedBox(height: 20),

            // Contact List

            _buildCardSection('Contact List', [
              ...(userInfo?['numbers']??[]).asMap().entries.map((number){
                print(number);
                return ProfileField(label: 'No.${number.key+1}', value: number.value, icon: Icons.call,);
              }).toList(),
            ]),

            const SizedBox(height: 20),

            // Relations Map
            _buildCardSection('Relations Map', [
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: (userInfo?['relations'] ?? []).length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 3 / 1.8,
                ),
                itemBuilder: (context, index) {
                  final indexMapValues = (userInfo!['relations'])[index];
                  String name = indexMapValues.values.first;
                  final onlyName = name.split("(S-o)");

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

                  return GestureDetector(
                    onTap: () {
                      // Navigate to relation details
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: textBackColor,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(color: Colors.black12, blurRadius: 3, offset: Offset(0, 2)),
                        ],
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            backgroundImage: NetworkImage('https://firebasestorage.googleapis.com/v0/b/pipa-kshatriya-darji-samaj.appspot.com/o/profilePic%2Fpipa_kshatriya_darji_profilePic?alt=media&token=83ab1401-dc87-4313-86df-946fb677ea3a'),
                            radius: 20,
                          ),
                          const SizedBox(width: 7),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(onlyName[0], style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: textColorType)),
                                Text(indexMapValues.keys.first, style: TextStyle(fontSize: 12, color: textColorType)),
                                Text('Delhi', style: TextStyle(fontSize: 11, color: textColorType)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ]),

          ],
        ),
      ),
    );
  }

  Widget _buildCardSection(String title, List<Widget> children) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFF666AC6),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          ...children,
        ],
      ),
    );
  }
}
class ProfileField extends StatelessWidget {
  final String label;
  final String value;
  final IconData? icon;

  const ProfileField({
    super.key,
    required this.label,
    required this.value,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F6FA),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null)
            Icon(icon, size: 20, color: const Color(0xFF3D5AFE)),
          if (icon != null) const SizedBox(width: 10),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 14),
                children: [
                  TextSpan(
                    text: '$label: ',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Color(0xBD474A98),
                      fontSize: 15
                    ),
                  ),
                  TextSpan(
                    text: value,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color:  Color(0xFF474A98),
                      fontSize: 15
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}