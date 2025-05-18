import 'package:pipakshatriya/datamodels/user_model.dart';
import 'package:pipakshatriya/datamodels/relationship.dart';
import 'package:pipakshatriya/datamodels/login_info.dart';
import 'package:pipakshatriya/datamodels/contact.dart';
import 'package:hive/hive.dart';

Future<void> saveUser() async {
  final userBox = Hive.box<UserModel>('userBox');

  final newUser = UserModel(
    name: 'John Doe',
    profilePic: 'https://example.com/profile.jpg',
    fatherName: 'David Doe',
    email: 'john@example.com',
    phoneNumber: '1234567890',
    gotra: 'Bharadwaj',
    address: '123 Main Street, City',
    relationships: [
      Relationship(name: 'Jane Doe', relation: 'Sister'),
      Relationship(name: 'Raj Kumar', relation: 'Uncle'),
    ],
    loginInfo: LoginInfo(
      token: 'some_secure_token_here',
      loginTime: DateTime.now(),
    ),
    contacts: [
      Contact(name: 'Friend A', phone: '9876543210'),
      Contact(name: 'Friend B', phone: '8765432109'),
    ],
  );

  // Save under a specific key
  await userBox.put('currentUser', newUser);
  print("success");
}
