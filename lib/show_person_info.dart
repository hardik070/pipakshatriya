import 'package:flutter/material.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          children: [
            // Profile Picture & Send Message
            Center(
              child: Column(
                children: [
                  Stack(
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
                      const CircleAvatar(
                        radius: 55,
                        backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=4'),
                      ),
                    ],
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
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Name & Gotra
            const Text(
              'Rahul Pipakshatriya',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF23255D),
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              "Gotra: Parmar",
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF666AC6),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),

            // Personal Info
            _buildCardSection('Personal Info', const [
              ProfileField(label: 'Father Name', value: 'Ramesh Pipakshatriya', icon: Icons.person,),
              ProfileField(label: 'Current City', value: 'Mumbai', icon: Icons.location_city_rounded,),
              ProfileField(label: 'Actual City', value: 'Jamnagar', icon: Icons.location_history,),
            ]),

            const SizedBox(height: 20),

            // Contact List
            _buildCardSection('Contact List', const [
              ProfileField(label: 'Amit Sharma', value: '+91 9876543210', icon: Icons.call,),
              ProfileField(label: 'Suresh Mehta', value: '+91 9123456780', icon: Icons.call,),
              ProfileField(label: 'Pooja Patel', value: '+91 9012345678', icon: Icons.call,),
            ]),

            const SizedBox(height: 20),

            // Relations Map
            _buildCardSection('Relations Map', [
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 4,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 3 / 2,
                ),
                itemBuilder: (context, index) {

                  return GestureDetector(
                    onTap: () {
                      // Navigate to relation details
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF9F9F9),
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
                            radius: 24,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text('Amit Verma', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                                Text('Cousin', style: TextStyle(fontSize: 12, color: Colors.black54)),
                                Text('Delhi', style: TextStyle(fontSize: 11, color: Colors.black45)),
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
                      color: Color(0xFF474A98),
                    ),
                  ),
                  TextSpan(
                    text: value,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
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