import 'package:hive/hive.dart';
import 'relationship.dart';
import 'login_info.dart';
import 'contact.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String profilePic;

  @HiveField(2)
  String fatherName;

  @HiveField(3)
  String email;

  @HiveField(4)
  List<String> phoneNumber;

  @HiveField(5)
  String gotra;

  @HiveField(6)
  String actualAddress;

  @HiveField(7)
  List<Map<String, String>> relationships;

  @HiveField(8)
  LoginInfo loginInfo;

  @HiveField(9)
  List<Contact> contacts;

  @HiveField(10)
  String currentAddress;

  @HiveField(12)
  String userId;

  UserModel({
    required this.name,
    required this.profilePic,
    required this.fatherName,
    required this.email,
    required this.phoneNumber,
    required this.gotra,
    required this.actualAddress,
    required this.relationships,
    required this.loginInfo,
    required this.contacts,
    required this.currentAddress,
    required this.userId
  });
}
